//
//  SwizzleExampleClass.m
//  CookBook
//
//  Created by lben on 2020/8/6.
//  Copyright © 2020 lben. All rights reserved.
//

#import "SwizzleExampleClass.h"
#import <objc/runtime.h>

/**
 1. 将swizzle的IMP设置为original的Method
 2. 在swizzle的IMP中调用original的IMP，回归序列
 */

static IMP __original_Method_Imp;
int _replacement_Method(id self, SEL _cmd)
{
    assert([NSStringFromSelector(_cmd) isEqualToString:@"originalMethod"]);
    //code
    int returnValue = ((int (*)(id, SEL))__original_Method_Imp)(self, _cmd);
    return returnValue + 1;
}

@implementation SwizzleExampleClass

- (void)swizzleExample  //call me to swizzle
{
    Method m = class_getInstanceMethod([self class],
                                       @selector(originalMethod));
    __original_Method_Imp = method_setImplementation(m,
                                                     (IMP)_replacement_Method);
}

- (int)originalMethod
{
    //code
    assert([NSStringFromSelector(_cmd) isEqualToString:@"originalMethod"]);
    return 1;
}

+ (void)test {
    SwizzleExampleClass *example = [[SwizzleExampleClass alloc] init];
    int originalReturn = [example originalMethod];
    [example swizzleExample];
    int swizzledReturn = [example originalMethod];
    assert(originalReturn == 1); //true
    assert(swizzledReturn == 2); //true
}

@end
