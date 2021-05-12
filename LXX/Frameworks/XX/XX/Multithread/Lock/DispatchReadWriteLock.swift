//
//  CustomReadWriteLock.swift
//  LXX
//
//  Created by lben on 2021/2/8.
//

import Foundation

public class DispatchReadWriteLock {
    let queue = DispatchQueue(label: "com.read.write.lock.queue", qos: .default, attributes: .concurrent)

    public init() {}
    public func write(_ closure: () -> Void) {
        /**
         public static let barrier: DispatchWorkItemFlags

         @available(macOS 10.10, iOS 8.0, *)
         public static let detached: DispatchWorkItemFlags

         @available(macOS 10.10, iOS 8.0, *)
         public static let assignCurrentContext: DispatchWorkItemFlags

         @available(macOS 10.10, iOS 8.0, *)
         public static let noQoS: DispatchWorkItemFlags

         @available(macOS 10.10, iOS 8.0, *)
         public static let inheritQoS: DispatchWorkItemFlags

         @available(macOS 10.10, iOS 8.0, *)
         public static let enforceQoS: DispatchWorkItemFlags
          */
        queue.sync(flags: .barrier) {
            closure()
        }
    }

    @discardableResult
    public func read<T>(_ closure: () -> T) -> T {
        var value: T!
        queue.sync {
            value = closure()
        }
        return value
    }
}
