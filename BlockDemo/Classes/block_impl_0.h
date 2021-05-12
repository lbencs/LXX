//
//  block_impl_0.h
//  LXX
//
//  Created by lben on 2021/3/26.
//

#ifndef block_impl_0_h
#define block_impl_0_h
#import "block.h"

/**
 char 1个字节
 int 1个字节

 */

// block_byref_b
typedef struct __Block_byref_b_0 {
    void *__isa;
    struct __Block_byref_b_0 *__forwarding;      //为什么？要forwarding一次？
    int __flags;  //??
    int __size;   //内存大小 sizeof(__Block_byref_b_0)
    int b;  //捕获的值
} __Block_byref_b_0;

void print_ref_struct(__Block_byref_b_0 *aStruct)
{
    NSLog(@"b = %d", aStruct->b);
    NSLog(@"b = %d", aStruct->__forwarding->b);
    NSLog(@"==> ref = %p", aStruct);
    NSLog(@"==> forwarding = %p", aStruct->__forwarding);
    memcpy(<#void *__dst#>, <#const void *__src#>, <#size_t __n#>)
}

void test_ref_func()
{
//    struct __Block_byref_b_0 * ref = (struct __Block_byref_b_0 *)malloc(sizeof(struct __Block_byref_b_0 *));

    __Block_byref_b_0 ref = {
        .__isa        = NULL,
        .__forwarding = &ref,
        .__size       = sizeof(__Block_byref_b_0),
        .b            = 0
    };
    ref.__forwarding->b = 2;
    print_ref_struct(&ref);
//    NSLog(@"%p", &ref);
//    NSLog(@"==>> %d", ref.b);
//    NSLog(@"==>> %d", ref.__forwarding->b);
//    NSLog(@"==> ref = %p", ref);
//    NSLog(@"==> forwarding = %p", ref.__forwarding);
}

struct __main_block_impl_0 {
    struct __block_impl impl;
    struct __main_block_desc_0 *Desc;

#if 0
    __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, int flags = 0)
    {
        impl.isa = &_NSConcreteStackBlock;
        impl.Flags = flags;
        impl.FuncPtr = fp;
        Desc = desc;
    }

#endif
};

static void __main_block_func_0(struct __main_block_impl_0 *__cself)
{
    //
}

static struct __main_block_desc_0 {
    size_t reserved;
    size_t Block_size;
} __main_block_desc_0_DATA = { 0, sizeof(struct __main_block_impl_0) };

#endif /* block_impl_0_h */
