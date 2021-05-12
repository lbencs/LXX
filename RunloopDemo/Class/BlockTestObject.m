//
//  BlockTestObject.m
//  RunloopDemo
//
//  Created by lben on 2021/4/26.
//

#import "BlockTestObject.h"

@implementation BlockTestObject
- (void)dealloc
{
    NSLog(@"##==>dealloc");
}

- (void)test
{
    __block typeof(self) blockSelf = self;
    _block = ^{
        NSLog(@"##==>%@", blockSelf);
    };
    _block();
}

@end
