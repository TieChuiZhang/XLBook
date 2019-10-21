//
//  XLAPI.h
//  XLBook
//
//  Created by Lee on 2019/10/21.
//  Copyright © 2019 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XLAPI : NSObject
///获取首页的推荐列表
+ (void)getHomeRecommandListComplete:(httpCompleteBlock)completeBlock;
///获取所有可用源
+ (void)getSourcesWithBookId:(NSString *)bookId complete:(httpCompleteBlock)completeBlock;
///获取章节文章
+ (void)getBookContentWithChapter:(NSString *)chapterLink complete:(httpCompleteBlock)completeBlock;
///获取章节目录
+ (void)getBookChaptersWithsourceId:(NSString *)sourceId complete:(httpCompleteBlock)completeBlock;
///获取所有分类
//+ (void)getAllClassifyListComplete:(httpCompleteBlock)completeBlock;
+ (void)getAllClassifyWithUrlString:(NSString *)urlString ListComplete:(httpCompleteBlock)completeBlock;
///获取对应分类的相关书籍列表
+ (void)getClassifyBooksWithGroupKey:(NSString *)key major:(NSString *)major pageIndex:(NSInteger)index pageSize:(NSInteger)pageSize complete:(httpCompleteBlock)completeBlock;
///获取书籍详情
+ (void)getBookDetailWithId:(NSString *)bookId complete:(httpCompleteBlock)completeBlock;
///搜索提示
+ (void)getSearchTipsWithKeyword:(NSString *)keyword complete:(httpCompleteBlock)completeBlock;
///搜索书籍
+ (void)getSearchBooksWithKeyword:(NSString *)keyword complete:(httpCompleteBlock)completeBlock;
@end

NS_ASSUME_NONNULL_END
