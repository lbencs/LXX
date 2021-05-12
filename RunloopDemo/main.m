//
//  main.m
//  DomeUI
//
//  Created by lben on 2019/4/2.
//  Copyright © 2019 lben. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RunloopTimerTestClass.h"
#import "RunLoopObserverTestClass.h"
#import "BlockTestObject.h"

static int s_fatal_signals[] = {
    SIGABRT,
    SIGBUS,
    SIGFPE,
    SIGILL,
    SIGSEGV,
    SIGTRAP,
    SIGTERM,
    SIGKILL,
};

static int s_fatal_signal_num = sizeof(s_fatal_signals) / sizeof(s_fatal_signals[0]);

void UncaughtExceptionHandler(NSException *exception)
{
    NSArray *exceptionArray = [exception callStackSymbols]; //得到当前调用栈信息
    NSString *exceptionReason = [exception reason];       //非常重要，就是崩溃的原因
    NSString *exceptionName = [exception name];           //异常类型
}

void SignalHandler(int code)
{
    NSLog(@"signal handler = %d", code);
}

void InitCrashReport()
{
    //系统错误信号捕获
    for (int i = 0; i < s_fatal_signal_num; ++i) {
        signal(s_fatal_signals[i], SignalHandler);
    }

    //oc未捕获异常的捕获
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
}

RunloopTimerTestClass *timerTest;
RunLoopObserverTestClass *observerTest;
int main(int argc, char *argv[])
{
    NSRunLoop *runloop = NSRunLoop.currentRunLoop;

    @autoreleasepool {
        InitCrashReport();
        //
#if 0
        timerTest = [RunloopTimerTestClass new];
        [timerTest addTimerTo:runloop];
#endif
        observerTest = [RunLoopObserverTestClass new];
        [observerTest addObserverTo:runloop];

#if 0
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            @throw [[NSException alloc] initWithName:@"name" reason:@"reason" userInfo:@{}];
        });
#endif
        
        int res = UIApplicationMain(argc, argv, nil, NSStringFromClass(NSClassFromString(@"LXX.AppDelegate")));
        return res;
    }
}
