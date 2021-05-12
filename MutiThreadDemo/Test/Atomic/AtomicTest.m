//
//  Atomic.m
//  MutiThreadDemo
//
//  Created by lben on 2021/5/1.
//

#import "AtomicTest.h"

@interface AtomicTest ()
@property (atomic, copy) NSString *name;
@property (atomic, strong) NSMutableString *mutableName;
@property (atomic, strong) NSMutableArray *mutableArray;
@end
@implementation AtomicTest

- (void)runAtomicPropertyTest {
    _mutableArray = [[NSMutableArray alloc] init];

    NSMutableString *mutableName = [[NSMutableString alloc] init];
    _mutableName = mutableName;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i < 1100; i++) {
            [mutableName appendString:@"1"];
            // 会奔溃 -> 数据不一致
            // DESC : - 数据不一致，导致奔溃
            [mutableName deleteCharactersInRange:NSMakeRange(0, 1)];
            [self->_mutableArray addObject:@(i)];
            NSLog(@"%d %@ => %@", i, [NSThread currentThread], self.mutableName);
        }
    });

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        @synchronized(self) {
        for (int i = 0; i < 1100; i++) {
            self.name = @"lemon";
            NSLog(@"%d %@ => %@", i, [NSThread currentThread], self.mutableName);
            [self->_mutableArray addObject:@(i)];
            [self.mutableName appendString:[NSString stringWithFormat:@"%@", @(i % 10)]];
//                assert([self.name isEqual:@"lemon"]);
        }
//        }
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        @synchronized(self) {
        for (int i = 0; i < 1100; i++) {
            self.name = @"well";
            [self->_mutableArray removeObjectAtIndex:1];
            NSLog(@"%d %@ => %@", i, [NSThread currentThread], self.mutableName);
            if ([self.mutableName length] > 0) {
                [self.mutableName deleteCharactersInRange:NSMakeRange(0, 1)];
            }
//                assert([self.name isEqual:@"well"]);
        }
//        }
    });
}

@end
