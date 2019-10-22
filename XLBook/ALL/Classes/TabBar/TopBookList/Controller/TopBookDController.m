//
//  TopBookDController.m
//  XLBook
//
//  Created by Lee on 2019/10/21.
//  Copyright © 2019 Lee. All rights reserved.
//

#import "TopBookDController.h"
#import "TopBookModel.h"
#import "TopBookListModel.h"
#import "TopBookDCell.h"
@interface TopBookDController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, copy) NSString *listUrl;
@property (nonatomic, strong) TopBookModel *topBookModel;
@property(nonatomic,assign) CGFloat contentOffsetY;
@end

@implementation TopBookDController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topBookModel.tableView = [self setupTableView];
    CGFloat  aa = NAV_HEIGHT;
    self.topBookModel.tableView.frame = CGRectMake(0, NAV_HEIGHT, kScreenWidth, kScreenHeight - aa);
    [self.topBookModel getAllClassify:[NSString stringWithFormat:@"%@week/5.html",self.listUrl]];
}

- (TopBookModel *)topBookModel
{
    if (!_topBookModel) {
        _topBookModel = [TopBookModel new];
    }
    return _topBookModel;
}

- (UITableView *)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
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
    return self.topBookModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TopBookListModel *topBookListModel = [self.topBookModel.dataArray objectAtIndex:indexPath.row];
    TopBookDCell *cell = [TopBookDCell xlTopBookListCellWithTableView:tableView IndexPathRow:indexPath.row];
    [cell setXLBookListModelCellValue:topBookListModel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TopBookListModel *topBookListModel = [self.topBookModel.dataArray objectAtIndex:indexPath.row];
    NSDictionary *dic = @{@"bookID":topBookListModel.Id};
    [LeeRunTimePush runtimePush:@"TopBookOneBookDController" dic:dic nav:self.navigationController];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
}
@end
