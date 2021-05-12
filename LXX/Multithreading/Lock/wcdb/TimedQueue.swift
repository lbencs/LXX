//
//  TimedQueue.swift
//  LockDemo
//
//  Created by lben on 2020/9/17.
//  Copyright © 2020 lben. All rights reserved.
//

import Foundation

final class TimedQueue<Key: Hashable> {
    typealias Element = (key: Key, clock: SteadyClock)
    typealias List = ContiguousArray<Element>
    typealias Map = [Key: List.Index]

    let delay: TimeInterval

    let conditionLock = ConditionLock()

    var list: List = []
    var map: Map = [:]

    init(withDelay delay: TimeInterval) {
        self.delay = delay
    }

    func remove(with key: Key) {
        conditionLock.lock(); defer { conditionLock.unlock() }

        guard let index = map.index(forKey: key) else {
            return
        }
        list.remove(at: map[index].value)
        map.remove(at: index)
    }

    func reQueue(with key: Key) {
        conditionLock.lock(); defer { conditionLock.unlock() }

        let signal = list.isEmpty

        if let index = map.index(forKey: key) {
            list.remove(at: map[index].value)
            map.remove(at: index)
        }

        list.append((key, SteadyClock.now() + delay))
        map[key] = list.startIndex
        if signal {
            conditionLock.signal()
        }
    }

    func wait(untilExpired onExpired: (Key) -> Void) {
        while true {
            var key: Key!
            do {
                conditionLock.lock(); defer { conditionLock.unlock() }
                guard let element = list.first else {
                    conditionLock.wait()
                    continue
                }
                let now = SteadyClock.now()
                guard now >= element.clock else {
                    conditionLock.wait(timeout: element.clock - now)
                    continue
                }
                key = element.key
                list.removeFirst()
                map.removeValue(forKey: key)
            }
            onExpired(key)
            break
        }
    }
}
