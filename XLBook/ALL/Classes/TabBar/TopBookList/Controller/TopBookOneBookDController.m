//
//  TopBookOneBookDController.m
//  XLBook
//
//  Created by Lee on 2019/10/22.
//  Copyright © 2019 Lee. All rights reserved.
//

#import "TopBookOneBookDController.h"
#import "XLTopBookOneHeaderView.h"
#import "TopBookOneBookMLCell.h"
#import "TopBookOneBookTJCell.h"
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
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedRowHeight = 70;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.backgroundView = nil;
    //tableView.tableFooterView = [[UIView alloc]init];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:tableView];
    self.xlTopBookOneHeaderView = [XLTopBookOneHeaderView new];
    self.xlTopBookOneHeaderView.frame = CGRectMake(0, 0, kScreenWidth, 10);
    
    [self.xlTopBookOneHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view.frame.size.width);
    }];
    
    tableView.tableHeaderView = self.xlTopBookOneHeaderView;
    
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        //tableView.estimatedRowHeight = 0;
        
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

    self.topBookModel.tableView = [self setupTableView];
    //CGFloat  aa = NAV_HEIGHT;
    self.topBookModel.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-10);
    [self.topBookModel getOneBookClassifyWithTableView:self.topBookModel.tableView WithHeaderxlTopBookOneHeaderView:self.xlTopBookOneHeaderView WithUrlString:[NSString stringWithFormat:@"https://shuapi.jiaston.com/info/%@.html",self.bookID]];
    [self.view addSubview:self.xlTopOneBookNav];
}

- (TopBookModel *)topBookModel
{
    if (!_topBookModel) {
        _topBookModel = [TopBookModel new];
    }
    return _topBookModel;
}

- (XLTopOneBookNav*)xlTopOneBookNav
{
    if (!_xlTopOneBookNav) {
        _xlTopOneBookNav = [[XLTopOneBookNav alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, NAV_HEIGHT)];
    }
    return _xlTopOneBookNav;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.topBookModel.topBookOneBookDModel.SameUserBooks.count != 0) {
        return 3;
    }else{
        return 2;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //TopBookOneBookDModel *topBookListModel = [self.topBookModel.dataArray objectAtIndex:indexPath.row];
    //TopBookDCell *cell = [TopBookDCell xlTopBookListCellWithTableView:tableView IndexPathRow:indexPath.row];
    //[cell setXLBookListModelCellValue:topBookListModel];
    if (indexPath.section == 0) {
        TopBookOneBookMLCell *cell = [TopBookOneBookMLCell xlTopBookOneBookMLCellWithTableView:tableView IndexPathRow:indexPath.row];
        [cell setXLBookOneBookDMLModelCellValue:self.topBookModel.topBookOneBookDModel];
        return cell;
    }else if(indexPath.section == 1){
        if (self.topBookModel.topBookOneBookDModel.SameUserBooks.count != 0) {
            TopBookOneBookTJCell *cell = [TopBookOneBookTJCell xlTopBookOneBookTJCellWithTableView:tableView IndexPathRow:indexPath.row];
            [cell setXLBookOneBookDTJModelCellValue:self.topBookModel.topBookOneBookDModel ArrayWithHXGDataArray:self.topBookModel.dataArray];
            
            return cell;
        }else{
            TopBookOneBookMLCell *cell = [TopBookOneBookMLCell xlTopBookOneBookMLCellWithTableView:tableView IndexPathRow:indexPath.row];
            //[cell setXLBookOneBookDMLModelCellValue:self.topBookModel.topBookOneBookDModel];
            return cell;
        }
        
    }else if(indexPath.section == 2) {
        TopBookOneBookMLCell *cell = [TopBookOneBookMLCell xlTopBookOneBookMLCellWithTableView:tableView IndexPathRow:indexPath.row];
        //[cell setXLBookOneBookDMLModelCellValue:self.topBookModel.topBookOneBookDModel];
        return cell;
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%lu",(105+(40/self.topBookModel.topBookOneBookDModel.SameUserBooks.count))*self.topBookModel.topBookOneBookDModel.SameUserBooks.count);
    if (indexPath.section == 1) {
        if (self.topBookModel.topBookOneBookDModel.SameUserBooks.count != 0) {
            if (self.topBookModel.topBookOneBookDModel.SameUserBooks.count == 1) {
                return 145;
            }else{
                return (101+(40/self.topBookModel.topBookOneBookDModel.SameUserBooks.count))*self.topBookModel.topBookOneBookDModel.SameUserBooks.count;
            }
        }else{
            return 49;
        }
    }else{
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //TopBookLiModel *topBookListModel = [self.topBookModel.dataArray objectAtIndex:indexPath.row];
    //NSDictionary *dic = @{@"bookID":topBookListModel.Id};
    //[LeeRunTimePush runtimePush:@"TopBookOneBookDController" dic:dic nav:self.navigationController];
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
@end
