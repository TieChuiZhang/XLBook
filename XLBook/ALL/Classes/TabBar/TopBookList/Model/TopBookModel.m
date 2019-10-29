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
        
        //[kDatabase insertBook:topBookOneBookDModel];
        
        self.dataArray = [TopBookHXGModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"SameUserBooks"]];
        [xlTopBookOneHeaderView setXLBookOneBookWithSXTableView:tableView HeaderValue:topBookOneBookDModel];
        self.topBookOneBookDModel = topBookOneBookDModel;
        [self reloadData];
        // 需要在书籍介绍获取更新 比较先后的两个数组个数对比更新 需在ocontroller传值
        //TopBookOneBookDModel *model = [kDatabase getBookWithId:self.summaryId];
        //model.Id = self.summaryId;
        //[kDatabase updateBook:model];
        //= result[@"data"][@"Id"];
        //self.summaryId = result[@"data"][@"Id"];
        [MBProgressHUD dismissHUD];
    }];
}

- (void)getAllReadBookZJLB:(NSString *)urlString BookIDString:(NSString *)bookIDString
{
    NSArray *dbChapters = [kDatabase getChaptersWithSummaryId:bookIDString];
    if (!IsEmpty(dbChapters)) {
        self.chapters = dbChapters;
    }
    if (dbChapters.count != 0 ) {
        //[MBProgressHUD showWaitingViewText:@"加载缓存" detailText:nil inView:nil];
        [HUD showMsgWithoutView:@"加载缓存"];
        self.zjlbBookArr = dbChapters;
        [self reloadData];
        [MBProgressHUD dismissHUD];
    }else{
       // [MBProgressHUD showWaitingViewText:@"加载网络" detailText:nil inView:nil];
         [HUD showMsgWithoutView:@"加载网络"];
        [XLAPI getAllClassifyWithUrlString:urlString ListComplete:^(id result, BOOL cache, NSError *error) {
            self.zjlbBookArr = [XLBookReadZJLBModel mj_objectArrayWithKeyValuesArray:[result[@"data"][@"list"] firstObject][@"list"]];
            [kDatabase deleteChaptersWithSummaryId:bookIDString];
            if ([kDatabase insertChapters:self.zjlbBookArr summaryId:bookIDString]) {
                NSLog(@"目录插入成功");
            }
            else {
                NSLog(@"目录插入失败");
            }
            [self reloadData];
            [MBProgressHUD dismissHUD];
        }];
    }
}

- (void)getAllReadBookZJNR:(NSString *)urlString bookIDString:(NSString *)idString success:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure
{
//    if (chapter >= self.chapters.count) {
//        failure(@"请求小说内容越界");
//        return;
//    }
//
//    if (self.chapters.count == 0) {
//        failure(@"目录为空！");
//        return;
//    }
    XLBookReadZJLBModel __block *model = self.chapters[1];
    
    XLBookReadZJNRModel*dbmodel = [kDatabase getBookBodyWithLink:model.id bookId:idString];
    NSLog(@"%@,%@",model.id,idString);
    [MBProgressHUD showWaitingViewText:nil detailText:nil inView:nil];
    [XLAPI getAllClassifyWithUrlString:urlString ListComplete:^(id result, BOOL cache, NSError *error) {
        XLBookReadZJNRModel *xlBookReadZJNRModel = [XLBookReadZJNRModel mj_objectWithKeyValues:result[@"data"]];
        
        if ([kDatabase insertBookBody:xlBookReadZJNRModel bookId:idString]) {
            NSLog(@"存储boyd成功");
        } else {
            NSLog(@"存储boyd失败");
        }
        success(xlBookReadZJNRModel);
        [self reloadData];
        [MBProgressHUD dismissHUD];
    }];
}

@end
