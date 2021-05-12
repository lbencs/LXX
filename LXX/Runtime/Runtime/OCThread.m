//
//  OCThread.m
//  BaseDemo
//
//  Created by lben on 2018/11/29.
//  Copyright © 2018 lben. All rights reserved.
//

#import "OCThread.h"

@implementation OCThread
- (void)dealloc {
    NSLog(@"----> %@: 线程销毁", self);
}
@end
