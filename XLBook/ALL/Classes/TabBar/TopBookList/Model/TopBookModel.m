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
#import "XLTopBookOneHeaderView.h"
@implementation TopBookModel
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

- (void)getOneBookClassify:(NSString *)urlString
{
    [XLAPI getAllClassifyWithUrlString:urlString ListComplete:^(id result, BOOL cache, NSError *error) {
        TopBookOneBookDModel *topBookOneBookDModel = [TopBookOneBookDModel mj_objectWithKeyValues:result[@"data"]];
        self.topBookOneBookDModel = topBookOneBookDModel;
        [self reloadData];
        [MBProgressHUD dismissHUD];
    }];
    
}
@end
