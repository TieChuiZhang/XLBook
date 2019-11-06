//
//  MyBookController.m
//  XLBook
//
//  Created by Lee on 2019/10/21.
//  Copyright © 2019 Lee. All rights reserved.
//

#import "MyBookController.h"
#import "TopBookOneBookDModel.h"
#import "MyBookCell.h"
@interface MyBookController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *cacheArray;
@end

@implementation MyBookController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cacheArray  = [TopBookOneBookDModel mj_objectArrayWithKeyValuesArray:[kDatabase getBooks]];
    self.title = @"书架";
    self.tableView = [self setupTableView];
    [self dropRefresh];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[self.tableView.mj_header beginRefreshing];
}

- (void)dropRefresh
{
    LeeWeakSelf(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
         self.cacheArray = nil;
         self.cacheArray  = [TopBookOneBookDModel mj_objectArrayWithKeyValuesArray:[kDatabase getBooks]];
        [weakself.tableView reloadData];
        [weakself.tableView.mj_header endRefreshing];
    }];
}

- (UITableView *)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    tableView.rowHeight = 60;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.backgroundView = nil;
    tableView.tableFooterView = [[UIView alloc] init];
    //tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    //tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:tableView];
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
    }
    else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    CGFloat bottomInset = 0;
    if (self.navigationController.childViewControllers.firstObject == self && self.navigationController.tabBarController) {
        bottomInset = CGRectGetHeight(self.navigationController.tabBarController.tabBar.frame);
    }
    //tableView.contentInset = UIEdgeInsetsMake(kNaviHeight + 10, 0, bottomInset, 0);
    return tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cacheArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TopBookOneBookDModel *topBookListModel = [self.cacheArray objectAtIndex:indexPath.row];
    MyBookCell *cell = [MyBookCell xlBookMyBookCellWithTableView:tableView IndexPathRow:indexPath.row];
    [cell setXLBookMyBookModelWithCellValue:topBookListModel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TopBookOneBookDModel *topBookListModel = [self.cacheArray objectAtIndex:indexPath.row];
    NSArray *mlArr = [kDatabase getChaptersWithSummaryId:topBookListModel.Id];
    NSDictionary *dic = @{@"bookID":topBookListModel.Id,@"bookZJLBArr":mlArr,@"bookName":topBookListModel.Name};
    [LeeRunTimePush runtimePush:@"XXBookReadingVC" dic:dic nav:self.navigationController];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
}
@end
