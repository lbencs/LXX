//
//  DispatchTest.m
//  BaseDemo
//
//  Created by lben on 2018/11/8.
//  Copyright © 2018 lben. All rights reserved.
//

#import "DispatchTest.h"

dispatch_queue_t globalQueue() {
    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
}
dispatch_queue_t mainQueue() {
    return dispatch_get_main_queue();
}

@implementation DispatchTest

- (void)test {
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self sync];
//    });
//    [self sync];
    
//    [self async];
    [self group];
    
    
}
- (void)group {
    NSLog(@"group: begin in %@", NSThread.currentThread);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, globalQueue(), ^{
        NSLog(@"group: task one begin");
        for (int i = 0; i <= 2; i++) {
            sleep(rand() % 6);
            NSLog(@"group: task one %d in %@", i, NSThread.currentThread);
        }
        NSLog(@"group: task one end");
    });
    dispatch_group_async(group, globalQueue(), ^{
        NSLog(@"group: task two begin");
        for (int i = 0; i <= 2; i++) {
            sleep(rand() % 4);
            NSLog(@"group: task two %d in %@", i, NSThread.currentThread);
        }
        NSLog(@"group: task two end");
    });
    dispatch_notify(group, mainQueue(), ^{
        
        NSLog(@"group: All task did finished in %@", NSThread.currentThread);
    });
    NSLog(@"group: end in %@", NSThread.currentThread);
    
}

//同步执行
- (void)sync {
//    dispatch_queue_t sync_queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_queue_t sync_queue = dispatch_queue_create("dispatch_sync_queue", DISPATCH_QUEUE_SERIAL);
    //Serial or Concurrent Queue
//    dispatch_queue_t queue = dispatch_queue_create("dispatch_sync_queue", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue = dispatch_queue_create("dispatch_sync_queue", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"sync: begin %@", NSThread.currentThread);
    dispatch_sync(queue, ^{
        sleep(2); NSLog(@"sync: 0 in %@", NSThread.currentThread);
    });
    dispatch_sync(queue, ^{
        sleep(4); NSLog(@"sync: 1 in %@", NSThread.currentThread);
    });
    dispatch_sync(queue, ^{
        sleep(5); NSLog(@"sync: 2 in %@", NSThread.currentThread);
    });
    dispatch_sync(queue, ^{
        sleep(1); NSLog(@"sync: 3 in %@", NSThread.currentThread);
    });
    dispatch_sync(queue, ^{
        NSLog(@"sync: 4 in %@", NSThread.currentThread);
    });
    dispatch_sync(queue, ^{
        sleep(3); NSLog(@"sync: 5 in %@", NSThread.currentThread);
    });
    dispatch_sync(queue, ^{
        NSLog(@"sync: 6 in %@", NSThread.currentThread);
    });
    dispatch_sync(queue, ^{
        NSLog(@"sync: 7 in %@", NSThread.currentThread);
    });
     NSLog(@"sync: end %@", NSThread.currentThread);
}
//异步执行
- (void)async {
    
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //Serial + async = Serial，因为串行队列不具备可并行的可能性
//    dispatch_queue_t queue = dispatch_queue_create("dispatch_sync_queue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_queue_t queue = dispatch_queue_create("dispatch_sync_queue", DISPATCH_QUEUE_CONCURRENT);
    
    NSLog(@"async: begin in %@", NSThread.currentThread);
    dispatch_async(queue, ^{
        sleep(2); NSLog(@"async: 0 in %@", NSThread.currentThread);
    });
    dispatch_async(queue, ^{
        sleep(4); NSLog(@"async: 1 in %@", NSThread.currentThread);
    });
    dispatch_async(queue, ^{
        sleep(5); NSLog(@"async: 2 in %@", NSThread.currentThread);
    });
    dispatch_async(queue, ^{
        sleep(1); NSLog(@"async: 3 in %@", NSThread.currentThread);
    });
    dispatch_async(queue, ^{
        NSLog(@"async: 4 in %@", NSThread.currentThread);
    });
    dispatch_async(queue, ^{
        sleep(3); NSLog(@"async: 5 in %@", NSThread.currentThread);
    });
    dispatch_async(queue, ^{
        NSLog(@"async: 6 in %@", NSThread.currentThread);
    });
    dispatch_async(queue, ^{
        NSLog(@"async: 7 in %@", NSThread.currentThread);
    });
    
    NSLog(@"async: end %@", NSThread.currentThread);
}

@end
