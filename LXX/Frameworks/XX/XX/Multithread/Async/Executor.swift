//
//  Executor.swift
//  XX
//
//  Created by lben on 2021/2/9.
//

import Foundation
public class Executor<R> {
    public typealias ExecutiveBody = (@escaping (R) -> Void) -> Void

    let body: ExecutiveBody

    enum Action {
        case main(body: () -> R)
        case global(body: () -> R)
        case after(interval: DispatchTimeInterval, body: () -> R)
    }

    init(action: Action) {
        switch action {
        case let .main(body):
            self.body = { complete in
                DispatchQueue.main.async {
                    let res = body()
                    complete(res)
                }
            }
        case let .global(body):
            self.body = { complete in
                DispatchQueue.global().async {
                    let res = body()
                    complete(res)
                }
            }
        case let .after(interval, body):
            self.body = { complete in
                DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
                    let res = body()
                    complete(res)
                }
            }
        }
    }

    private init(body: @escaping ExecutiveBody) {
        self.body = body
    }

    func execute(action: Action) -> Executor {
        let _body = body
        return Executor { left in
            switch action {
            case let .main(exe):
                _body({ res in
                    DispatchQueue.main.async {
                        exe()
                        left(res)
                    }
                })
            case let .global(exe):
                _body({ res in
                    DispatchQueue.global().async {
                        exe()
                        left(res)
                    }
                })
            case let .after(interval, exe):
                _body({ res in
                    DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
                        exe()
                        left(res)
                    }
                })
            }
        }
    }

    @discardableResult
    public func run() -> Executor {
        body({ _ in })
        return self
    }

    @discardableResult
    public func main(_ exe: @escaping () -> R) -> Executor {
        return execute(action: .main(body: exe))
    }

    @discardableResult
    public func global(_ exe: @escaping () -> R) -> Executor {
        return execute(action: .global(body: exe))
    }

    @discardableResult
    public func after(interval: DispatchTimeInterval, _ exe: @escaping () -> R) -> Executor {
        return execute(action: .after(interval: interval, body: exe))
    }

//    public func delay(interval: DispatchTimeInterval) -> Executor {
//        return execute(action: .after(interval: interval, body: {} ))
//    }
}

public
struct Command {
    @discardableResult
    public static func global<R>(_ exe: @escaping () -> R) -> Executor<R> {
        return Executor(action: .global(body: exe))
    }

    @discardableResult
    public static func main<R>(_ exe: @escaping () -> R) -> Executor<R> {
        return Executor(action: .main(body: exe))
    }
}
