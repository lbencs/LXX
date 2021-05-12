//
//  NSObject+Dealloc.h
//  DomeUI
//
//  Created by lben on 2019/4/3.
//  Copyright © 2019 lben. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Dealloc)

- (void)xx_deallocBlock:(void(^ _Nonnull)(void))block;

@end

NS_ASSUME_NONNULL_END
