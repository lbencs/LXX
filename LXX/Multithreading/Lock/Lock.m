//
//  Lock.m
//  LockDemo
//
//  Created by lbencs on 05/12/2017.
//  Copyright © 2017 lbencs. All rights reserved.
//

#import "Lock.h"
#import <libkern/OSAtomic.h>
#import <os/lock.h>
#import <pthread.h>
@implementation OCLock
/**
    锁就必然会面临一个 死锁的问题
 http://blog.csdn.net/qq_30513483/article/details/52349968
 
 进程的状态
 执行->挂起->
 
 
 线程安全
 函数、函数库在多线程环境下被调用时，能够正确的处理多个线程之间的共享变量，使其能正确完成。
 
 
 中断
 
 
 锁的类型
 简单锁
 - 可被抢占，一个优先级更高的锁可以直接进行抢占
 互斥锁
 排它锁
 共享锁
 递归锁
 自旋锁
 */
+ (void)test {
    [self _NSCondition];
}

+ (void)_NSRecursiveLock {
    //条件锁
}
+ (void)_NSConditionLock {
    //条件锁
    
}
+ (void)_NSCondition {
    NSCondition *lock = [[NSCondition alloc] init];
    //1.线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程1 准备上锁");
        [lock lock];
        sleep(3);
        NSLog(@"线程1");
        [lock unlock];
    });
    
    //1.线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程2 准备上锁");
        [lock lock];
        NSLog(@"线程2");
        [lock unlock];
    });
}
+ (void)_NSLock {
    NSLock *lock = [[NSLock alloc] init];
    //1.线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程1 准备上锁");
        [lock lock];
        sleep(3);
        NSLog(@"线程1");
        [lock unlock];
    });
    
    //1.线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程2 准备上锁");
        [lock lock];
        NSLog(@"线程2");
        [lock unlock];
    });
}
+ (void)_pthread_mutex_recursive {
    /**
     递归锁
     同一个线程，在未释放其拥有的锁之前，多次、重复的对其加锁
     */
    static pthread_mutex_t pLock;
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr); //初始化attr并且给它赋予默认
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE); //设置锁类型，这边是设置为递归锁
    //初始化
    pthread_mutex_init(&pLock, &attr);
    
    pthread_mutexattr_destroy(&attr); //销毁一个属性对象，在重新进行初始化之前该结构不能重新使用
    
    //1.线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        static void (^RecursiveBlock)(int);
        RecursiveBlock = ^(int value) {
            pthread_mutex_lock(&pLock);
            if (value > 0) {
                NSLog(@"value: %d", value);
                RecursiveBlock(value - 1);
            }
            NSLog(@"value: unlock %d", value);
            pthread_mutex_unlock(&pLock);
        };
        RecursiveBlock(5);
    });
}
+ (void)_pthread_mutex {
    //互斥锁
    static pthread_mutex_t pLock;
    pthread_mutex_init(&pLock, NULL);
    //1.线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程1 准备上锁");
        pthread_mutex_lock(&pLock);
        sleep(3);
        NSLog(@"线程1");
        pthread_mutex_unlock(&pLock);
    });
    
    //1.线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程2 准备上锁");
        pthread_mutex_lock(&pLock);
        NSLog(@"线程2");
        pthread_mutex_unlock(&pLock);
    });
}
+ (void)_dispatch_semaphore {
    //内核同步方式之： 型号量方式
    //1. 可以提供一个池,用来控制最大可访问数
    dispatch_semaphore_t signal = dispatch_semaphore_create(0); //传入值必须 >=0, 若传入为0则阻塞线程并等待timeout,时间到后会执行其后的语句
    dispatch_time_t overTime = dispatch_time(DISPATCH_TIME_NOW, 3.0f * NSEC_PER_SEC);
    
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程1 等待ing");
        dispatch_semaphore_wait(signal, overTime); //signal 值 -1
        NSLog(@"线程1");
        dispatch_semaphore_signal(signal); //signal 值 +1
        NSLog(@"线程1 发送信号");
        NSLog(@"--------------------------------------------------------");
    });
    
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程2 等待ing");
        dispatch_semaphore_wait(signal, overTime);
        NSLog(@"线程2");
        dispatch_semaphore_signal(signal);
        NSLog(@"线程2 发送信号");
    });
}
+ (void)_os_unfair_lock {
    __block os_unfair_lock oslock = OS_UNFAIR_LOCK_INIT;
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程1 准备上锁");
        os_unfair_lock_lock(&oslock);
        sleep(4);
        NSLog(@"线程1");
        os_unfair_lock_unlock(&oslock);
        NSLog(@"线程1 解锁成功");
        NSLog(@"--------------------------------------------------------");
    });
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程2 准备上锁");
        os_unfair_lock_lock(&oslock);
        NSLog(@"线程2");
        os_unfair_lock_unlock(&oslock);
        NSLog(@"线程2 解锁成功");
    });
}
+ (void)_OSSpinLock {
    __block OSSpinLock oslock = OS_SPINLOCK_INIT;
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程1 准备上锁");
        OSSpinLockLock(&oslock);
        sleep(4);
        NSLog(@"线程1");
        OSSpinLockUnlock(&oslock);
        NSLog(@"线程1 解锁成功");
        NSLog(@"--------------------------------------------------------");
    });
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程2 准备上锁");
        OSSpinLockLock(&oslock);
        NSLog(@"线程2");
        OSSpinLockUnlock(&oslock);
        NSLog(@"线程2 解锁成功");
    });
}
@end
