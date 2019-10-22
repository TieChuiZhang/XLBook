//
//  TopBookOneBookDController.m
//  XLBook
//
//  Created by Lee on 2019/10/22.
//  Copyright © 2019 Lee. All rights reserved.
//

#import "TopBookOneBookDController.h"
#import "XLTopBookOneHeaderView.h"
#import "TopBookOneBookDModel.h"
#import "XLTopOneBookNav.h"
#import "TopBookModel.h"
@interface TopBookOneBookDController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, copy) NSString *bookID;
@property (nonatomic, strong) XLTopBookOneHeaderView *xlTopBookOneHeaderView;
@property (nonatomic, strong) TopBookModel *topBookModel;
@property (nonatomic, strong) XLTopOneBookNav *xlTopOneBookNav;
@property(nonatomic,assign) CGFloat contentOffsetY;
@end

@implementation TopBookOneBookDController

- (UITableView *)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.rowHeight = 60;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.backgroundView = nil;
    tableView.tableHeaderView = self.xlTopBookOneHeaderView;
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellA"];
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
    return tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.xlTopBookOneHeaderView = [XLTopBookOneHeaderView new];
    self.xlTopBookOneHeaderView.frame = CGRectMake(0, 0, kScreenWidth, 480);
    self.xlTopBookOneHeaderView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.xlTopBookOneHeaderView];
    self.topBookModel.tableView = [self setupTableView];
    //CGFloat  aa = NAV_HEIGHT;
    self.topBookModel.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [self.topBookModel getOneBookClassify:[NSString stringWithFormat:@"https://shuapi.jiaston.com/info/%@.html",self.bookID]];
    [self.view addSubview:self.xlTopOneBookNav];
}

- (TopBookModel *)topBookModel
{
    if (!_topBookModel) {
        _topBookModel = [TopBookModel new];
    }
    return _topBookModel;
}

- (XLTopOneBookNav*)xlTopOneBookNav {
    
    if (!_xlTopOneBookNav) {
        _xlTopOneBookNav = [[XLTopOneBookNav alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, NAV_HEIGHT)];
    }
    return _xlTopOneBookNav;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.topBookModel.topBookOneBookDModel.SameCategoryBooks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //TopBookOneBookDModel *topBookListModel = [self.topBookModel.dataArray objectAtIndex:indexPath.row];
    //TopBookDCell *cell = [TopBookDCell xlTopBookListCellWithTableView:tableView IndexPathRow:indexPath.row];
    //[cell setXLBookListModelCellValue:topBookListModel];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellA" forIndexPath:indexPath];
    cell.textLabel.text = self.topBookModel.topBookOneBookDModel.SameCategoryBooks[indexPath.row][@"Name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //TopBookListModel *topBookListModel = [self.topBookModel.dataArray objectAtIndex:indexPath.row];
    //NSDictionary *dic = @{@"bookID":topBookListModel.Id};
    //[LeeRunTimePush runtimePush:@"TopBookOneBookDController" dic:dic nav:self.navigationController];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.contentOffsetY = scrollView.contentOffset.y;
    self.xlTopOneBookNav.navV.alpha = self.contentOffsetY / 150;
    self.xlTopOneBookNav.navLabel.alpha = self.contentOffsetY / 150;
    if (self.contentOffsetY / 150 > 0.6) {
        self.xlTopOneBookNav.isScrollUp = YES;
    } else {
        self.xlTopOneBookNav.isScrollUp = NO;
    }
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self.navigationController setNavigationBarHidden:NO animated:animated];
}


//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    self.xlTopBookOneHeaderView = [XLTopBookOneHeaderView new];
//    self.xlTopBookOneHeaderView.frame = CGRectMake(0, 0, kScreenWidth, 480);
//    self.xlTopBookOneHeaderView.backgroundColor = [UIColor redColor];
//    [self.xlTopBookOneHeaderView setXLBookOneBookHeaderValue:self.topBookModel.topBookOneBookDModel];
//    return self.xlTopBookOneHeaderView;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//
//    return 480;
//}
//

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    [self.xlTopBookOneHeaderView setXLBookOneBookHeaderValue:self.topBookModel.topBookOneBookDModel];
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 0.1;
}



@end
