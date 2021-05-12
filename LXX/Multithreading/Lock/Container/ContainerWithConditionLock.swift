//
//  ContainerWithConditionLock.swift
//  LXX
//
//  Created by lben on 2021/2/8.
//

import Foundation

class ContainerWithConditionLock<T>: Container {
    private let lock = NSConditionLock(condition: 0)
    private let producerCondition = 0
    private let customerCondition = 1

    private var buffer: [T] = []
    var capacity: Int = 10
    private(set) var total: Int = 0

    func put(_ value: T) {
        lock.lock(whenCondition: producerCondition)
        defer {
            if !buffer.isEmpty {
                lock.unlock(withCondition: customerCondition)
            } else {
                lock.unlock(withCondition: producerCondition)
            }
        }

        buffer.append(value)
        total += 1
        print("\(Thread.current) produce product \(value), total: \(buffer.count)")
    }

    func take() -> T {
        lock.lock(whenCondition: customerCondition)
        defer {
            if buffer.isEmpty {
                lock.unlock(withCondition: producerCondition)
            } else {
                lock.unlock(withCondition: customerCondition)
            }
        }
        let ele = buffer.popLast()!
        print("\(Thread.current) customer product \(ele), total left \(buffer.count)")
        return ele
    }
}
