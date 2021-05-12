//
//  GCD.m
//  DomeUI
//
//  Created by lben on 2019/4/3.
//  Copyright © 2019 lben. All rights reserved.
//

#import "GCD.h"

@implementation GCD
- (void)test {
}
+ (void)test {
    /**
     1. 打印顺序
        1. x++ 先读x，再++
        2. ++x 先++，再读

     2. 主线程死锁问题
     2. 多线程的几种方式
            Thread => GCD => Operation
     */
#if 0
    __block int x = 0;
    __block int y = 0;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"#1.%d", x++);  //0
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"#2.%d", ++y); //1
        });
        NSLog(@"#3.%d", y++); //1
        NSLog(@"#4.%d", x + y); // 3
        while (1) {
        }
    });
#endif

    // in main
    // 主线程阻塞
    // __DISPATCH_WAIT_FOR_QUEUE__
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        // in main
//        // 主线程阻塞，无法执行
//        NSLog(@"test");
//    });
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
#if 0

    dispatch_async(globalQueue, ^{
        NSLog(@"#action 1");
    });

    dispatch_barrier_async(globalQueue, ^{
        NSLog(@"#action 2");
    });

    dispatch_async(globalQueue, ^{
        NSLog(@"#action 3");
    });
#endif
    
    dispatch_apply(100, globalQueue, ^(size_t offset) {
        NSLog(@"#apply \(%zu), thread: %@", offset, NSThread.currentThread);
    });
    
    
    // 挂起一个队列，使其展示不能执行
//    dispatch_suspend(<#dispatch_object_t  _Nonnull object#>)
//    dispatch_resume(<#dispatch_object_t  _Nonnull object#>)
    
//    dispatch_queue_t
//    dispatch_group_t
}

@end
