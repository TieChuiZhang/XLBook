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
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *zjlbBookArr;
@property (nonatomic, strong) TopBookOneBookDModel *topBookOneBookDModel;
@property (nonatomic, strong) XLBookReadZJLBModel *xlBookReadZJLBModel;
- (void)getAllClassify:(NSString *)urlString;
- (void)getAllReadBookZJLB:(NSString *)urlString WithUseCache:(BOOL)userCache;
- (void)getAllReadBookZJNR:(NSString *)urlString
                   success:(void (^)(id responseObject))success
                   failure:(void (^)(NSError *error))failure;
- (void)getOneBookClassifyWithTableView:(UITableView *)tableView           WithHeaderxlTopBookOneHeaderView:(XLTopBookOneHeaderView *)xlTopBookOneHeaderView
                       WithUrlString:(NSString *)urlString
                             success:(void (^)(id responseObject))success
                             failure:(void (^)(NSError *error))failure;
- (void)getAllReadBookZJNR:(NSString *)urlString;

- (void)reloadData;
+ (instancetype)shareReadingManager;

@property (nonatomic, copy) NSString *summaryId;

/** 目录数组 */
@property (nonatomic, strong) NSArray <XLBookReadZJLBModel *>*chapters;
@end

NS_ASSUME_NONNULL_END
