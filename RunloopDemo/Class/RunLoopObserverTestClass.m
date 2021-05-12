//
//  RunLoopObserverTestClass.m
//  RunloopDemo
//
//  Created by lben on 2021/4/26.
//

#import "RunLoopObserverTestClass.h"

@implementation RunLoopObserverTestClass
- (void)addObserverTo:(NSRunLoop *)runloop {
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopAllActivities, true, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        /*
         kCFRunLoopEntry = (1UL << 0),          进入工作
         kCFRunLoopBeforeTimers = (1UL << 1),   即将处理Timers事件
         kCFRunLoopBeforeSources = (1UL << 2),  即将处理Source事件
         kCFRunLoopBeforeWaiting = (1UL << 5),  即将休眠
         kCFRunLoopAfterWaiting = (1UL << 6),   被唤醒
         kCFRunLoopExit = (1UL << 7),           退出RunLoop
         kCFRunLoopAllActivities = 0x0FFFFFFFU  监听所有事件
         */
//        if (runloop.currentMode == (__bridge NSString *)kCFRunLoopDefaultMode) {
//            return;
//        }
        
        NSLog(@"runloop = %@", runloop);
        
        switch (activity) {
            case kCFRunLoopEntry:
                NSLog(@"[Run - %@] 进入 ---> 、 %@", runloop.currentMode, observer);
                break;
            case kCFRunLoopBeforeTimers:
                NSLog(@"[Run - %@] 即将处理Timer事件 ---> %@", runloop.currentMode, observer);
                break;
            case kCFRunLoopBeforeSources:
                NSLog(@"[Run - %@] 即将处理Source事件 ---> %@", runloop.currentMode, observer);
                break;
            case kCFRunLoopBeforeWaiting:
                NSLog(@"[Run - %@] 即将休眠 ---> %@", runloop.currentMode, observer);
                break;
            case kCFRunLoopAfterWaiting:
                NSLog(@"[Run - %@] 被唤醒 ---> %@", runloop.currentMode, observer);
                break;
            case kCFRunLoopExit:
                NSLog(@"[Run - %@] 退出RunLoop ---> %@", runloop.currentMode, observer);
                break;
            default:
                break;
        }
    });

    CFRunLoopAddObserver(runloop.getCFRunLoop, observer, kCFRunLoopCommonModes);
    CFRelease(observer);
}

@end
