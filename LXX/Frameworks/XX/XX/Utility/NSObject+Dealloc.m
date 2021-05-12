//
//  NSObject+Dealloc.m
//  DomeUI
//
//  Created by lben on 2019/4/3.
//  Copyright © 2019 lben. All rights reserved.
//

#import "NSObject+Dealloc.h"
#import <objc/runtime.h>

@interface ReleaseObjc : NSObject
@property (copy, nonatomic) void (^block)(void);
- (instancetype)initWith:(void(^)(void))block;
@end
@implementation ReleaseObjc
- (instancetype)initWith:(void(^)(void))block {
    if (self = [super init]) {
        _block = block;
    }
    return self;
}
- (void)dealloc {
    if (_block) {
        _block();
    }
}
@end

@implementation NSObject (Dealloc)

- (void)xx_deallocBlock:(void(^)(void))block {
    ReleaseObjc *obj = [[ReleaseObjc alloc] initWith:^{
        block();
    }];
    objc_setAssociatedObject(self, _cmd, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
