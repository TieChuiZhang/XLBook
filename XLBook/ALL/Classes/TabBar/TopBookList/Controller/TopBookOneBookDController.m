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
#import "TopBookOneBookHXJCell.h"
#import "TopBookOneBookDModel.h"
#import "XLTopOneBookNav.h"
#import "TopBookModel.h"
@interface TopBookOneBookDController ()<UITableViewDelegate,UITableViewDataSource,XLTopOneBookNavDelegate>
@property (nonatomic, copy) NSString *bookID;
@property (nonatomic, strong) XLTopBookOneHeaderView *xlTopBookOneHeaderView;
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

    TopBookModelManager.tableView = [self setupTableView];
    //CGFloat  aa = NAV_HEIGHT;
    TopBookModelManager.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-60);
    [TopBookModelManager getOneBookClassifyWithTableView:TopBookModelManager.tableView WithHeaderxlTopBookOneHeaderView:self.xlTopBookOneHeaderView WithUrlString:[NSString stringWithFormat:@"https://shuapi.jiaston.com/info/%@.html",self.bookID] success:^(id  _Nonnull responseObject) {
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
    [TopBookModelManager getAllReadBookZJLB:[NSString stringWithFormat:@"https://shuapi.jiaston.com/book/%@/",self.bookID] BookIDString:self.bookID];
    [self.view addSubview:self.xlTopOneBookNav];
    
    
    UIButton *button = [UIButton new];
    button.frame = CGRectMake(10, kScreenHeight-50, kScreenWidth-20, 50);
    button.backgroundColor = [UIColor blueColor];
    [button addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)tap
{
    NSDictionary *dic = @{@"bookID":TopBookModelManager.topBookOneBookDModel.Id,@"bookZJLBArr":TopBookModelManager.zjlbBookArr};
    [LeeRunTimePush runtimePush:@"XXBookReadingVC" dic:dic nav:self.navigationController];
}

- (XLTopOneBookNav*)xlTopOneBookNav
{
    if (!_xlTopOneBookNav) {
        _xlTopOneBookNav = [[XLTopOneBookNav alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, NAV_HEIGHT)];
        _xlTopOneBookNav.delegate = self;
    }
    return _xlTopOneBookNav;
}

- (void)dissMissViewControllerCurrentView:(XLTopOneBookNav *)topEView bySender:(NSInteger)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (TopBookModelManager.topBookOneBookDModel.SameUserBooks.count != 0) {
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
        [cell setXLBookOneBookDMLModelCellValue:TopBookModelManager.topBookOneBookDModel];
        return cell;
    }else if(indexPath.section == 1){
        if (TopBookModelManager.topBookOneBookDModel.SameUserBooks.count != 0) {
            TopBookOneBookHXJCell *cell = [TopBookOneBookHXJCell xlTopBookOneBookHXJCellWithTableView:tableView IndexPathRow:indexPath.row];
            [cell setXLBookOneBookDHXJModelCellValue:TopBookModelManager.topBookOneBookDModel ArrayWithHXGDataArray:TopBookModelManager.dataArray];
    
            
            return cell;
        }else{
            TopBookOneBookMLCell *cell = [TopBookOneBookMLCell xlTopBookOneBookMLCellWithTableView:tableView IndexPathRow:indexPath.row];
            //[cell setXLBookOneBookDMLModelCellValue:self.topBookModel.topBookOneBookDModel];
            return cell;
        }
        
    }else if(indexPath.section == 2) {
        TopBookOneBookTJCell *cell = [TopBookOneBookTJCell xlTopBookOneBookTJCellWithTableView:tableView IndexPathRow:indexPath.row];
        //[cell setXLBookOneBookDMLModelCellValue:self.topBookModel.topBookOneBookDModel];
        [cell setXLBookOneBookDTJModelCellValue:TopBookModelManager.topBookOneBookDModel ArrayWithHXGDataArray:@[]];
        return cell;
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (TopBookModelManager.topBookOneBookDModel.SameUserBooks.count != 0) {
            if (TopBookModelManager.topBookOneBookDModel.SameUserBooks.count == 1) {
                return 145;
            }else{
                return (101+(40/TopBookModelManager.topBookOneBookDModel.SameUserBooks.count))*TopBookModelManager.topBookOneBookDModel.SameUserBooks.count;
            }
        }else{
            return 49;
        }
    }else if(indexPath.section == 2){
        return 370;
    }else {
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
