//
//  ViewController.m
//  BlockDemo
//
//  Created by lben on 2021/3/26.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import <objc/objc.h>
#import <objc/message.h>
#import "block.h"
#import "block_impl_0.h"

//#import <ffi/ffi.h>

void PrintHelloWorld()
{
    NSLog(@"Hello world!");
}

void HookBlockToPrintHelloWorld(id block)
{
    /** 替换Block的实现*/
    __block_impl *ptr = (__bridge __block_impl *)block;
    NSLog(@"%@", ptr->isa);
    ptr->FuncPtr = &PrintHelloWorld;
}

struct __main_block_desc_1 {
    size_t reserved;
    size_t Block_size;
};

struct __main_block_impl_1 {
    struct __block_impl impl;
    struct __main_block_desc_1 *Desc;
};


struct Block_layout {
    void *isa;
    int flags;
    int reserved;
    void (*invoke)(void *, ...);
    struct Block_descriptor *descriptor;
};

typedef void (^BlockFunc)(int a, NSString *str);
static BlockFunc replaceFunc;
void (*funcPtr)(struct __main_block_impl_1 *__cself, int, NSString *);

static void __main_block_func_1(struct __main_block_impl_1 *__cself, int a, NSString *str)
{
    NSLog(@"%d -- %@", a, str);
    funcPtr(__cself, a, str);
}
void HookBlockToPrintArguments(id block)
{
    /** 获取Block的参数*/
    struct __main_block_impl_1 *ptr = (__bridge struct __main_block_impl_1 *)block;
    funcPtr = ptr->impl.FuncPtr;
//    replaceFunc = ^(int a, NSString *str) {
//        funcPtr(ptr, a, str);
//        NSLog(@"%d -- %@", a, str);
//    };
//    __block_impl *ptr2 = (__bridge __block_impl *)replaceFunc;
//    NSLog(@"%@", replaceFunc);
    ptr->impl.FuncPtr = &__main_block_func_1;//ptr2->FuncPtr;
//    void (*block3)(int a, NSString *str) = ((void (*)(int, NSString *)) & __main_block_impl_1((void *)__main_block_func_1, &__main_block_desc_1_DATA));
//    ((void (*)(__block_impl *, int, NSString *))((__block_impl *)block3)->FuncPtr)((__block_impl *)block3, 1, "aaa");
}

void HookEveryBlockToPrintArguments() {
    
}

@interface ViewController ()
@property (nonatomic, copy) dispatch_block_t block;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     堆上面的Block才能修改
     */
//    [self block:1];
//    int i = 1;
//    [self test:^{
//        NSLog(@"Test block %d", i);
//    }];
//    [self test2];
//    [self q1];
    test_ref_func();
}

- (void)q1 {
    int tmp = 0;
    void (^ block2)(int a, NSString *b) = ^(int a, NSString *b) {
        NSLog(@"block invoke %d", tmp);
    };
    NSLog(@"q1 => %@", block2);
    HookBlockToPrintArguments(block2);
    NSLog(@"q1 => %@", block2);
    block2(123, @"aaa");
}

- (NSArray *)getBlockArray
{
    int num = 123;
    NSArray *array = [[NSArray alloc] initWithObjects:
                      ^{ NSLog(@"this is block 0:%i", num); },
                      ^{ NSLog(@"this is block 1:%i", num); },
                      ^{ NSLog(@"this is block 2:%i", num); },
                      nil];
    NSLog(@"%@", array);
    return array;
}

- (void)test2
{
    /**
     1. 第一个元素在堆中，剩余的在栈中。
     */
    NSArray<dispatch_block_t> *obj = [self getBlockArray];
    NSLog(@"test block array %@", obj);
}

- (void)test:(dispatch_block_t)block {
    NSLog(@"%@ %@", NSStringFromSelector(_cmd), block);
}

- (void)block:(int)value {
//    __block int a = 0;
    dispatch_block_t block = ^{
//        a++;
        NSLog(@"Hello ViewController %d", value);
    };
    CGFloat f = 1.1;
    NSLog(@"%@", ^{ NSLog(@"%lf", f); });
    HookBlockToPrintHelloWorld(block);
    block();
}

@end
