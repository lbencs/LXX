//
//  RunloopTimerTestClass.m
//  RunloopDemo
//
//  Created by lben on 2021/4/26.
//

#import "RunloopTimerTestClass.h"

@implementation RunloopTimerTestClass
- (void)addTimerTo:(NSRunLoop *)runloop {
    //创建上下文
    CFRunLoopTimerContext context = {};
    context.info = (__bridge void *)self;      //将当前对象作为参数传入

    CFRunLoopTimerRef timerRef = CFRunLoopTimerCreate(kCFAllocatorDefault,
                                                      0.1, //The time at which the timer should first fire.
                                                      3,
                                                      0,
                                                      0,
                                                      &timerFiredCallback,
                                                      &context);
    CFRunLoopAddTimer(runloop.getCFRunLoop, timerRef, kCFRunLoopCommonModes);
    CFRelease(timerRef);
}

static void timerFiredCallback(CFRunLoopTimerRef timer, void *info)
{
    NSLog(@"%@", timer);
}

@end
