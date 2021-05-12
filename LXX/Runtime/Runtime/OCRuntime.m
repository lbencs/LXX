//
//  OCRuntime.m
//  BaseDemo
//
//  Created by lben on 2018/11/14.
//  Copyright © 2018 lben. All rights reserved.
//

#import "OCRuntime.h"
#import <objc/runtime.h>
//send message
#import <objc/message.h>
#import "OCObject.h"

void PrintMethodLists(Class class)
{
    unsigned int count = 0;
    Method *classmethodList = class_copyMethodList(class, &count);
    for (int i = 0; i < count; i++) {
        //
        Method method = classmethodList[i];

        //typedef struct objc_selector *SEL;
        SEL nameSel = method_getName(method);

        NSString *name = NSStringFromSelector(nameSel);
        NSString *type = [NSString stringWithUTF8String:method_getTypeEncoding(method)];

        //A pointer to the start of a method implementation.
        IMP imp = method_getImplementation(method);
        NSLog(@"The method name: %@, type: %@, imp: %p", name, type, imp);
    }
}

void PropertyPrint(Class class)
{
    unsigned int count = 0;
    objc_property_t *list = class_copyPropertyList(class, &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = list[i];
        NSString *key = [NSString stringWithUTF8String:property_getName(property)];
        NSString *type = [NSString stringWithUTF8String:property_getName(property)];

        NSLog(@"The property name: %@, type: %@", key, type);
    }
}

void addToOcClassMethod()
{
    NSLog(@"%@", @"addToOcClassMethod");
}

@implementation OCRuntime

- (OCRuntime *)run {
    NSLog(@"--------【Start】OCRuntime----------------");

    //get class
    Class ocClass = objc_getClass("OCObject");
    NSLog(@"👉 %@", ocClass);

    //new object from class
    OCObject *oc = [ocClass new];
    oc.numberArg = @3;
    oc.integerArg = 2;
    oc.objArg = [NSObject new];
    NSLog(@"%@", oc);

    //get var list
    NSLog(@"👉 GET var list");
    unsigned int ivarCount = 0;
    Ivar *ivarlist = class_copyIvarList(ocClass, &ivarCount);
    NSLog(@"Number of ivars in OCObject: %d", ivarCount);
    for (int i = 0; i < ivarCount; i++) {
        Ivar ivar = ivarlist[i];
        NSString *name = [NSString stringWithUTF8String:ivar_getName(ivar)];
        NSString *type = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        long offset = ivar_getOffset(ivar);
        NSLog(@"The ivar name: %@, type: %@, offset: %ld", name, type, offset);
    }

    //get property list
    NSLog(@"👉 GET property list");
    PropertyPrint(ocClass);
    IMP imp = addToOcClassMethod;
    SEL impName = NSSelectorFromString(@"addToOcClassMethod");

    //add method
    class_addMethod(ocClass, impName, imp, "v@:");

//    class_addIvar(ocClass, "addNewIvar", sizeof(int), <#uint8_t alignment#>, <#const char * _Nullable types#>)

    //get method list
    NSLog(@"👉 GET method list");
    PrintMethodLists(ocClass);

    //get Class method list
    NSLog(@"👉 GET class method list");
    PrintMethodLists(object_getClass(ocClass));

    return self;
}

- (OCRuntime *)archive {
    NSLog(@"--------archive-------------");
    OCObject *oc = [[OCObject alloc] init];
    oc.integerArg = 1;
    oc.numberArg = @2;

    NSLog(@"description: %@", [oc debugDescription]);

    //老接口
//    NSString *file = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true).firstObject;
//    file = [file stringByAppendingString:@"/txt.tmp"];
//    NSLog(@"%@", file);
//    if ([NSKeyedArchiver archiveRootObject:oc toFile:file]) {
//        NSLog(@"archive success");
//    } else {
//        NSLog(@"archive error");
//    }
//    NSData *data = [NSData dataWithContentsOfFile:file];
//    id unarchive = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//    NSLog(@"description: %@", [unarchive debugDescription]);

    //新api  securty
    NSError *archiveError = nil;
    NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:oc requiringSecureCoding:true error:&archiveError];

    NSLog(@"archive error: %@", archiveError);
    NSLog(@"data: %@", archivedData);

    NSError *unArchiveError = nil;
    id unarchiveObjc = [NSKeyedUnarchiver unarchivedObjectOfClass:[oc class] fromData:archivedData error:&unArchiveError];

    NSLog(@"unarchive error: %@", unArchiveError);

    NSLog(@"description: %@", [unarchiveObjc debugDescription]);
    NSLog(@"--------【End】----------");

    return self;
}

- (void)send_message {
}

- (void)getPropertyLists {
}

@end
