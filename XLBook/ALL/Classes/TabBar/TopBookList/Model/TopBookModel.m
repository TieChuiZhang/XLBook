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
#import "TopBookZJMLFZModel.h"

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

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)zjlbBookArr
{
    if (!_zjlbBookArr) {
        _zjlbBookArr = [NSMutableArray array];
    }
    return _zjlbBookArr;
}


- (void)clear {
//    self.chapter = 0;
//    self.page = 0;
//    self.chapters = nil;
//    self.title = nil;
    //self.summaryId = nil;
    //self.isSave = NO;
}

- (void)getAllClassify:(NSString *)urlString success:(void (^)(NSInteger ))success
{
    [XLAPI getAllClassifyWithUrlString:urlString ListComplete:^(id result, BOOL cache, NSError *error) {
        if ([result[@"data"] isKindOfClass:[NSArray class]]) {
            self.dataArray = [TopBookListModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
        }else{
            if (self.dataArray.count != 0) {
                NSArray *arr =  [TopBookListModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"BookList"]];
                [self.dataArray addObjectsFromArray:arr];
            }else{
                self.dataArray = [TopBookListModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"BookList"]];
            }
        }
        success(1);
        [self reloadData];
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
        [HUD showMsgWithoutView:@"加载缓存"];
        [self.zjlbBookArr addObjectsFromArray:dbChapters];
        [self reloadData];
        [MBProgressHUD dismissHUD];
    }else{
        [HUD showMsgWithoutView:@"加载网络"];
        [XLAPI getAllClassifyWithUrlString:urlString ListComplete:^(id result, BOOL cache, NSError *error) {
            [self.zjlbBookArr removeAllObjects];
            // 获取所有分组数组
            NSMutableArray *fzListArr = [NSMutableArray array];
            fzListArr = [TopBookZJMLFZModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"list"]];
            // 循环去掉分组
            [fzListArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                TopBookZJMLFZModel *topBookZJMLFZModel = obj;
                NSArray *removeFZArr = [XLBookReadZJLBModel mj_objectArrayWithKeyValuesArray:topBookZJMLFZModel.list];
                [removeFZArr enumerateObjectsUsingBlock:^(id  _Nonnull ZJMLFZ, NSUInteger idx, BOOL * _Nonnull stop) {
                    XLBookReadZJLBModel *xlBookReadZJLBModel = ZJMLFZ;
                    [self.zjlbBookArr addObject:xlBookReadZJLBModel];
                }];
            }];
            // 存储目录
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

- (void)getAllReadBookZJNR:(NSString *)urlString bookIDString:(NSString *)idString  success:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure
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
//    XLBookReadZJLBModel __block *model = self.chapters[1];
//    
//    XLBookReadZJNRModel*dbmodel = [kDatabase getBookBodyWithLink:model.id bookId:idString];
//    if (dbmodel) {
//        success(dbmodel);
//    }else{
//       
//    }
    NSLog(@"%@",urlString);
    [MBProgressHUD showWaitingViewText:nil detailText:nil inView:nil];
           [XLAPI getAllClassifyWithUrlString:urlString ListComplete:^(id result, BOOL cache, NSError *error) {
               XLBookReadZJNRModel *xlBookReadZJNRModel = [XLBookReadZJNRModel mj_objectWithKeyValues:result[@"data"]];
//               if ([kDatabase insertBookBody:xlBookReadZJNRModel bookId:idString]) {
//                   NSLog(@"存储boyd成功");
//               } else {
//                   NSLog(@"存储boyd失败");
//               }
               success(xlBookReadZJNRModel);
               [self reloadData];
               [MBProgressHUD dismissHUD];
           }];
    
}

- (void)pagingWithBounds:(CGRect)bounds withFont:(UIFont *)font andChapter:(XLBookReadZJNRModel *)xlBookReadZJNRModel {
    
    xlBookReadZJNRModel.pageDatas = @[].mutableCopy;
    
    if (!xlBookReadZJNRModel.content) {
        xlBookReadZJNRModel.content = @"";
    }
    
    NSString *body = [self adjustParagraphFormat:xlBookReadZJNRModel.content];
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:body];
    attr.font = font;
    attr.color = kblackColor;
    
    // 设置label的行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:AdaWidth(9)];
    [attr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, body.length)];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef) attr);
    
    CGPathRef path = CGPathCreateWithRect(bounds, NULL);
    
    CFRange range = CFRangeMake(0, 0);
    
    NSUInteger rangeOffset = 0;
    
    do {
        CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(rangeOffset, 0), path, NULL);
        
        range = CTFrameGetVisibleStringRange(frame);
        
        rangeOffset += range.length;
        
        //range.location
        [xlBookReadZJNRModel.pageDatas addObject:@(range.location)];
        
        if (frame) {
            CFRelease(frame);
        }
    } while (range.location + range.length < attr.length);
    
    if (path) {
        CFRelease(path);
    }
    
    if (frameSetter) {
        CFRelease(frameSetter);
    }
    
    //xlBookReadZJNRModel.pageCount = xlBookReadZJNRModel.pageDatas.count;
    
    //xlBookReadZJNRModel.attributedString = attr;
    
    self.pagePrevious = xlBookReadZJNRModel.pageDatas.count -1;
}

// 换行\t制表符，缩进
- (NSString *)adjustParagraphFormat:(NSString *)string {
    if (!string) {
        return nil;
    }
    string = [string stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@"\n　　"];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    return string;
}

@end
