//
//  CFFundationTest.m
//  MemoryTestDemo
//
//  Created by lben on 2021/5/2.
//

#import "CFFundationTest.h"

@implementation CFFundationTest

+ (void)test {
    CFDictionaryRef dic = CFDictionaryCreateMutable(NULL, 0, NULL, NULL);
    CFStringRef hello = CFStringCreateWithCString(NULL, "hello", kCFStringEncodingUTF8);
    CFDictionaryAddValue(dic, "key", hello);
//    NSLog(@"%@", (__bridge NSDictionary *) dic);
    NSLog(@"%@", (__bridge  NSString *)hello);
}
@end
