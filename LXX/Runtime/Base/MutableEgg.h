//
//  MutableEgg.h
//  BaseDemo
//
//  Created by lben on 2018/12/4.
//  Copyright © 2018 lben. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Egg.h"
NS_ASSUME_NONNULL_BEGIN

@interface MutableEgg : Egg

@property (nonatomic, readwrite, assign) NSInteger size;

@property (assign) NSInteger weight;

@property (atomic, readwrite, assign) NSInteger age;

@property (nonatomic, assign) NSInteger xxx;

- (void)increase;

@end

NS_ASSUME_NONNULL_END
