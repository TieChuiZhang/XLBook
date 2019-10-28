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

@interface XLBookReadZJNRModel : NSObject
/** 书籍id*/
@property (nonatomic, copy) NSString *id;
/** 书籍名称*/
@property (nonatomic, copy) NSString *name;
/** 章节名称*/
@property (nonatomic, copy) NSString *cname;
/** 章节id*/
@property (nonatomic, copy) NSString *cid;
/** 下一章id*/
@property (nonatomic, copy) NSString *nid;
/** 章节内容*/
@property (nonatomic, copy) NSString *content;

@property (nonatomic, strong) NSMutableArray *pageDatas;
@property (nonatomic, strong) NSMutableAttributedString *attributedString;
@property (nonatomic, assign) NSInteger pageCount;

@end

NS_ASSUME_NONNULL_END
