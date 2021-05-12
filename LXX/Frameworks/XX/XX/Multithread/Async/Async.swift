//
//  Async.swift
//  XX
//
//  Created by lben on 2021/2/8.
//

import Foundation

/// Thread
public struct Async {
    public typealias Back = () -> Void
    
    @discardableResult
    public static func main(_ closure: @escaping Back) -> Self.Type {
        guard !Thread.isMainThread else { closure(); return self }
        DispatchQueue.main.async {
            closure()
        }
        return self
    }

    @discardableResult
    public static func global(_ closure: @escaping Back) -> Self.Type {
        guard Thread.isMainThread else { closure(); return self }
        DispatchQueue.global().async {
            closure()
        }
        return self
    }

    @discardableResult
    public static func after(_ duration: Double, in queue: DispatchQueue = .main, _ execute: @escaping () -> Void) -> Self.Type {
        queue.asyncAfter(deadline: .now() + DispatchTimeInterval.milliseconds(Int(duration * 1000)), execute: execute)
        return self
    }

    public static func onResult(_ result: (Result<Void, Error>) -> Void) {
    }

    func test() {
        Async
            .main {
                print("123")
            }
            .global {
            }
            .after(10) {
            }
            .onResult { result in
                switch result {
                case .success: break
                case let .failure(error): print(error)
                }
            }
    }

    private static let queue = DispatchQueue(label: "com.onething.serial.queue")
    public static func serial(_ closure: @escaping Back) {
        guard !DispatchQueue.isCurrent(queue) else { closure(); return }
        queue.async {
            closure()
        }
    }

    // MARK: - Once

    private static var _onceTracker = [String]()
    static func once(file: String = #file,
                     function: String = #function,
                     line: Int = #line,
                     closure: () -> Void) {
        let token = "\(file):\(function):\(line)"
        once(token: token, closure: closure)
    }

    static func once(token: String,
                     closure: () -> Void) {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        guard !_onceTracker.contains(token) else { return }
        _onceTracker.append(token)
        closure()
    }

    // MARK: - Times

    private static var _timesTracker = [String: Int]()
    static func retry(_ times: Int, token: String, execute closure: @escaping (_ retry: @escaping () -> Void, _ end: @escaping () -> Void) -> Void) {
        let retry = {
            objc_sync_enter(self)
            defer { objc_sync_exit(self) }
            var count = _timesTracker[token] ?? 0
            guard count < times else {
                _timesTracker.removeValue(forKey: token)
                return
            }
            count += 1
            _timesTracker[token] = count
            Async.retry(times, token: token, execute: closure)
        }

        let end = {
            objc_sync_enter(self)
            defer { objc_sync_exit(self) }
            _ = _timesTracker.removeValue(forKey: token)
        }

        guard _timesTracker[token] != nil else {
            retry()
            return
        }

        global {
            closure(retry, end)
        }
    }
}

func testRetry() {
    var count: Int = 0

    Async.retry(5, token: "com.lben.retry") { retry, end in
        if count < 3 {
            Async.after(1.0, retry)
        } else {
            Async.after(1.0, end)
        }
        count += 1
    }
}
