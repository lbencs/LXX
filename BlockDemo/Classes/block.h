//
//  __block_impl.h
//  LXX
//
//  Created by lben on 2021/3/26.
//

#ifndef __block_impl_h
#define __block_impl_h

typedef struct __block_impl {
    void *isa;
    int Flags;
    int Reserved;
    void *FuncPtr;
} __block_impl;




#endif /* __block_impl_h */
