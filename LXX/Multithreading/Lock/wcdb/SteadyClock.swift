//
//  SteadyClock.swift
//  LockDemo
//
//  Created by lben on 2020/9/17.
//  Copyright © 2020 lben. All rights reserved.
//

import Foundation

struct SteadyClock {
    private var time: TimeInterval // monotonic

    init() {
        time = ProcessInfo.processInfo.systemUptime
    }

    private init(with time: TimeInterval) {
        self.time = time
    }

    static func >= (lhs: SteadyClock, rhs: SteadyClock) -> Bool {
        return lhs.time >= rhs.time
    }

    static func - (lhs: SteadyClock, rhs: SteadyClock) -> TimeInterval {
        return lhs.time - rhs.time
    }

    static func + (steadyClock: SteadyClock, timeInterval: TimeInterval) -> SteadyClock {
        return SteadyClock(with: steadyClock.time + timeInterval)
    }

    static func now() -> SteadyClock {
        return SteadyClock()
    }
}
