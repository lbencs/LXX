//
//  BlockTestObject.h
//  RunloopDemo
//
//  Created by lben on 2021/4/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BlockTestObject : NSObject
@property (nonatomic, copy) void (^ block)(void);
@end

NS_ASSUME_NONNULL_END
