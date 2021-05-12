//
//  DuckTyping.m
//  Label
//
//  Created by lben on 2021/1/19.
//

#import "DuckTyping.h"
/**
 If it quacks like a duck, it walks like a duck,… to me, it’s a duck
 If it responds to the same methods as type X, treat it as if were a type X
 */
#pragma mark - Duck
@interface Duck : NSObject
- (void)say;
@end

@implementation Duck
- (void)say {
    NSLog(@"I'am is Duck");
}

@end
#pragma mark - RobotDuck
@interface RobotDuck : NSObject
- (void)say;
@end

@implementation RobotDuck
- (void)say {
    NSLog(@"I'am is Robot Duck");
}

@end

@implementation DuckTyping
+ (void)test {
    Duck *duck = [[RobotDuck alloc] init];
    [duck say];
}

@end
