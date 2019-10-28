//
//  TopBookModel.m
//  XLBook
//
//  Created by Lee on 2019/10/21.
//  Copyright © 2019 Lee. All rights reserved.
//

#import "TopBookModel.h"
#import "XLAPI.h"
#import "TopBookListModel.h"
#import "TopBookHXGModel.h"
#import "XLBookReadZJLBModel.h"
#import "XXDatabase.h"
@implementation TopBookModel

+ (instancetype)shareReadingManager {
    
    static TopBookModel *readM = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        readM = [[self alloc] init];
        
        //BookSettingModel *settingModel = [BookSettingModel decodeModelWithKey:BookSettingModel.className];
        
//        if (!settingModel) {
//            //没有存档
//            settingModel = [[BookSettingModel alloc] init];
//            settingModel.font = 20;
//            settingModel.dayMode = kDayMode_light;
//            settingModel.bgColor = kBgColor_default;
//            settingModel.transitionStyle = kTransitionStyle_default;
//            [BookSettingModel encodeModel:settingModel key:[BookSettingModel className]];
//
//            readM.font = 20;
//            readM.dayMode = settingModel.dayMode;
//            readM.bgColor = settingModel.bgColor;
//            readM.transitionStyle = settingModel.transitionStyle;
//
//        } else {
//            //已经存档了设置
//            readM.isFullTapNext = settingModel.isFullTapNext;
//            readM.font = settingModel.font;
//            readM.bgColor = settingModel.bgColor;
//            readM.transitionStyle = settingModel.transitionStyle;
//        }
    });
    
    return readM;
}

- (void)clear {
//    self.chapter = 0;
//    self.page = 0;
//    self.chapters = nil;
//    self.title = nil;
    //self.summaryId = nil;
    //self.isSave = NO;
}

- (void)getAllClassify:(NSString *)urlString
{
    [MBProgressHUD showWaitingViewText:nil detailText:nil inView:nil];
    
    [XLAPI getAllClassifyWithUrlString:urlString ListComplete:^(id result, BOOL cache, NSError *error) {
        self.dataArray = [TopBookListModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"BookList"]];
        [self reloadData];
        [MBProgressHUD dismissHUD];
    }];
}

- (void)reloadData
{
    [self.tableView reloadData];
}

-(void)getOneBookClassifyWithTableView:(UITableView *)tableView WithHeaderxlTopBookOneHeaderView:(XLTopBookOneHeaderView *)xlTopBookOneHeaderView WithUrlString:(NSString *)urlString success:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure
{
    [XLAPI getAllClassifyWithUrlString:urlString ListComplete:^(id result, BOOL cache, NSError *error) {
        TopBookOneBookDModel *topBookOneBookDModel = [TopBookOneBookDModel mj_objectWithKeyValues:result[@"data"]];
        
        self.dataArray = [TopBookHXGModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"SameUserBooks"]];
        [xlTopBookOneHeaderView setXLBookOneBookWithSXTableView:tableView HeaderValue:topBookOneBookDModel];
        self.topBookOneBookDModel = topBookOneBookDModel;
        [self reloadData];
        //TopBookOneBookDModel *model = [kDatabase getBookWithId:self.summaryId];
        //model.Id = self.summaryId;
        //[kDatabase updateBook:model];
        //= result[@"data"][@"Id"];
        self.summaryId = @"568fef99adb27bfb4b3a58dc";
        [MBProgressHUD dismissHUD];
    }];
}

- (void)getAllReadBookZJLB:(NSString *)urlString WithUseCache:(BOOL)userCache
{
    [MBProgressHUD showWaitingViewText:nil detailText:nil inView:nil];
    [XLAPI getAllClassifyWithUrlString:urlString ListComplete:^(id result, BOOL cache, NSError *error) {
        self.zjlbBookArr = [XLBookReadZJLBModel mj_objectArrayWithKeyValuesArray:[result[@"data"][@"list"] firstObject][@"list"]];
        [kDatabase deleteChaptersWithSummaryId:self.summaryId];
        if ([kDatabase insertChapters:self.zjlbBookArr summaryId:self.summaryId]) {
            NSLog(@"目录插入成功");
        }
        else {
            NSLog(@"目录插入失败");
        }
        [self reloadData];
        [MBProgressHUD dismissHUD];
    }];
}

- (void)getAllReadBookZJNR:(NSString *)urlString success:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure
{
    [MBProgressHUD showWaitingViewText:nil detailText:nil inView:nil];
    [XLAPI getAllClassifyWithUrlString:urlString ListComplete:^(id result, BOOL cache, NSError *error) {
        NSLog(@"%@",result);
        XLBookReadZJNRModel *xlBookReadZJNRModel = [XLBookReadZJNRModel mj_objectWithKeyValues:result[@"data"]];
        success(xlBookReadZJNRModel);
        [self reloadData];
        [MBProgressHUD dismissHUD];
    }];
}

@end
