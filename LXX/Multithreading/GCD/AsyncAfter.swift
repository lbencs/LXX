//
//  AfterAsync.swift
//  LXX
//
//  Created by lben on 2021/2/24.
//

import Foundation

/**
 1. 执行一个after任务
 2. 可以被取消
 3. 可以被替换为另一个任务
 */

protocol Exchangable {
    func cancel()
    func exchange(_ delayTime: TimeInterval, _ exchangedTask: @escaping (() -> Void))
}

class AsyncAfter {
    @discardableResult
    static func delay(_ delayTime: TimeInterval, _ task: @escaping () -> Void) -> Exchangable {
        var continueAble: Bool = true

        let executor = {
            if continueAble {
                print("Original task excuted at \(Date())")
                task()
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + delayTime) { executor() }

        return ExchangableHandler { action in
            continueAble = false
            switch action {
            case .cancel: print("Task did cancelled")
            case let .exchange(delayTime, task):
                DispatchQueue.main.asyncAfter(deadline: .now() + delayTime) {
                    task()
                    print("New task excuted at \(Date())")
                }
            }
        }
    }

    private struct ExchangableHandler: Exchangable {
        enum Action {
            case cancel
            case exchange(delayTime: TimeInterval, task: () -> Void)
        }

        private var dispatch: (Action) -> Void

        init(_ aDispatch: @escaping ((Action) -> Void)) {
            dispatch = aDispatch
        }

        func cancel() {
            dispatch(.cancel)
        }

        func exchange(_ delayTime: TimeInterval, _ exchangedTask: @escaping (() -> Void)) {
            dispatch(.exchange(delayTime: delayTime, task: exchangedTask))
        }
    }
}

func testAsyncAfter() {
    #if false
        print("now is \(Date())")
        let exchange = AsyncAfter.delay(3) {
            print("hello this is original task")
        }
        exchange.cancel()
    #endif
//    exchange.exchange(3) {
//        print("hello this is exchanged task")
//    }
}
