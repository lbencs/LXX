//
//  UIResponder+Chain.m
//  UIResponder
//
//  Created by lbencs on 26/07/2017.
//  Copyright © 2017 lbencs. All rights reserved.
//
#if TARGET_OS_IOS
#import "UIResponder+Chain.h"

@implementation UIResponder (Chain)
- (void)sendWithEvent:(NSString *_Nonnull)event info:(NSDictionary<NSString *, id> *_Nullable)info {
    [[self nextResponder] sendWithEvent:event info:info];
}

@end
#endif
