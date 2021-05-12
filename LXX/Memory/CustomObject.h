//
//  CustomObject.h
//  MemoryDome
//
//  Created by lben on 2019/8/1.
//  Copyright © 2019 lben. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomObject : NSObject {
    long long objects[1024*1024*1024];
}
@end

NS_ASSUME_NONNULL_END
