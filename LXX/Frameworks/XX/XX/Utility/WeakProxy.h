//
//  WeakProxy.h
//  Label
//
//  Created by lben on 2021/1/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeakProxy : NSProxy
@property (nullable, weak, nonatomic, readonly) id target;

- (instancetype)initWithTarget:(id)target;
@end

NS_ASSUME_NONNULL_END
