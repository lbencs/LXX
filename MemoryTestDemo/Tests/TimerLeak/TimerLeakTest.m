//
//  TimerLeakTest.m
//  MemoryTestDemo
//
//  Created by lben on 2021/5/1.
//

#import "TimerLeakTest.h"
#import <XX/XX.h>

@interface TimerLeakTest ()
@property (nonatomic, weak) NSTimer *timer;
@end
@implementation TimerLeakTest

- (void)dealloc {
    NSLog(@"~ dealloc ~ %@", self);
}

- (void)run {
    /**
     1. Runloop -> NSTimer
     2. NSTimer -> Controller (加到Runloop以后的效果)
     3. Controller -> Timer
     */
    __weak TimerLeakTest * weakself = self;
    NSTimer *timer = [NSTimer timerWithTimeInterval:5 target:weakself selector:@selector(repeat) userInfo:@(1) repeats:YES];
    [NSRunLoop.currentRunLoop addTimer:timer forMode:NSRunLoopCommonModes];
//    [_timer fire];
//    _timer = timer;
    [_timer xx_deallocBlock:^{
        NSLog(@"~ dealloc ~ timer dealloc");
    }];
}

- (void)repeat {
    NSLog(@"repeat");
//    [_timer invalidate];
}

@end
