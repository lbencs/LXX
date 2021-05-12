//
//  Question.m
//  RuntimeTests
//
//  Created by lben on 2020/7/8.
//  Copyright © 2020 lben. All rights reserved.
//

#import "Question.h"

@implementation Sark
- (void)speak {
    NSLog(@"q3 - [self.name] => %@", self.name);
}

@end

@implementation RunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    id cls = [Sark class];
    void *obj = &cls;
    [(__bridge id)obj speak];
}

@end

@interface Question ()
@property (nonatomic, strong) NSString *target;
@end

@implementation Question

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"q0 - [self class] => %@", [self class]);
        NSLog(@"q0 - [super class] => %@", [super class]);
    }
    return self;
}

+ (void)q0 {
    [Question new];
}

+ (void)q1 {
    //https://halfrost.com/objc_runtime_isa_class/#toc-15
    //
    /**
                                     NSObject
     object (isa)-> NSObject (isa)-> NSObjectMeteClass
     super
     question (isa) -> Question (isa) -> QuestionMeteClass

     (id)[NSObject class] -> 类对象  isa -> Mate Class -> NSObject

     (id)[Question class] -> 类对象 isa -> QuestionMateClass -> NSObjectMateClass -> NSObject
     */

    NSLog(@"q1 - [(id)[NSObject class] isKindOfClass:[NSObject class]] => %d [%@]", [(id)[NSObject class] isKindOfClass:[NSObject class]], [NSObject class]);
    // 类对象 是 元类的 instance => false
    NSLog(@"q1 - [(id)[NSObject class] isMemberOfClass:[NSObject class]] => %d", [(id)[NSObject class] isMemberOfClass:[NSObject class]]);

    NSLog(@"q1 - [(id)[Question class] isKindOfClass:[Question class]] => %d [%@]", [(id)[Question class] isKindOfClass:[Question class]], [Question class]);
    // 类对象 是 元类的 instance => false
    NSLog(@"q1 - [(id)[Question class] isMemberOfClass:[Question class]] => %d", [(id)[Question class] isMemberOfClass:[Question class]]);
}

- (void)q3 {
//    id cls = [Sark class];
//    void *obj = &cls;
//    [(__bridge id)obj speak];
}

- (void)q4 {
    //....
    dispatch_queue_t queue = dispatch_queue_create("parallel", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 1000000; i++) {
        dispatch_async(queue, ^{
            self.target = [NSString stringWithFormat:@"ksddkjalkjd%d", i];
        });
    }
//    - (void)setTarget:(NSString *)target {
//        if (target == _target) return;
//        id pre = _target;
//        [target retain];//1.先保留新值
//        _target = target;//2.再进行赋值
//        [pre release];//3.释放旧值
//    }
}

@end
