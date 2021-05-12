//
//  MutableEgg.m
//  BaseDemo
//
//  Created by lben on 2018/12/4.
//  Copyright © 2018 lben. All rights reserved.
//

#import "MutableEgg.h"

/**
 1. 线程安全
 */
@interface MutableEgg ()
{
    NSInteger _weight;
    NSInteger _xxx;
    NSLock *_xxxLock;
}
@end

@implementation MutableEgg

//重载父类属性，通过Synthesize来修改
@synthesize size = _size;
@dynamic weight, xxx;

- (instancetype)init {
    self = [super init];
    if (self) {
        _weight = 0;
        _size = 0;
        _age = 0;
        _xxxLock = [NSLock new];
    }
    return self;
}

- (NSInteger)xxx {
    return _xxx;
}

- (void)increase {
    [_xxxLock lock];
    _xxx += 1;
    [_xxxLock unlock];
}

- (void)setXxx:(NSInteger)xxx {
    _xxx = xxx;
}

- (NSInteger)weight {
    @synchronized (self) {
        return _weight;
    }
}

- (void)setWeight:(NSInteger)weight {
    @synchronized (self) {
        _weight = weight;
    }
}

@end
