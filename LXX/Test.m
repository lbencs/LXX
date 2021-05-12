//
//  Test.m
//  LXX
//
//  Created by lben on 2021/1/19.
//

#import "Test.h"

@implementation Test

+ (void)sayHello {
    NSLog(@"a");
}

+ (void)test {
    id obj = [Test class];
    [obj performSelector:@selector(sayHello)];
    @[ [Test class], @"sayHello"];

    void (^ block) (void) = ^{
        [Test sayHello];
    };
    block();
}

@end
