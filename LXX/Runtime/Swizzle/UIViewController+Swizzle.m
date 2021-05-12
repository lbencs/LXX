//
//  UIViewController+Swizzle.m
//  CookBook
//
//  Created by lben on 2020/8/6.
//  Copyright © 2020 lben. All rights reserved.
//

#import "UIViewController+Swizzle.h"
#import "Swizzle.h"
#import <objc/message.h>

@implementation UIViewController (Swizzle)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        SEL swizzleSelector = NSSelectorFromString(@"swizzle_viewWillAppear");
//        [Swizzle originalSelector:@selector(viewWillAppear:) replaceSelector:swizzleSelector forClass:[UIViewController class] withIMPBlock: ^(UIViewController *_self, BOOL animated) {
//            NSLog(@"%@--------%@ swizzed", NSStringFromSelector(_cmd), _self);
//            ((void (*)(id, SEL, BOOL))objc_msgSend)(_self, swizzleSelector, animated);
//        }];

        SEL swizzleDidAppearSelector = NSSelectorFromString(@"swizzle_viewDidAppear");
        SEL originalAdidAppearSelector = NSSelectorFromString(@"original_viewDidAppear");
        [Swizzle originalSelector:originalAdidAppearSelector replaceSelector:swizzleDidAppearSelector forClass:[UIViewController class] withIMPBlock: ^(UIViewController *_self, BOOL animated) {
//            NSLog(@"%@--------%@ swizzed", NSStringFromSelector(_cmd), _self);
            ((void (*)(id, SEL, BOOL))objc_msgSend)(_self, swizzleDidAppearSelector, animated);
        }];

//        SEL swizzleTouchesBeganSelector = NSSelectorFromString(@"swizzle_touchesBegan:withEvent:");
//
        __block IMP originalImp = [Swizzle originalSelector:@selector(touchesBegan:withEvent:) forClass:self withIMPBlock:^(UIViewController *_self, NSSet<UITouch *> *touches, UIEvent *event) {
//            NSLog(@"%@--------%@ swizzed", NSStringFromSelector(_cmd), _self);
            
            ((void (*)(id, SEL, NSSet<UITouch *> *, UIEvent *))originalImp)(_self, @selector(touchesBegan:withEvent:), touches, event);
        }];

//        [Swizzle originalSelector:@selector(touchesBegan:withEvent:) replaceSelector:swizzleTouchesBeganSelector forClass:UIViewController.class withIMPBlock:^(UIViewController *_self, NSSet<UITouch *> *touches, UIEvent *event) {
//            NSLog(@"%@--------%@ swizzed", NSStringFromSelector(_cmd), _self);
//            ((void (*)(id, SEL, NSSet<UITouch *> *, UIEvent *))objc_msgSend)(_self, swizzleTouchesBeganSelector, touches, event);
//        }];

        [Swizzle originalSelector:@selector(viewWillAppear:) replaceSelector:@selector(swizzle_viewWillAppear:) forClass:self];
    });
}

- (void)swizzle_viewWillAppear:(BOOL)animated {
//    NSLog(@"%@--> cmd 1 %@", self, NSStringFromSelector(_cmd));
    [self swizzle_viewWillAppear:animated];
//    NSLog(@"%@--> cmd 2 %@", self, NSStringFromSelector(_cmd));
}

@end
