//
//  OCObject.h
//  BaseDemo
//
//  Created by lben on 2018/11/14.
//  Copyright © 2018 lben. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OCObject : NSObject <NSCoding, NSSecureCoding> {
    NSObject * _var;
    int * _intVar;
    float * _floatVar;
}
@property (nonatomic, strong) NSObject *objArg;
@property (nonatomic, strong) NSNumber *numberArg;
@property (nonatomic, assign) NSInteger integerArg;

- (void)method;
+ (void)classMethod;

@end

NS_ASSUME_NONNULL_END
