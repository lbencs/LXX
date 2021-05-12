//
//  Test.h
//  LXX
//
//  Created by lben on 2021/1/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Test : NSObject
@property (nonatomic, unsafe_unretained, readonly, nonnull, getter = getName) NSString *name;
+ (void)test;
@end

NS_ASSUME_NONNULL_END
