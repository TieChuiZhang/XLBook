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

@interface MyBookController ()<UITableViewDelegate,UITableViewDataSource,PYSearchViewControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *cacheArray;
@end

@implementation MyBookController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"搜索"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(search)];
    self.cacheArray  = [TopBookOneBookDModel mj_objectArrayWithKeyValuesArray:[kDatabase getBooks]];
    self.title = @"最近阅读";
    self.tableView = [self setupTableView];
    [self dropRefresh];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}

- (void)dropRefresh
{
    LeeWeakSelf(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself.cacheArray removeAllObjects];
        weakself.cacheArray  = [TopBookOneBookDModel mj_objectArrayWithKeyValuesArray:[kDatabase getBooks]];
        [weakself.tableView reloadData];
        [weakself.tableView.mj_header endRefreshing];
    }];
}

- (UITableView *)setupTableView
{
    CGFloat navH = NAV_HEIGHT;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, navH, kScreenWidth, kScreenHeight - navH-44) style:UITableViewStylePlain];
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
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wdeprecated-declarations"
        //这里是弃用的属性
        self.automaticallyAdjustsScrollViewInsets = NO;
        #pragma clang diagnostic pop
        
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

- ( UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    //删除
    TopBookOneBookDModel *topBookListModel = [self.cacheArray objectAtIndex:indexPath.row];
    UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"删除" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        [self.cacheArray removeObjectAtIndex:indexPath.row];
        [kDatabase deleteBookWithId:topBookListModel.Id];
        completionHandler (YES);
        [self.tableView reloadData];
    }];
    //deleteRowAction.image = [UIImage imageNamed:@"删除"];
    deleteRowAction.backgroundColor = [UIColor colorWithHexString:@"FF4F46"];
    
    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction]];
    return config;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
}

- (void)search
{
    // 1. Create an Array of popular search
    NSArray *hotSeaches = @[@"剑来", @"牧神记", @"大王饶命", @"异常生物见闻录", @"庆余年"];
    // 2. Create a search view controller
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:NSLocalizedString(@"输入书名作者搜索书籍", @"") didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // Called when search begain.
        // eg：Push to a temp view controller
        NSString *searchUrl = [NSString stringWithFormat:@"https://sou.jiaston.com/search.aspx?key=%@&page=1&siteid=app2",[searchText stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
        NSDictionary *dic = @{@"searchUrl":searchUrl,@"TopVC":@"1"};
        [LeeRunTimePush runtimePush:@"TopBookDController" dic:dic nav:self.navigationController];
    }];
    searchViewController.delegate = self;
    searchViewController.hotSearchStyle = PYHotSearchStyleColorfulTag;
    searchViewController.searchHistoryStyle = PYHotSearchStyleDefault;
    searchViewController.searchViewControllerShowMode = PYSearchViewControllerShowModePush;
    //    // Push search view controller
    [self.navigationController pushViewController:searchViewController animated:YES];
}

#pragma mark - PYSearchViewControllerDelegate
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    if (searchText.length) {
        // Simulate a send request to get a search suggestions
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
            for (int i = 0; i < arc4random_uniform(5) + 10; i++) {
                NSString *searchSuggestion = [NSString stringWithFormat:@"Search suggestion %d", i];
                [searchSuggestionsM addObject:searchSuggestion];
            }
            // Refresh and display the search suggustions
            searchViewController.searchSuggestions = searchSuggestionsM;
        });
    }
}




@end
