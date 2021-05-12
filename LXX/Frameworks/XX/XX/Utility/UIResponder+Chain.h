//
//  UIResponder+Chain.h
//  UIResponder
//
//  Created by lbencs on 26/07/2017.
//  Copyright © 2017 lbencs. All rights reserved.
//
#if TARGET_OS_IOS
#import <UIKit/UIKit.h>

@interface UIResponder (Chain)

- (void)sendWithEvent:(NSString *_Nonnull)event info:(NSDictionary<NSString *, id> *_Nullable)info;

@end
#endif
