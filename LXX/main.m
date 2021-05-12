//
//  main.m
//  DomeUI
//
//  Created by lben on 2019/4/2.
//  Copyright © 2019 lben. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[])
{
    @autoreleasepool {
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
            switch (activity) {
                case kCFRunLoopEntry:
                    NSLog(@"[Run] 进入 ---> %@", observer);
                    break;
                case kCFRunLoopBeforeTimers:
                    NSLog(@"[Run] 即将处理Timer事件 ---> %@", observer);
                    break;
                case kCFRunLoopBeforeSources:
                    NSLog(@"[Run] 即将处理Source事件 ---> %@", observer);
                    break;
                case kCFRunLoopBeforeWaiting:
                    NSLog(@"[Run] 即将休眠 ---> %@", observer);
                    break;
                case kCFRunLoopAfterWaiting:
                    NSLog(@"[Run] 被唤醒 ---> %@", observer);
                    break;
                case kCFRunLoopExit:
                    NSLog(@"[Run] 退出RunLoop ---> %@", observer);
                    break;
                default:
                    break;
            }
        });
//        CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes);
//        CFRelease(observer);
        
//        NSXPCConnection *connect = [[NSXPCConnection alloc] init];
        
//        CFMessagePortRef ref = CFMessagePortCreateLocal(<#CFAllocatorRef allocator#>, <#CFStringRef name#>, <#CFMessagePortCallBack callout#>, <#CFMessagePortContext *context#>, <#Boolean *shouldFreeInfo#>)
        NSLog(@"[Run] current runloop %@", NSRunLoop.currentRunLoop);
        int res = UIApplicationMain(argc, argv, nil, NSStringFromClass(NSClassFromString(@"LXX.AppDelegate")));
        return res;
    }
}
