//
//  UnfairLock.swift
//  LXX
//
//  Created by lben on 2021/1/27.
//
import Foundation
import os.lock

/// from Moya
#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
    /// An `os_unfair_lock` wrapper.
    public final class UnfairLock: NSLocking {
        private let unfairLock: os_unfair_lock_t

        public init() {
            unfairLock = .allocate(capacity: 1)
            unfairLock.initialize(to: os_unfair_lock())
        }

        deinit {
            unfairLock.deinitialize(count: 1)
            unfairLock.deallocate()
        }

        public func trylock() -> Bool {
            return os_unfair_lock_trylock(unfairLock)
        }

        public func lock() {
            os_unfair_lock_lock(unfairLock)
        }

        public func unlock() {
            os_unfair_lock_unlock(unfairLock)
        }
    }
#endif
