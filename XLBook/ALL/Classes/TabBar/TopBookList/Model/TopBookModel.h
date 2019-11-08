//
//  TopBookModel.h
//  XLBook
//
//  Created by Lee on 2019/10/21.
//  Copyright © 2019 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TopBookOneBookDModel.h"
#import "XLTopBookOneHeaderView.h"
#import "XLBookReadZJLBModel.h"
#define TopBookModelManager [TopBookModel shareReadingManager]
NS_ASSUME_NONNULL_BEGIN

@interface TopBookModel : NSObject
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *zjlbBookArr;
@property (nonatomic, strong) TopBookOneBookDModel *topBookOneBookDModel;
@property (nonatomic, strong) XLBookReadZJLBModel *xlBookReadZJLBModel;
- (void)getAllClassify:(NSString *)urlString success:(void (^)(NSInteger maxPage))success;
- (void)getAllReadBookZJLB:(NSString *)urlString BookIDString:(NSString *)bookIDString;
- (void)getAllReadBookZJNR:(NSString *)urlString
                 ChapterID:(NSString *)chapterID
              bookIDString:(NSString *)idString
                   success:(void (^)(id responseObject))success
                   failure:(void (^)(NSError *error))failure;
- (void)getOneBookClassifyWithTableView:(UITableView *)tableView           WithHeaderxlTopBookOneHeaderView:(XLTopBookOneHeaderView *)xlTopBookOneHeaderView
                       WithUrlString:(NSString *)urlString
                             success:(void (^)(id responseObject))success
                             failure:(void (^)(NSError *error))failure;
- (void)getAllReadBookZJNR:(NSString *)urlString;

- (void)reloadData;
+ (instancetype)shareReadingManager;
/** 小说字体大小 */
@property (nonatomic, assign) NSUInteger font;

@property (nonatomic, copy) NSString *summaryId;

/** 目录数组 */
@property (nonatomic, strong) NSArray <XLBookReadZJLBModel *>*chapters;
/** 记录当前第n章 */
@property (nonatomic, assign) NSUInteger chapter;
@property (nonatomic, assign) NSInteger pagePrevious;

- (void)pagingWithBounds:(CGRect)bounds withFont:(UIFont *)font andChapter:(XLBookReadZJNRModel *)xlBookReadZJNRModel;

- (NSAttributedString *)getStringWithpage:(NSInteger)page nsadna:(XLBookReadZJNRModel *)model;
- (NSString *)adjustParagraphFormat:(NSString *)string;
@end

NS_ASSUME_NONNULL_END
