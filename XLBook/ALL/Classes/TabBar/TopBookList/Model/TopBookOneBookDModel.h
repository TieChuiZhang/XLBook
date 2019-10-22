//
//  TopBookOneBookDModel.h
//  XLBook
//
//  Created by Lee on 2019/10/22.
//  Copyright © 2019 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TopBookOneBookDModel : NSObject
/**书籍id  */
@property (nonatomic, copy) NSString *Id;
/**书名  */
@property (nonatomic, copy) NSString *Name;
/**书籍作者  */
@property (nonatomic, copy) NSString *Author;
/**图片链接  */
@property (nonatomic, copy) NSString *Img;
/**书籍简介  */
@property (nonatomic, copy) NSString *Desc;
/**书籍类型  */
@property (nonatomic, copy) NSString *CName;
/**书籍状态  */
@property (nonatomic, copy) NSString *BookStatus;
/**更新时间  */
@property (nonatomic, copy) NSString *LastTime;
/**最新章节  */
@property (nonatomic, copy) NSString *LastChapter;
/**??? */
@property (nonatomic, copy) NSString *FirstChapterId;
@property (nonatomic, copy) NSString *LastChapterId;
/**作者还写过  */
@property (nonatomic, copy) NSArray *SameUserBooks;
/**类似书籍  */
@property (nonatomic, copy) NSArray *SameCategoryBooks;
/**书票 其中包含
     "BookId":375026,
     "TotalScore":401,
     "VoterCount":44,
     "Score":9.1  */
@property (nonatomic, copy) NSDictionary *BookVote;
@end
NS_ASSUME_NONNULL_END
