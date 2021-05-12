//
//  ViewController.m
//  RuntimeDemo
//
//  Created by lben on 2021/3/25.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface Sark : NSObject
@property (nonatomic, copy) NSString *name;
+ (void)say;
- (void)say;
@end

@implementation Sark

+ (void)say {
    NSLog(@"class method say:");
}

- (void)say {
    NSLog(@"instance method say: %@", self.name);
}

@end

@interface Father : NSObject
- (void)say;
@end
@implementation Father
- (void)say {
    NSLog(@"%@", NSStringFromClass([self class]));
}

@end

@interface Son : Father
@end
@implementation Son
- (void)say {
    NSLog(@"son");
}

/**
 + (id)self {
     return (id)self;
 }
 - (id)self {
     return self;
 }
 + (Class)class {
     return self;
 }
 - (Class)class {
     return object_getClass(self);
 }
 + (Class)superclass {
     return self->superclass;
 }
 - (Class)superclass {
     return [self class]->superclass;
 }
 */
- (id)init
{
    self = [super init];
    if (self) {
        [self superclass];
        [self say];
        [super say];
        NSLog(@"%@", NSStringFromClass([self superclass])); //father
        NSLog(@"%@", NSStringFromClass([self class])); //son
        NSLog(@"%@", NSStringFromClass([super class])); //son
    }
    return self;
}

@end

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [(id)[Sark class] say];
    [Sark say];

    NSLog(@"%@", objc_getClass("ViewController"));
//    [self q1];
//    [self q2];
    //q3
    NSLog(@"ViewController = %@ , 地址 = %p", self, &self);

    id cls = [Sark class];
    NSLog(@"Sark class = %@ 地址 = %p", cls, &cls);
    void *obj = &cls;
    NSLog(@"Void *obj = %@ 地址 = %p", obj, &obj);

    [(__bridge id)obj say];

    Sark *sark = [[Sark alloc]init];
    NSLog(@"Sark instance = %@ 地址 = %p", sark, &sark);
    [sark say];

    void *obj2 = &cls;
//    [(__bridge id)obj say];
//    NSLog(@"%@", [(__bridge Sark *)obj2 name]);
}

- (void)q2 {
    [[Son alloc] init];
}

- (void)q1 {
    // 对象 -> 类 -> 元类
    // 类对象 -> 类对象
    //
    /**
     + (BOOL)isKindOfClass:(Class)cls {
         for (Class tcls = self->ISA(); tcls; tcls = tcls->superclass) {
             if (tcls == cls) return YES;
         }
         return NO;
     }

     + (Class)class {
         return self;
     }

     - (Class)class {
         return object_getClass(self);
     }

     - (BOOL)isKindOfClass:(Class)cls {
         for (Class tcls = [self class]; tcls; tcls = tcls->superclass) {
             if (tcls == cls) return YES;
         }
         return NO;
     }

     + (BOOL)isMemberOfClass:(Class)cls {
         return self->ISA() == cls;
     }

     - (BOOL)isMemberOfClass:(Class)cls {
         return [self class] == cls;
     }

     */

    // isKindOfClass:
    // 1. 对象 -> 类
    // 2. 类对象 -> 元类
    NSLog(@"%d", [NSObject isKindOfClass:[NSObject class]]);
    NSLog(@"%d", [NSObject isMemberOfClass:[NSObject class]]);
    NSLog(@"%d", [Sark isKindOfClass:[Sark class]]);
    NSLog(@"%d", [Sark isMemberOfClass:[Sark class]]);

    BOOL res1 = [[NSObject class] isKindOfClass:[NSObject class]];  // true
    BOOL res2 = [(id)[NSObject class] isMemberOfClass:[NSObject class]]; //false

    BOOL res3 = [(id)[Sark class] isKindOfClass:[Sark class]]; //false
    BOOL res4 = [(id)[Sark class] isMemberOfClass:[Sark class]];// false
    NSLog(@"%d %d %d %d", res1, res2, res3, res4);
}

@end
