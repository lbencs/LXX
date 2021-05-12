//
//  OCProxy.m
//  Label
//
//  Created by lben on 2021/1/18.
//

#import "OCProxy.h"
@interface OCProxy ()
@property (nullable, weak, nonatomic, readwrite) id target;
@end

@implementation OCProxy

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return YES;
}

- (instancetype)initWithTarget:(id)target {
    _target = target;
    return self;
}

- (BOOL)isProxy {
    return YES;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    [anInvocation invokeWithTarget:_target];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return [_target methodSignatureForSelector:aSelector];
}

- (void)doesNotRecognizeSelector:(SEL)aSelector {
    NSLog(@"===> %@", NSStringFromSelector(_cmd));
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [_target respondsToSelector:aSelector];
}

- (BOOL)isEqual:(id)object {
    return [_target isEqual:object];
}

- (NSUInteger)hash {
    return [_target hash];
}

- (Class)superclass {
    return [_target superclass];
}

- (Class)class {
    return [_target class];
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

- (NSString *)description {
    return [_target description];
}

- (NSString *)debugDescription {
    return [_target debugDescription];
}

@end
