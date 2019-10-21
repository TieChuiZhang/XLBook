//
//  LeeRunTimePush.h
//  TPXM
//
//  Created by Lee on 2019/4/1.
//  Copyright © 2019 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LeeRunTimePush : NSObject
+ (void)runtimePush:(NSString *)vcName dic:(NSDictionary *__nullable)dic nav:(UINavigationController *)nav;
@end

NS_ASSUME_NONNULL_END
