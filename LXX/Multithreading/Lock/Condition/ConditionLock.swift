//
//  ConditionLock.swift
//  LockDemo
//
//  Created by lben on 2020/9/17.
//  Copyright © 2020 lben. All rights reserved.
//

import Darwin.POSIX
import Foundation

public final
class ConditionLock: NSLocking, Condition {
    private var mutex = pthread_mutex_t()
    private var cond = pthread_cond_t()

    init() {
        pthread_mutex_init(&mutex, nil)
        pthread_cond_init(&cond, nil)
    }

    deinit {
        pthread_cond_destroy(&cond)
        pthread_mutex_destroy(&mutex)
    }

    public func lock() {
        pthread_mutex_lock(&mutex)
    }

    public func unlock() {
        pthread_mutex_unlock(&mutex)
    }

    public func tryLock() -> Bool {
        return pthread_mutex_trylock(&mutex) == 0
    }

    public func wait() {
        pthread_cond_wait(&cond, &mutex)
    }

    public func wait(timeout: TimeInterval) {
        let integerPart = Int(timeout.nextDown)
        let fractionalPart = timeout - Double(integerPart)
        var ts = timespec(tv_sec: integerPart, tv_nsec: Int(fractionalPart * 1000000000))
        pthread_cond_timedwait_relative_np(&cond, &mutex, &ts)
    }

    public func broadcast() {
        pthread_cond_broadcast(&cond)
    }

    public func signal() {
        pthread_cond_signal(&cond)
    }
}
