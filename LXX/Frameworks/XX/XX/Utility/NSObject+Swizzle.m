//
//  NSObject+Swizzle.m
//  XX
//
//  Created by lben on 2021/1/22.
//

#import "NSObject+Swizzle.h"
#import <objc/runtime.h>

@implementation NSObject (Swizzle)

+ (BOOL)swizzleWithOriginalSelector:(SEL)originalSel replaceSelector:(SEL)replaceSel {
    Method originalMethod = class_getInstanceMethod([self class], originalSel);
    Method replaceMethod =  class_getInstanceMethod([self class], replaceSel);

    if (originalMethod == nil || replaceMethod == nil) {
        return false;
    }

    if (class_addMethod([self class],
                        originalSel,
                        method_getImplementation(replaceMethod),
                        method_getTypeEncoding(originalMethod))) {
        class_replaceMethod([self class],
                            replaceSel,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(replaceMethod));
    } else {
        method_exchangeImplementations(originalMethod, replaceMethod);
    }
    return true;
}

+ (BOOL)swizzleWithOriginalSelector:(SEL)originalSel replaceSelector:(SEL)replaceSel withIMPBlock:(id)impBlock {
    //
    Method originalMethod = class_getInstanceMethod([self class], originalSel);

    IMP replaceIMP = imp_implementationWithBlock(impBlock);
    if (!class_addMethod([self class],
                         replaceSel,
                         replaceIMP,
                         method_getTypeEncoding(originalMethod))) {
        NSLog(@"Add replaceMethod method failue");
        return false;
    } else {
        return [NSObject swizzleWithOriginalSelector:originalSel replaceSelector:replaceSel];
    }
}

+ (IMP)originalSelector:(SEL)originalSel withIMPBlock:(id)impBlock {
    Method originalMethod = class_getInstanceMethod([self class], originalSel);

    IMP replaceIMP = imp_implementationWithBlock(impBlock);

    // replace method's imp add success

    if (!class_addMethod([self class],
                         originalSel,
                         replaceIMP,
                         method_getTypeEncoding(originalMethod))) {
        return method_setImplementation(originalMethod, replaceIMP);
    } else {
        return method_getImplementation(originalMethod);
    }
}

@end
