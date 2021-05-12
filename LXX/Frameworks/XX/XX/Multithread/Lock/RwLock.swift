//
//  RwLock.swift
//  LXX
//
//  Created by lben on 2021/2/8.
//

import Foundation

public class RwLock {
    let rwlock = UnsafeMutablePointer<pthread_rwlock_t>.allocate(capacity: 1)
    public init() {
        pthread_rwlock_init(rwlock, nil)
    }

    deinit {
        pthread_rwlock_destroy(rwlock)
        rwlock.deinitialize(count: 1)
        rwlock.deallocate()
    }

    @discardableResult
    public func readLock() -> Bool {
        precondition(pthread_rwlock_rdlock(rwlock) == 0)
        return true
    }

    @discardableResult
    public func writeLock() -> Bool {
        precondition(pthread_rwlock_wrlock(rwlock) == 0)
        return true
    }

    public func tryReadLock() -> Bool {
        return pthread_rwlock_tryrdlock(rwlock) == 0
    }

    public func tryWriteLock() -> Bool {
        return pthread_rwlock_trywrlock(rwlock) == 0
    }

    public func unlock() {
        pthread_rwlock_unlock(rwlock)
    }
}
