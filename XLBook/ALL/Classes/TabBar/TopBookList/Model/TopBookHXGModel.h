//
//  TopBookHXGModel.h
//  XLBook
//
//  Created by Lee on 2019/10/23.
//  Copyright © 2019 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TopBookHXGModel : NSObject
/** 还写过书籍id */
@property (nonatomic, copy) NSString *Id;
/** 还写过书名 */
@property (nonatomic, copy) NSString *Name;
/** 还写过书籍图片 */
@property (nonatomic, copy) NSString *Img;
/** 还写过书籍评分 */
@property (nonatomic, copy) NSString *Score;
/** 最新一章名称 */
@property (nonatomic, copy) NSString *LastChapter;
/** 作者 */
@property (nonatomic, copy) NSString *Author;

@end

NS_ASSUME_NONNULL_END
