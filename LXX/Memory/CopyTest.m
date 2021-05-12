//
//  CopyTest.m
//  LXX
//
//  Created by lben on 2021/3/10.
//

#import "CopyTest.h"
#import "LXX-Swift.h"
#import <Foundation/NSObjCRuntime.h>
#import <objc/runtime.h>
//#import <NS>
//NSArray *globalArray = @[@1, @2, @3];
int global_j;
int global_i = 1;
static int static_i = 1;
const int const_i = 1;
const float const_j = 1.2;
/**
 代码段
 常量区
 静态变量（全局区）
 堆  0x6
 栈  0x7
 */
@interface CopyTest ()
@property (nonnull, nonatomic, copy) NSString *testString;
@property (nonnull, nonatomic, copy) void (^ propertyBlock)(void);
@end
@implementation CopyTest

- (os_block_t)returnBlock {
    __block int add = 10;
    os_block_t blk_h = ^{
        NSLog(@"[memory] add=%d\n", ++add);
    };
    return blk_h;
}

- (void)test {
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    [mutableArray addObject:[[_MutableCopyObject alloc] init]];

    void (^ block)(void) = ^{
        // __NSGlobalBlock__
        NSLog(@"1");
    };
    void (^ block2)(void) = nil;

    // __NSGlobalBlock__
    _propertyBlock = block;
    block2 = block;
    void (^ GlobalBlock)(void) = ^{
        NSLog(@"[memory] 执行GlobalBlock");
    };
    int a = 10;
    void (^ MallocBlock)(void) = ^{
        NSLog(@"[memory] 执行MallocBlock- %d", a);
    };

    __block int stack_a = 1;
    void (^ __weak StackBlock)(void) = ^{
        NSLog(@"[memory] 执行StackBlock- %d", stack_a);
    };

    GlobalBlock();
    MallocBlock();

    // 创建以后没有立即被释放
    __weak NSString *weakString = @"this is a weak string";
    // 创建以后立即被释放了
    __weak NSMutableString *weakMutableString = @"this is a weak mutable string".mutableCopy;
    NSMutableString *mutableString = [[NSMutableString alloc] initWithString:@"this is a mutable string"];
    // 栈区，无需手动管理内存
    __block int b = 11;
    for (int i = 0; i < 1; i++) {
        // 栈区
        NSLog(@"[memory] for in i %p", &i);
    }
    NSLog(@"[memory] int b %p", &b);
    int c = 10;
    NSLog(@"[memory] int c %p", &c);

    NSLog(@"[memory] 我是全局block--%@", GlobalBlock);
    NSLog(@"[memory] 我是堆block--%@", MallocBlock);
    NSLog(@"[memory] 我是栈%@", StackBlock);
    StackBlock();
    NSLog(@"[memory] weakString %@ %p", weakString, weakString);
    NSLog(@"[memory] weakMutableString %@ %p", weakMutableString, weakMutableString);
    NSLog(@"[memory] mutableString %@ %p point addr: %p", mutableString, mutableString, &mutableString);
    NSLog(@"[memory] mutable array %p", mutableArray);
    NSLog(@"[memory] mutable copy %p", [mutableArray mutableCopy]);
    NSLog(@"[memory] copy %p", [mutableArray copy]);

    NSLog(@"[memory] global_i %p", &global_i);
    NSLog(@"[memory] global_j %p", &global_j);
    NSLog(@"[memory] static_i %p", &static_i);

    NSLog(@"[memory] const_i %p", &const_i);
    NSLog(@"[memory] const_j %p", &const_j);

    NSLog(@"[memory] block %@", block);
    NSLog(@"[memory] _block %@", _propertyBlock);
    NSLog(@"[memory] block2 %@", block2);
    NSLog(@"[memory] [self returnBlock] %@", [self returnBlock]);

    NSLog(@"[memory] %@", [[NSArray alloc] initWithArray:mutableArray copyItems:true]);
    NSLog(@"[memory] %@", [[NSMutableArray alloc] initWithArray:mutableArray copyItems:true]);
}

@end
