//
//  XLBookReadZJLBModel.h
//  XLBook
//
//  Created by Lee on 2019/10/24.
//  Copyright © 2019 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XLBookReadZJLBModel : NSObject
/** hasContent */
@property (nonatomic, copy) NSString *hasContent;
/** 章节id*/
@property (nonatomic, copy) NSString *id;
/** 章节名称*/
@property (nonatomic, copy) NSString *name;
@end

NS_ASSUME_NONNULL_END
