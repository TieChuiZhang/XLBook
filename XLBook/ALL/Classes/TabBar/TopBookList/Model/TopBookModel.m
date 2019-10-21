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
@implementation TopBookModel
- (void)getAllClassify:(NSString *)urlString
{
    [MBProgressHUD showWaitingViewText:nil detailText:nil inView:nil];
    NSLog(@"%@",urlString);
    [XLAPI getAllClassifyWithUrlString:urlString ListComplete:^(id result, BOOL cache, NSError *error) {
        //TopBookListModel *topBookListModel = [TopBookListModel mj_objectWithKeyValues:result[@"data"][@"BookList"]];
        self.dataArray = [TopBookListModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"BookList"]];
        //https://imgapi.jiaston.com/BookFiles/BookImages/limingzhijian.jpg
        [self reloadData];
        [MBProgressHUD dismissHUD];
    }];
}

- (void)reloadData
{
    [self.tableView reloadData];
}
@end
