//
//  ThreadPoolTest.m
//  MutiThreadDemo
//
//  Created by lben on 2021/5/5.
//

#import "ThreadPoolTest.h"

@interface ThreadPool : NSObject
+ (instancetype _Nonnull)shared;
- (void)async:(void (^_Nonnull)(void))block;
@property (nonatomic, strong) dispatch_queue_t workConcurrentQueue;
@property (nonatomic, strong) dispatch_queue_t serialQueue;
@property (nonatomic, strong) dispatch_semaphore_t semaphore;

@end

@implementation ThreadPool
+ (instancetype)shared {
    static dispatch_once_t onceToken;
    static ThreadPool *pool = nil;
    dispatch_once(&onceToken, ^{
        pool = [[ThreadPool alloc] init];
    });
    return pool;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _workConcurrentQueue = dispatch_queue_create("com.xxx.thread.pool.wark.queue", DISPATCH_QUEUE_CONCURRENT);
        _serialQueue = dispatch_queue_create("com.xxx.thread.pool.serial", DISPATCH_QUEUE_SERIAL);
        _semaphore = dispatch_semaphore_create(3);
    }
    return self;
}

- (void)async:(void (^)(void))block {
    dispatch_time_t timeout = dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC);
    dispatch_async(_serialQueue, ^{
        // 防止卡死主线程
        dispatch_semaphore_wait(self->_semaphore, timeout);
        dispatch_async(self->_workConcurrentQueue, ^{
            block();
            dispatch_semaphore_signal(self->_semaphore);
        });
    });
}

@end

@implementation ThreadPoolTest
- (void)test {
    for (int i = 0; i < 100; i++) {
        [ThreadPool.shared async:^{
            NSLog(@"%@-%@", NSThread.currentThread, @(i));
        }];
    }
}

@end
