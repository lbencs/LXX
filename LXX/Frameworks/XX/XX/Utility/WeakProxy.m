//
//  WeakProxy.m
//  Label
//
//  Created by lben on 2021/1/18.
//

#import "WeakProxy.h"

@interface WeakProxy ()
@property (nullable, weak, nonatomic, readwrite) id target;
@end

@implementation WeakProxy

- (instancetype)initWithTarget:(id)target {
    _target = target;
    return self;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:_target];
}

- (void)doesNotRecognizeSelector:(SEL)aSelector {
    NSLog(@"does not recognize selector");
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [_target methodSignatureForSelector:sel];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [_target respondsToSelector:aSelector];
}

- (BOOL)isKindOfClass:(Class)aClass {
    return [_target isKindOfClass:aClass];
}

- (BOOL)isMemberOfClass:(Class)aClass {
    return [_target isMemberOfClass:aClass];
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol {
    return [_target conformsToProtocol:aProtocol];
}

- (BOOL)isProxy {
    return true;
}

@end
