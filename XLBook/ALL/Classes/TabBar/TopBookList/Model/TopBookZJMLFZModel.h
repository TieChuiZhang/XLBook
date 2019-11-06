//
//  TopBookZJMLFZModel.h
//  XLBook
//
//  Created by Lee on 2019/11/6.
//  Copyright © 2019 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XLBookReadZJLBModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TopBookZJMLFZModel : NSObject
/** 分组名称 */
@property (nonatomic, copy) NSString *name;
/** 分组名称 */
@property (nonatomic, copy) NSArray<XLBookReadZJLBModel *> *list;
@end

NS_ASSUME_NONNULL_END
