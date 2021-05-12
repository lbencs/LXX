//
//  MutexLock.swift
//  LXX
//
//  Created by lben on 2021/1/28.
//

import Foundation
/// A `pthread_mutex_t` wrapper.
public final
class MutexLock: NSLocking {
    public enum AttributeType {
        case normal
        case recursive
        fileprivate var type: Int32 {
            switch self {
            case .normal: return PTHREAD_MUTEX_ERRORCHECK
            case .recursive: return PTHREAD_MUTEX_RECURSIVE
            }
        }
    }

    private var mutex: UnsafeMutablePointer<pthread_mutex_t>

    deinit {
        precondition(pthread_mutex_destroy(mutex) == 0, "Failed to destroy pthread_mutex")
    }

    public init(_ attrybute: AttributeType = .normal) {
        mutex = .allocate(capacity: 1)

        var attr_t = pthread_mutexattr_t()
        pthread_mutexattr_init(&attr_t)
//        如果尝试以递归方式锁定此类型的互斥锁，则会产生不确定的行为。
//        对于不是由调用线程锁定的此类型互斥锁，如果尝试对它解除锁定，则会产生不确定的行为。
//        对于尚未锁定的此类型互斥锁，如果尝试对它解除锁定，也会产生不确定的行为。
//        允许在实现中将该互斥锁映射到其他互斥锁类型之一。对于 Solaris 线程，PTHREAD_PROCESS_DEFAULT 会映射到
//        默认值普通锁，当一个线程加锁以后，其他线程进入按照优先顺序进入等待队列，并且解锁的时候按照先入先出的方式获得锁。
//        PTHREAD_MUTEX_DEFAULT // locked 等待

//        适应锁，等待解锁之后重新竞争，没有等待队列。
//        此类型的互斥锁不会检测死锁。如果线程在不首先解除互斥锁的情况下尝试重新锁定该互斥锁，则会产生死锁。
//        尝试解除由其他线程锁定的互斥锁会产生不确定的行为。如果尝试解除锁定的互斥锁未锁定，则会产生不确定的行为。
//        PTHREAD_MUTEX_NORMAL // locked 等待

//        PTHREAD_MUTEX_RECURSIVE // 递归锁

//        检错锁，当同一个线程获得同一个锁的时候，则返回EDEADLK，否则与普通锁处理一样
//        PTHREAD_MUTEX_ERRORCHECK // 同一线程，重复加锁 -> crash
        pthread_mutexattr_settype(&attr_t, attrybute.type)

        precondition(pthread_mutex_init(mutex, &attr_t) == 0, "Failed to create pthread_mutex")
    }

    public func lock() {
        precondition(pthread_mutex_lock(mutex) == 0, "Failed to lock pthread_mutex")
    }

    public func unlock() {
        precondition(pthread_mutex_unlock(mutex) == 0, "Failed to unlock pthread_mutex")
    }

    public func trylock() -> Bool {
        return pthread_mutex_trylock(mutex) == 0
    }
}
