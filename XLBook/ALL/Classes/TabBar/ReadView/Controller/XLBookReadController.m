//
//  XLBookReadController.m
//  XLBook
//
//  Created by Lee on 2019/10/24.
//  Copyright © 2019 Lee. All rights reserved.
//

#import "XLBookReadController.h"
#import "LNReaderContentCell.h"
#import "TopBookModel.h"
#import "XLBookReadZJLBModel.h"
@interface XLBookReadController ()<UITextViewDelegate,UIGestureRecognizerDelegate>
// LNReaderTopControlViewDelegate
// LNReaderBottomControlViewDelegate
/**是否正在显示菜单*/
@property (nonatomic, assign) BOOL menuIsShowing;
/**是否正在显示源菜单*/
@property (nonatomic, assign) BOOL sourceListIsShowing;
/**是否正在显示章节菜单*/
@property (nonatomic, assign) BOOL chapterListIsShowing;
/**是否正在显示设置*/
@property (nonatomic, assign) BOOL settingViewIsShowing;
/**遮罩*/
@property (nonatomic, weak) UIControl *coverView;
@property (nonatomic, weak) UIViewController *dispalyListVc;
@property (nonatomic, assign) BOOL statusBarHide;
@property (nonatomic, strong) TopBookModel *topBookModel;
@property (nonatomic, copy) NSString *bookID;
@end

@implementation XLBookReadController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.menuIsShowing = NO;
    self.settingViewIsShowing = YES;
    
    UIImageView *bgImageView = [[UIImageView alloc] init];
    bgImageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgImageView];
    //self.readerVM.bgImageView = bgImageView;
    bgImageView.frame = self.view.bounds;
    [self.view sendSubviewToBack:bgImageView];

    self.tableView.contentInset = UIEdgeInsetsMake(kIPhoneX_TOP_HEIGHT + 30, 0, 0, 0);
    
    [self setupTopView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self.tableView.mj_header setIgnoredScrollViewContentInsetTop:kIPhoneX_TOP_HEIGHT];
    //[self.readerVM showIndicatorView];
    
    //[self setupControlView];
    
    //[self setupRightContentView];
    
    //[self.readerVM setReaderSkin];
    
    [self getBookData];
}

- (TopBookModel *)topBookModel
{
    if (!_topBookModel) {
        _topBookModel = [TopBookModel new];
    }
    return _topBookModel;
}

- (void)getBookData
{
    [MBProgressHUD showWaitingViewText:nil detailText:nil inView:self.view];
    [self.topBookModel getAllReadBookZJLB:[NSString stringWithFormat:@"https://shuapi.jiaston.com/book/%@/",self.bookID]];
}

- (UIControl *)coverView
{
    if (_coverView) {
        return _coverView;
    }
    UIControl *coverView = [[UIControl alloc] init];
    coverView.backgroundColor = [UIColorHex(@"000000") colorWithAlphaComponent:0.3];
    [coverView addTarget:self action:@selector(dismissRightView) forControlEvents:UIControlEventTouchUpInside];
    coverView.frame = CGRectMake(0, 64 + kIPhoneX_TOP_HEIGHT, self.view.width, self.view.height);
    coverView.alpha = 0;
    [self.view addSubview:coverView];
    _coverView = coverView;
    return _coverView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.statusBarHide = YES;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    //[UIScreen mainScreen].brightness = self.readerVM.currentBright;
    //[UIApplication sharedApplication].idleTimerDisabled = self.readerVM.notLock;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //[UIScreen mainScreen].brightness = self.readerVM.oldBright;
    [UIApplication sharedApplication].idleTimerDisabled = NO;
}

- (BOOL)hasRefreshHeader
{
    return NO;
}

- (void)setupTopView
{
    UIImageView *baseView = [[UIImageView alloc] init];
    baseView.clipsToBounds = YES;
    baseView.frame = CGRectMake(0, 0, kScreenWidth, kIPhoneX_TOP_HEIGHT + 30);
    [self.view addSubview:baseView];
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.font = [UIFont systemFontOfSize:13];
    tipLabel.textColor = UIColorHex(@"333333");
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [baseView addSubview:tipLabel];
    tipLabel.frame = CGRectMake(0, kIPhoneX_TOP_HEIGHT, kScreenWidth, 30);
    
    //self.readerVM.topView = baseView;
    //self.readerVM.topTitleLabel = tipLabel;
}

- (void)setupControlView
{
//    LNReaderBottomControlView *bottomControlView = [LNReaderBottomControlView viewFromNib];
//    bottomControlView.delegate = self;
//    bottomControlView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 49 + kIPhoneX_BOTTOM_HEIGHT);
//    [self.view addSubview:bottomControlView];
//    self.readerVM.bottomControlView = bottomControlView;
//
//    LNReaderSettingView *settingView = [LNReaderSettingView viewFromNib];
//    settingView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 230 + kIPhoneX_BOTTOM_HEIGHT);
//    settingView.skinList = [LNSkinHelper sharedHelper].readerSkinList;
//    settingView.fontSize = self.readerVM.font.pointSize;
//    settingView.delegate = self.readerVM;
//    [settingView setNotLock:self.readerVM.notLock];
//    [settingView setBright:self.readerVM.currentBright];
//    [self.view addSubview:settingView];
//    self.readerVM.settingView = settingView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LNReaderContentCell *cell = [LNReaderContentCell cellForTableView:tableView];
    XLBookReadZJLBModel *bookZJModel = [self.dataArray objectAtIndex:indexPath.row];
    [self.topBookModel getAllReadBookZJNR:[NSString stringWithFormat:@"https://shuapi.jiaston.com/book/%@/%@.html",self.bookID,bookZJModel.id]];
    //LNBookContent *content = [self.dataArray objectAtIndex:indexPath.row];
    //cell.content = content;
    return cell;
}

//如果tableView.estimatedRowHeight = 0,就执行这个方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 1000;
}

//如果没设置tableView.estimatedRowHeight,就执行这个方法
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return [self cellHeightWithIndex:indexPath.row];
//}
//
//- (CGFloat)cellHeightWithIndex:(NSInteger)index
//{
//    LNBookContent *content = [self.dataArray objectAtIndex:index];
//    if (content.cellHeight) {
//        return [content.cellHeight floatValue];
//    }
//    return [LNReaderContentCell heightWithModel:content];
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat xOffset = scrollView.contentOffset.x;
    CGFloat yOffset = scrollView.contentOffset.y + 150 + kIPhoneX_TOP_HEIGHT;
    NSIndexPath *path = [self.tableView indexPathForRowAtPoint:CGPointMake(xOffset, yOffset)];
    if (path.row < self.dataArray.count) {
        //LNBookContent *content = [self.dataArray objectAtIndex:path.row];
        //self.readerVM.topTitleLabel.text = content.title;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.menuIsShowing) {
        [self hideMenu];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.settingViewIsShowing) {
        return;
    }
    self.menuIsShowing?[self hideMenu]:[self showMenu];
}

- (void)showMenu
{
    if (self.menuIsShowing) {
        return;
    }
    self.statusBarHide = NO;
    [self setNeedsStatusBarAppearanceUpdate];
    self.menuIsShowing = YES;
    [UIView animateWithDuration:0.25 animations:^{
        //self.readerVM.topControlView.top = 0;
        //self.readerVM.bottomControlView.bottom = kScreenHeight;
    }];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(hideMenu) withObject:nil afterDelay:3];
}

- (void)hideMenu
{
    if (self.menuIsShowing == NO) {
        return;
    }
    self.menuIsShowing = NO;
    self.statusBarHide = YES;
    [self setNeedsStatusBarAppearanceUpdate];
    [UIView animateWithDuration:0.25 animations:^{
        //self.readerVM.topControlView.top = -self.readerVM.topControlView.height;
        //self.readerVM.bottomControlView.top = kScreenHeight;
    }];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)showRightView
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    self.coverView.alpha = 0;
    //[self.view bringSubviewToFront:self.readerVM.rightContentView];
    [UIView animateWithDuration:0.25 animations:^{
        self.coverView.alpha = 1;
        //self.readerVM.rightContentView.left -= self.readerVM.rightContentView.width;
    }];
}

- (void)dismissRightView
{
    [self dismissRightViewFinished:nil];
    self.sourceListIsShowing = NO;
    self.chapterListIsShowing = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(hideMenu) withObject:nil afterDelay:3];
}

- (void)dismissRightViewFinished:(void(^)(void))finishedBlock
{
    [UIView animateWithDuration:0.25 animations:^{
        self.coverView.alpha = 0;
        //self.readerVM.rightContentView.left = kScreenWidth;
    } completion:^(BOOL finished) {
        //[self.readerVM.rightContentView removeAllSubviews];
        if (self.dataArray.count == 0) {
            [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showMenu)]];
        }
        if (finishedBlock) {
            finishedBlock();
        }
    }];
}

@end
