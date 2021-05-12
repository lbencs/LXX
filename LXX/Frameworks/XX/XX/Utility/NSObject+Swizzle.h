//
//  NSObject+Swizzle.h
//  XX
//
//  Created by lben on 2021/1/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Swizzle)
+ (BOOL)swizzleWithOriginalSelector:(SEL)originalSel replaceSelector:(SEL)replaceSel;
+ (BOOL)swizzleWithOriginalSelector:(SEL)originalSel replaceSelector:(SEL)replaceSel withIMPBlock:(id)impBlock;
//+ (IMP)originalSelector:(SEL)originalSel withIMPBlock:(id)impBlock;
@end

NS_ASSUME_NONNULL_END
