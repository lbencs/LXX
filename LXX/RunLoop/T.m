//
//  T.m
//  DomeUI
//
//  Created by lben on 2019/4/3.
//  Copyright © 2019 lben. All rights reserved.
//

#import "T.h"
#import "macro.h"
@interface T ()
@property (strong, nonatomic) NSThread *thread;
@end

@implementation T
- (void)func {
//    CFRunLoopStop(<#CFRunLoopRef rl#>)
//    CFRunLoopWakeUp(<#CFRunLoopRef rl#>)

//    CFRunLoopRunInMode(<#CFRunLoopMode mode#>, <#CFTimeInterval seconds#>, <#Boolean returnAfterSourceHandled#>)
//线程保活
    _thread = [[NSThread alloc] initWithTarget:self selector:@selector(execute) object:nil];
    [_thread start];
}

- (void)execute {
    log_func
    [[NSRunLoop currentRunLoop] run];
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopAllActivities, true, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        NSLog(@"%lu", activity);
    });
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    free(observer);
}

@end
