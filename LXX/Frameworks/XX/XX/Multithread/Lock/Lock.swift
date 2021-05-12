//
//  Lock.swift
//  LXX
//
//  Created by lben on 2021/1/27.
//

import Foundation

public extension NSLocking {
    /// Executes a closure returning a value while acquiring the lock.
    ///
    /// - Parameter closure: The closure to run.
    ///
    /// - Returns:           The value the closure generated.
    func around<T>(_ closure: () -> T) -> T {
        lock(); defer { unlock() }
        return closure()
    }

    /// Execute a closure while acquiring the lock.
    ///
    /// - Parameter closure: The closure to run.
    func around(_ closure: () -> Void) {
        lock(); defer { unlock() }
        closure()
    }
}
