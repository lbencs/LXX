//
//  OCProxy.h
//  Label
//
//  Created by lben on 2021/1/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OCProxy : NSObject
@property (nullable, nonatomic, weak, readonly) id target;
- (instancetype)initWithTarget:(id)target;
@end

NS_ASSUME_NONNULL_END
