//
//  BaseTest.m
//  BaseDemo
//
//  Created by lben on 2018/12/4.
//  Copyright © 2018 lben. All rights reserved.
//

#import "BaseTest.h"
#import "MutableEgg.h"
@implementation BaseTest
- (BaseTest *)run {
    for (int j = 0; j < 11; j++) {
        MutableEgg *egg = [MutableEgg new];
        NSString *identify = [NSString stringWithFormat:@"com.lbencs.base.test.%d", j];
        dispatch_queue_t queue = dispatch_queue_create([identify cStringUsingEncoding:NSUTF8StringEncoding], DISPATCH_QUEUE_CONCURRENT);
        dispatch_group_t group = dispatch_group_create();

        for (int i = 0; i < 101; i++) {
            dispatch_group_async(group, queue, ^{
                NSInteger age = egg.age;
                egg.size = egg.size + 1;
                egg.weight = egg.weight + 1;
                egg.age = age + 1;
                [egg increase];
            });
        }

        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        NSLog(@"egg's size is : %ld, weight: %ld, age: %ld, xxx: %ld", (long)egg.size, egg.weight, egg.age, egg.xxx);
    }

    return self;
}

@end
