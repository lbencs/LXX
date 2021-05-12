//
//  OCRunLoop.m
//  BaseDemo
//
//  Created by lben on 2018/11/29.
//  Copyright © 2018 lben. All rights reserved.
//

#import "OCRunLoop.h"

#import "OCThread.h"
#import <UIKit/UIKit.h>
@implementation OCRunLoop
- (OCRunLoop *)run {
    NSLog(@"----> current run loop address: %p", [NSRunLoop currentRunLoop]);
    [self rm_execuate];
//    [[UIImageView new] animationImages]
    return self;
}

- (void)rm_execuate {
    OCThread *thread = [[OCThread alloc] initWithBlock:^{
        NSLog(@"----> 开始执行任务");

        NSLog(@"----> current run loop address: %p", [NSRunLoop currentRunLoop]);
        NSRunLoop *current = [NSRunLoop currentRunLoop];
        CFRunLoopObserverRef observerRef =  CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, true, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
                                                                                   NSLog(@"----监听到RunLoop状态发生改变--%lu", activity);
                                                                               });
        CFRunLoopAddObserver(CFRunLoopGetCurrent(), observerRef, kCFRunLoopCommonModes);

        //add port
        [current addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];

        //add Timer to common modes
        NSTimer *timer = NULL;
        timer = [NSTimer timerWithTimeInterval:2.0 repeats:true block:^(NSTimer *_Nonnull timer) {
            NSLog(@"----> Timer: execute every two seconds with common modes");
        }];
        [current addTimer:timer forMode:NSRunLoopCommonModes];
        //add timer to default mode
        timer = [NSTimer timerWithTimeInterval:2.0 repeats:true block:^(NSTimer *_Nonnull timer) {
            NSLog(@"----> Timer: execute every two seconds with default mode");
        }];
        [current addTimer:timer forMode:NSDefaultRunLoopMode];
        NSLog(@"----> current model is: \%@", [current currentMode]);

        NSLog(@"----> %@", [NSRunLoop currentRunLoop]);
        [current run];

        NSLog(@"----> 任务执行完毕");
    }];
    thread.name = @"ocThread";
    [thread start];
}

@end
