//
//  ThreadPool.swift
//  XX
//
//  Created by lben on 2021/4/12.
//

import Foundation

// YYDispatchQueuePool.h
class DispatchQueuePool {
}

// YYSentinel
class Sentinel {
}

public final
class ThreadPool {
    public static let share = ThreadPool()
    let dispatch = DispatchSemaphore(value: 4)

    public func async(_ exector: @escaping () -> Void) {
        // TODO: #lben -  如果这里进来的是主线程呢？
        dispatch.wait()
        let thread = Thread(block: {
            exector()
            self.dispatch.signal()
        })
        thread.start()
    }
}
