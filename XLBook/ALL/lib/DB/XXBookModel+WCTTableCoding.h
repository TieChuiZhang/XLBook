//
//  XXBookModel+WCTTableCoding.h
//  Novel
//
//  Created by xx on 2018/9/4.
//  Copyright © 2018年 th. All rights reserved.
//

//#import "XXBookModel.h"
#import "TopBookOneBookDModel.h"
#import <WCDB/WCDB.h>
@interface TopBookOneBookDModel (WCTTableCoding) <WCTTableCoding>

WCDB_PROPERTY(Id)
//WCDB_PROPERTY(coverURL)
//WCDB_PROPERTY(Name)
//WCDB_PROPERTY(updateStatus)
//WCDB_PROPERTY(page)
//WCDB_PROPERTY(updated)
//WCDB_PROPERTY(chapter)
//WCDB_PROPERTY(lastChapter)
WCDB_PROPERTY(addTime)
//WCDB_PROPERTY(id)



///**书籍id  */
//@property (nonatomic, copy) NSString *Id;
///**书名  */
//@property (nonatomic, copy) NSString *Name;
///**书籍作者  */
//@property (nonatomic, copy) NSString *Author;
///**图片链接  */
//@property (nonatomic, copy) NSString *Img;
///**书籍简介  */
//@property (nonatomic, copy) NSString *Desc;
///**书籍类型  */
//@property (nonatomic, copy) NSString *CName;
///**书籍状态  */
//@property (nonatomic, copy) NSString *BookStatus;
///**更新时间  */
//@property (nonatomic, copy) NSString *LastTime;
///**最新章节  */
//@property (nonatomic, copy) NSString *LastChapter;
///**??? */
//@property (nonatomic, copy) NSString *FirstChapterId;
//@property (nonatomic, copy) NSString *LastChapterId;
///**作者还写过  */
//@property (nonatomic, copy) NSArray *SameUserBooks;
///**类似书籍  */
//@property (nonatomic, copy) NSArray *SameCategoryBooks;
@end
