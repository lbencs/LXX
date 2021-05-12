//
//  Question.h
//  RuntimeTests
//
//  Created by lben on 2020/7/8.
//  Copyright © 2020 lben. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RunViewController : UIViewController
@end

@interface Sark : NSObject
@property (nonatomic, copy) NSString *name;
- (void)speak;
@end

@interface Question : NSObject
+ (void)q0;
+ (void)q1;
- (void)q3;
@end

NS_ASSUME_NONNULL_END
