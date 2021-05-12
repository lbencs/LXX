//
//  OCObject.m
//  BaseDemo
//
//  Created by lben on 2018/11/14.
//  Copyright © 2018 lben. All rights reserved.
//

#import "OCObject.h"
#import <objc/runtime.h>

typedef void (^ExeBlock)(NSString *key, NSString *attributes);

void MapProperty(Class class,  ExeBlock block)
{
    unsigned int count = 0;

    objc_property_t *list = class_copyPropertyList(class, &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = list[i];

        NSString *key = [NSString stringWithUTF8String:property_getName(property)];
        NSString *type = [NSString stringWithUTF8String:property_getAttributes(property)];

        block(key, type);
    }

    free(list);
}

@implementation OCObject
+ (void)classMethod {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)method {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (NSString *)debugDescription {
    NSMutableString *result = [[NSMutableString alloc] initWithString:[super debugDescription]];
    [result appendString:@"=> 【\n"];

    MapProperty([self class], ^(NSString *key, NSString *attributes) {
        id value = [self valueForKeyPath:key];

        if ([attributes isEqualToString:@"B"]) {
            value = value ? @"YES" : @"NO";
        }

        [result appendString:[NSString stringWithFormat:@"key: %@, value: %@ , attributes: %@ \n", key, value, attributes]];
    });
    [result appendString:@"】"];
    return result;
}

+ (BOOL)supportsSecureCoding {
    return true;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        MapProperty([self class], ^(NSString *key, NSString *attributes) {
            id value = [coder decodeObjectForKey:key];
            [self setValue:value forKeyPath:key];
        });
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    MapProperty([self class], ^(NSString *key, NSString *attributes) {
        id value = [self valueForKeyPath:key];
        [aCoder encodeObject:value forKey:key];
    });
}

@end
