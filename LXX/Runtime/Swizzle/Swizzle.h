//
//  Swizzle.h
//  CookBook
//
//  Created by lben on 2020/8/6.
//  Copyright © 2020 lben. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Swizzle : NSObject

+ (BOOL)originalSelector:(SEL)originalSel replaceSelector:(SEL)replaceSel forClass:(Class)aClass;
+ (BOOL)originalSelector:(SEL)originalSel replaceSelector:(SEL)replaceSel forClass:(Class)aClass withIMPBlock:(id)impBlock;

+ (IMP)originalSelector:(SEL)originalSel forClass:(Class)aClass withIMPBlock:(id)impBlock;

+ (void)test;
@end

@interface NSObject (Swizzle)

@end

NS_ASSUME_NONNULL_END
