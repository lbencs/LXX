//
//  Swizzle.m
//  CookBook
//
//  Created by lben on 2020/8/6.
//  Copyright © 2020 lben. All rights reserved.
//

#import "Swizzle.h"
#import <objc/runtime.h>

@implementation Swizzle

+ (BOOL)originalSelector:(SEL)originalSel replaceSelector:(SEL)replaceSel forClass:(Class)aClass {
    Method originalMethod = class_getInstanceMethod(aClass, originalSel);
    Method replaceMethod =  class_getInstanceMethod(aClass, replaceSel);

    if (originalMethod == nil || replaceMethod == nil) {
        return false;
    }

    method_exchangeImplementations(originalMethod, replaceMethod);
    return true;
}

+ (BOOL)originalSelector:(SEL)originalSel replaceSelector:(SEL)replaceSel forClass:(Class)aClass withIMPBlock:(id)impBlock {
    Method originalMethod = class_getInstanceMethod(aClass, originalSel);

    IMP replaceIMP = imp_implementationWithBlock(impBlock);
    if (!class_addMethod(aClass, replaceSel, replaceIMP, method_getTypeEncoding(originalMethod))) {
        NSLog(@"Add replaceMethod method failue");
        return false;
    } else {
        // replace method's imp add success
        Method replaceMethod =  class_getInstanceMethod(aClass, replaceSel);

//         *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[UIDropShadowView swizzle_touchesBegan:withEvent:]: unrecognized selector sent to instance 0x7f97c4c102a0'

//        IMP original = method_setImplementation(originalMethod, replaceIMP);

        if (class_addMethod(aClass, originalSel, method_getImplementation(replaceMethod), method_getTypeEncoding(originalMethod))) {
            class_replaceMethod(aClass, replaceSel, method_getImplementation(originalMethod), method_getTypeEncoding(replaceMethod));
        } else {
            method_exchangeImplementations(originalMethod, replaceMethod);
        }
        return true;
    }
}

+ (IMP)originalSelector:(SEL)originalSel forClass:(Class)aClass withIMPBlock:(id)impBlock {
    Method originalMethod = class_getInstanceMethod(aClass, originalSel);

    IMP replaceIMP = imp_implementationWithBlock(impBlock);

    // replace method's imp add success

    if (!class_addMethod(aClass, originalSel, replaceIMP, method_getTypeEncoding(originalMethod))) {
        return method_setImplementation(originalMethod, replaceIMP);
    } else {
        return method_getImplementation(originalMethod);
    }
}

@end

@implementation NSObject (Swizzle)

@end
