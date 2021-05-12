//
//  ContainerWithCondition.swift
//  LXX
//
//  Created by lben on 2021/2/8.
//

import Foundation

class ContainerWithCondition<T>: Container {
    private let lock: Condition
    init(condation: Condition) {
        lock = condation
    }

    private var buffer: [T] = []
    var capacity: Int = 10
    private(set) var total: Int = 0

    func put(_ value: T) {
        lock.lock()
        defer {
            lock.unlock()
        }

        while buffer.count == capacity {
            lock.wait()
        }
        buffer.append(value)
        total += 1
        print("produce product \(value), total: \(buffer.count)")
        lock.broadcast()
    }

    func take() -> T {
        lock.lock()
        defer {
            lock.unlock()
        }
        while buffer.isEmpty {
            lock.wait()
        }
        let ele = buffer.popLast()!
        print("\(Thread.current) customer product \(ele), total left \(buffer.count)")
        if buffer.isEmpty {
            lock.broadcast()
        }
        return ele
    }
}
