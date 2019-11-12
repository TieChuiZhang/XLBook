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
    return tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    TopBookModelManager.tableView = [self setupTableView];
    //CGFloat  aa = NAV_HEIGHT;
    TopBookModelManager.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-50);
    [self.view addSubview:self.xlTopOneBookNav];
    
    //_bookID    NSTaggedPointerString *    @"375026"    0xefd239881c338ebb
    UIButton *button = [UIButton new];
    button.frame = CGRectMake(10, kScreenHeight-50, kScreenWidth-20, 50);
    [button setTitle:[NSString stringWithFormat:@"立即阅读"] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithHexString:@"#01B0E0"];
    button.layer.cornerRadius = 2;
    [button addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [self.view addSubview:button];
}

- (void)tap
{
    if (TopBookModelManager.zjlbBookArr.count == 0) {
        [HUD showMsgWithoutView:@"请稍后"];
    }else{
        NSDictionary *dic = @{@"bookID":TopBookModelManager.topBookOneBookDModel.Id,@"bookZJLBArr":TopBookModelManager.zjlbBookArr,@"bookName":TopBookModelManager.topBookOneBookDModel.Name};
        [LeeRunTimePush runtimePush:@"XXBookReadingVC" dic:dic nav:self.navigationController];
    }
    
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
        return 2;
    }else{
        return 1;
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
    //if (indexPath.section == 0) {
//        TopBookOneBookMLCell *cell = [TopBookOneBookMLCell xlTopBookOneBookMLCellWithTableView:tableView IndexPathRow:indexPath.row];
//        [cell setXLBookOneBookDMLModelCellValue:TopBookModelManager.topBookOneBookDModel];
//        return cell;
//    }else
        if(indexPath.section == 0){
        if (TopBookModelManager.topBookOneBookDModel.SameUserBooks.count != 0) {
            TopBookOneBookHXJCell *cell = [TopBookOneBookHXJCell xlTopBookOneBookHXJCellWithTableView:tableView IndexPathRow:indexPath.row];
            [cell setXLBookOneBookDHXJModelCellValue:TopBookModelManager.topBookOneBookDModel ArrayWithHXGDataArray:TopBookModelManager.dataArray];
            LeeWeakSelf(self)
            cell.selectCell = ^(NSString *bookID) {
                NSDictionary *dic = @{@"bookID":bookID};
                [LeeRunTimePush runtimePush:@"TopBookOneBookDController" dic:dic nav:weakself.navigationController];
            };
            
            return cell;
        }
        else{
            TopBookOneBookMLCell *cell = [TopBookOneBookMLCell xlTopBookOneBookMLCellWithTableView:tableView IndexPathRow:indexPath.row];
            //[cell setXLBookOneBookDMLModelCellValue:self.topBookModel.topBookOneBookDModel];
            return cell;
        }
        
    }else if(indexPath.section == 1) {
        TopBookOneBookTJCell *cell = [TopBookOneBookTJCell xlTopBookOneBookTJCellWithTableView:tableView IndexPathRow:indexPath.row];
        //[cell setXLBookOneBookDMLModelCellValue:self.topBookModel.topBookOneBookDModel];
        LeeWeakSelf(self)
        [cell setXLBookOneBookDTJModelCellValue:TopBookModelManager.topBookOneBookDModel ArrayWithHXGDataArray:@[]];
        cell.selectItem = ^(NSString *bookID) {
            NSDictionary *dic = @{@"bookID":bookID};
            [LeeRunTimePush runtimePush:@"TopBookOneBookDController" dic:dic nav:weakself.navigationController];
        };
    
        return cell;
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (TopBookModelManager.topBookOneBookDModel.SameUserBooks.count != 0) {
            if (TopBookModelManager.topBookOneBookDModel.SameUserBooks.count == 1) {
                return 145;
            }else{
                return (101+(40/TopBookModelManager.topBookOneBookDModel.SameUserBooks.count))*TopBookModelManager.topBookOneBookDModel.SameUserBooks.count;
            }
        }else{
            return 49;
        }
    }else if(indexPath.section == 1){
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
    
    //https://appios3.zygjzl.com/BookFiles/Html/446/445936/info.html
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [TopBookModelManager getOneBookClassifyWithTableView:TopBookModelManager.tableView WithHeaderxlTopBookOneHeaderView:self.xlTopBookOneHeaderView WithUrlString:[NSString stringWithFormat:@"https://shuapi.jiaston.com/info/%@.html",self.bookID] success:^(id  _Nonnull responseObject) {
    } failure:^(NSError * _Nonnull error) {
        
    }];
    //目录
    [TopBookModelManager getAllReadBookZJLB:[NSString stringWithFormat:@"https://shuapi.jiaston.com/book/%@/",self.bookID] BookIDString:self.bookID];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
@end
