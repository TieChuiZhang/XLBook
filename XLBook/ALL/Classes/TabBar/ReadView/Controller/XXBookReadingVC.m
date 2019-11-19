//
//  XXBaseBookReadingVC.m
//  Novel
//
//  Created by app on 2018/1/20.
//  Copyright © 2018年 th. All rights reserved.
//

#define SpaceWith kScreenWidth / 3
#define SpaceHeight kScreenHeight / 3
#define kShowMenuDuration 0.3f
//#import "XXSummaryVC.h"
//#import "XXDatabase.h"
#import "XXBookMenuView.h"
#import "XXReadSettingVC.h"
#import "XXBookReadingVC.h"
#import "XXBookContentVC.h"
#import "XXDirectoryVC.h"
//#import "XXBookModel.h"
#import "XLBookReadZJLBModel.h"
#import "TopBookZJMLFZModel.h"
#import "XXBookReadingBackViewController.h"
@interface XXBookReadingVC () <UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPageViewController *pageViewController;

@property (nonatomic, strong) XXBookMenuView *menuView;

/** 判断是否是下一章，否即上一章 */
@property (nonatomic, assign) BOOL ispreChapter;

/** 是否显示状态栏 */
@property (nonatomic, assign) BOOL hiddenStatusBar;

/** 是否更换源 */
@property (nonatomic, assign) BOOL isReplaceSummary;

/* 点击手势 */
@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic, assign) BOOL isTaping;

@property (nonatomic, strong) XXBookContentVC *currentReadPage;

@property (nonatomic, strong) NSArray *bookZJLBArr;
@property (nonatomic, copy) NSString *bookID;
@property (nonatomic, strong) TopBookModel *topBookModel;
@property (nonatomic, strong) XLBookReadZJNRModel *xlBookReadZJNRModel;
@property (nonatomic, assign) NSInteger pageCurrent;
@property (nonatomic, assign) NSInteger pageZJ;
/* 前一个*/
@property (nonatomic, assign) NSInteger pagePrevious;
@property (nonatomic, strong) NSMutableArray *mlArr;

@property (nonatomic, copy) NSString *bookName;

@end

@implementation XXBookReadingVC


- (instancetype)initWithBookId:(NSString *)bookId bookTitle:(NSString *)bookTitle summaryId:(NSString *)summaryId {
    if (self = [super init]) {
        //        [kReadingManager clear];
        //        kReadingManager.bookId = bookId;
        //        kReadingManager.title = bookTitle;
        //        kReadingManager.summaryId = summaryId;
        //        kReadingManager.isSave = YES;
        
        //XBookModel *book = [kDatabase getBookWithId:bookId];
        //        if (book) {
        //            //查询是否已经加入书架
        //            kReadingManager.chapter = book.chapter;
        //            kReadingManager.page = book.page;
        //        }
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onApplicationWillResignActive) name:UIApplicationWillResignActiveNotification object:nil];
    }
    return self;
}


//进入后台 保存下进度
- (void)onApplicationWillResignActive {
    //if (_pageViewController && kReadingManager.isSave == YES) {
    //ReadingManager *manager = [ReadingManager shareReadingManager];
    //XXBookModel *model = [kDatabase getBookWithId:manager.bookId];
    //        if (manager.transitionStyle == kTransitionStyle_Scroll) {
    //            //左右滑动
    //            XXBookContentVC *firstVc = [self.pageViewController.viewControllers firstObject];
    //            model.page = firstVc.page;
    //            model.chapter = firstVc.chapter;
    //        }
    //        else {
    //            model.page = manager.page;
    //            model.chapter = manager.chapter;
    //        }
    //
    //        model.updateStatus = NO;
    //[kDatabase updateBook:model];
    // }
}


#pragma mark - 状态栏
- (BOOL)prefersStatusBarHidden {
    return _hiddenStatusBar;
}


- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    TopBookOneBookDModel *model = [kDatabase getBookWithId:self.bookID];
     if (model) {
         self.pageCurrent = model.page;
         self.pageZJ = model.chapter;
     }else{
         self.pageCurrent = 0;
         self.pageZJ = 0;
     }
    self.hiddenStatusBar = YES;
    self.fd_prefersNavigationBarHidden = YES;
    self.fd_interactivePopDisabled = NO;
    [self requestDataWithShowLoading:YES];
    
      _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchTap:)];
      _tap.numberOfTapsRequired = 1;
      //_tap.cancelsTouchesInView = NO;
      [self.view addGestureRecognizer:self.tap];
      _tap.delegate = self;
    
    
}


- (void)setupViews {
    [self pageViewController];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if ([touch.view isDescendantOfView:self.menuView]) {
        return NO;
    }
    return YES;
}

- (TopBookModel *)topBookModel
{
    if (!_topBookModel) {
        _topBookModel = [TopBookModel new];
    }
    return _topBookModel;
}

- (XLBookReadZJNRModel *)xlBookReadZJNRModel
{
    if (!_xlBookReadZJNRModel) {
        _xlBookReadZJNRModel = [XLBookReadZJNRModel new];
    }
    return _xlBookReadZJNRModel;
}

- (NSMutableArray *)mlArr
{
    if (!_mlArr) {
        _mlArr = [NSMutableArray new];
    }
    return _mlArr;
}

- (NSString *)xlZJNRSFBookWithBookID:(NSString *)bookID
{
    NSString *urlHeaderStr;
    if ([self.bookID length] ==6) {
        NSInteger str3 = [[self.bookID substringToIndex:3] integerValue];
        str3 ++;
        urlHeaderStr = [NSString stringWithFormat: @"%ld", str3];
        NSLog(@"6");
    }else if ([self.bookID length] ==5){
        NSInteger str3 = [[self.bookID substringToIndex:2] integerValue];
        str3 ++;
        urlHeaderStr = [NSString stringWithFormat: @"%ld", str3];
        NSLog(@"5");
    }else if ([self.bookID length] ==4){
        NSInteger str3 = [[self.bookID substringToIndex:1] integerValue];
        str3 ++;
        urlHeaderStr = [NSString stringWithFormat: @"%ld", str3];
        NSLog(@"4");
    }else if ([self.bookID length] ==3){
        urlHeaderStr = @"1";
        NSLog(@"3");
    }else if ([self.bookID length] ==2){
        urlHeaderStr = @"1";
        NSLog(@"2");
    }
    return urlHeaderStr;
}

#pragma mark - 开始进来处理下网络或者缓存
- (void)requestDataWithShowLoading:(BOOL)show {
    LeeWeakSelf(self);
    [self.bookZJLBArr enumerateObjectsUsingBlock:^(id  _Nonnull ZJMLFZ, NSUInteger idx, BOOL * _Nonnull stop) {
        XLBookReadZJLBModel *xlBookReadZJLBModel = ZJMLFZ;
        [weakself.mlArr addObject:xlBookReadZJLBModel.id];
    }];
   //https://appios3.zygjzl.com//BookFiles/Html/1/707/5081120.html
   //https://appios3.zygjzl.com//BookFiles/Html/1/707/5018251.html
//    两位数是1
//    三位数也是1
//    四位数 第一个数加一
//    五位数  取前两位 加一
//    六位数 取出前三位加一
    NSString *urlHeaderStr = [self xlZJNRSFBookWithBookID:self.bookID];
    
    [TopBookModelManager getAllReadBookZJNR:[[NSString stringWithFormat:@"https://appios3.zygjzl.com//BookFiles/Html/%@/%@/%@.html",urlHeaderStr,self.bookID,self.mlArr[self.pageZJ]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]] ChapterID:self.mlArr[self.pageZJ] bookIDString:self.bookID success:^(id  _Nonnull responseObject) {
        weakself.xlBookReadZJNRModel = responseObject;
               weakself.xlBookReadZJNRModel = responseObject;
               [weakself.pageViewController setViewControllers:@[[weakself getpageBookContent]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    } failure:^(NSError * _Nonnull error) {
        
    }];
    

    
    
    //[self.topBookModel getAllReadBookZJNR:self.bookZJLBArr[1][@"id"]];
    
    //    if (show) {
    //        [HUD showProgress:nil inView:self.view];
    //    }
    //MJWeakSelf;
    //[self requestSummaryWithComplete:^{
    
    
    
    
    //[self requestChaptersWithComplete:^{
    
    //            [weakSelf requestContentWithComplete:^{
    //                [HUD hide];
    //                //初始化显示控制器
    //                [self.pageViewController setViewControllers:@[[self getpageBookContent]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    //            }];
    
    
    
    //}];
    // }];
}


#pragma mark - 请求源头列表
//- (void)requestSummaryWithComplete:(void(^)())complete {
//
//    MJWeakSelf;
//
//    if (kReadingManager.summaryId.length > 0) {
//
//        complete();
//
//    } else {
//        //如果没有加入书架的就会没有源id 需要请求一遍拿到源id,然后请求目录数组->再请求第一章
//        [kReadingManager requestSummaryCompletion:^{
//
//            //请求完成
//            if (kReadingManager.summaryId.length == 0) {
//                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"⚠️" message:@"当前书籍没有源更新!" preferredStyle:UIAlertControllerStyleAlert];
//
//                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//                    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
//
//                    [weakSelf dismissViewControllerAnimated:YES completion:nil];
//
//                }]];
//
//                [weakSelf presentViewController:alert animated:YES completion:^{
//                    [HUD hide];
//                }];
//            } else {
//                //有源id
//                complete();
//            }
//
//        } failure:^(NSString *error) {
//            [HUD hide];
//            [HUD showError:error inview:weakSelf.view];
//        }];
//    }
//
//}


#pragma mark - 请求小数目录数组
//- (void)requestChaptersWithComplete:(void(^)())complete {
//
//    MJWeakSelf
//    [kReadingManager requestChaptersWithUseCache:!self.isReplaceSummary completion:^{
//        if (weakSelf.isReplaceSummary) {
//            //已经更换了源ID 弹出目录让用户选择
//            if (kReadingManager.chapter > kReadingManager.chapters.count - 1) {
//                //如果上次读的章节数大于当前源的总章节数
//                kReadingManager.chapter = kReadingManager.chapters.count - 1;
//            }
//            weakSelf.isReplaceSummary = NO;
//            //保存下进度
////            XXBookModel *model = [kDatabase getBookWithId:kReadingManager.bookId];
////            model.chapter = kReadingManager.chapter;
////            model.page = kReadingManager.page;
////            model.summaryId = kReadingManager.summaryId;
////            [kDatabase updateBook:model];
//
//            dispatch_async_on_main_queue(^{
//                [weakSelf showDirectoryVCWithIsReplaceSummary:YES];
//            });
//        } else {
//            complete();
//        }
//    } failure:^(NSString *error) {
//        [HUD hide];
//        [HUD showError:error inview:weakSelf.view];
//    }];
//}


#pragma mark - 请求小说内容
//- (void)requestContentWithComplete:(void(^)())complete {

//    MJWeakSelf;
//    [kReadingManager requestContentWithChapter:kReadingManager.chapter ispreChapter:weakSelf.ispreChapter Completion:^{
//        complete();
//    } failure:^(NSString *error) {
//        [HUD hide];
//    }];
//}


#pragma mark - UIPageViewControllerDelegate
/*
 self.pageViewController setViewControllers:<#(nullable NSArray<UIViewController *> *)#> direction:<#(UIPageViewControllerNavigationDirection)#> animated:<#(BOOL)#> completion:<#^(BOOL finished)completion#>
 animated:NO 是不走这个方法的
 */
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (!completed) {
        XXBookContentVC *readerPageVC = (XXBookContentVC *)previousViewControllers.firstObject;
        self.pageCurrent = readerPageVC.page;
        //self.pageZJ = readerPageVC.chapter;
    } else {
        XXBookContentVC *readPageVC = (XXBookContentVC *)pageViewController.viewControllers.firstObject;
        self.pageCurrent = readPageVC.page;
        //self.pageZJ = readPageVC.chapter;
    }
    _isTaping = NO;
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers
{
    XXBookContentVC *readPageVC = (XXBookContentVC *)pageViewController.viewControllers.firstObject;
    XXBookContentVC *lastObjectPageVC = (XXBookContentVC *)pageViewController.viewControllers.lastObject;
//    NSLog(@"lastObjectPageVCpage:%lu",(unsigned long)lastObjectPageVC.page);
//    NSLog(@"页面page:%lu",(unsigned long)readPageVC.page);
//    NSLog(@"controllerpage:%ld",(long)self.pageCurrent);
}


#pragma mark - UIPageViewControllerDataSource

//上一页
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    if (_isTaping) {
        return nil;
    }

    if (self.pageZJ == 0 && self.pageCurrent == 0) {
        [HUD showMsgWithoutView:@"已经是第一页了!"];
        return nil;
    }

//    if ([viewController isKindOfClass:XXBookContentVC.class]) {
//        XXBookContentVC *vc = [[XXBookContentVC alloc] init];
//        [vc updateWithViewController:viewController];
//        return vc;
//    }

    if (self.pageCurrent > 0){
        self.pageCurrent --;
        return [self getpageBookContent];
    }else{
        self.pageZJ --;
        _ispreChapter = YES;
        return [self getChapterBookContent];
    }
    return nil;
}

//下一页
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    if (_isTaping) {
        return nil;
    }
    if (self.pageZJ >= self.mlArr.count - 1 && self.pageCurrent >= self.xlBookReadZJNRModel.pageCount-1) {
        //self.pageCurrent = 0;
        //self.ispreChapter = NO;
        [HUD showMsgWithoutView:@"没有了老弟"];
        return nil;
    }
    if (self.pageCurrent == self.xlBookReadZJNRModel.pageCount-1) {
        self.pageCurrent = 0;
        self.pageZJ ++;
        self.ispreChapter = NO;
        return [self getChapterBookContent];
    }else{
        self.pageCurrent ++;
        return [self getpageBookContent];
    }
    
}

- (XXBookContentVC *)getChapterBookContent {
    LeeWeakSelf(self);
    XXBookContentVC *contentVC = [[XXBookContentVC alloc] init];
    [TopBookModelManager getAllReadBookZJNR:[NSString stringWithFormat:@"https://shuapi.jiaston.com/book/%@/%@.html",self.bookID,self.mlArr[self.pageZJ]] ChapterID:self.mlArr[self.pageZJ] bookIDString:self.bookID success:^(id  _Nonnull responseObject) {
        weakself.xlBookReadZJNRModel = responseObject;
        contentVC.xlBookReadZJNRModel = self.xlBookReadZJNRModel;
        //contentVC.chapter = kReadingManager.chapter;
        if (weakself.ispreChapter) {
            [TopBookModelManager pagingWithBounds:kReadingFrame withFont:fontSize(TopBookModelManager.font) andChapter:weakself.xlBookReadZJNRModel];
            contentVC.page = TopBookModelManager.pagePrevious;
            weakself.pageCurrent = TopBookModelManager.pagePrevious;
        }else{
            contentVC.page = weakself.pageCurrent;
        }
        weakself.isTaping = NO;
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
    return contentVC;
}


- (XXBookContentVC *)getpageBookContent {
    XXBookContentVC __block *contentVC = [[XXBookContentVC alloc] init];
    contentVC.xlBookReadZJNRModel = self.xlBookReadZJNRModel;
    contentVC.page = self.pageCurrent;
    return contentVC;
}


- (void)touchTap:(UITapGestureRecognizer *)tap {
    CGPoint touchPoint = [tap locationInView:self.pageViewController.view];
    
    if ((touchPoint.x < SpaceWith * 2 && touchPoint.y < SpaceHeight) || (touchPoint.x < SpaceWith && touchPoint.y > SpaceHeight)) {
        // 左边
        //if (kReadingManager.isFullTapNext) {
        
        //[self tapNextPage];
        //}
        //else {
        [self tapPrePage];
        //}
    }
    else if ((touchPoint.x > SpaceWith * 2 && touchPoint.y < SpaceHeight * 2) || (touchPoint.x > SpaceWith && touchPoint.y > SpaceHeight * 2)) {
        //右边
        [self tapNextPage];
    }
    else {
        //中间
        [self showMenu];
    }
}


//点击下一页
- (void)tapNextPage {
    if (self.pageZJ >= self.mlArr.count - 1 && self.pageCurrent >= self.xlBookReadZJNRModel.pageCount-1) {

        [HUD showMsgWithoutView:@"没有了老弟"];
        return;
    }
    if (self.pageCurrent >= self.xlBookReadZJNRModel.pageCount-1) {
        self.isTaping = YES;
        self.pageCurrent = 0;
        self.pageZJ ++;
        self.ispreChapter = NO;
        [self requestDataAndSetViewController];
    }else{
        if (TopBookModelManager.transitionStyle == kTransitionStyle_default) {
            self.pageCurrent ++;
            XXBookContentVC *textVC = [self getpageBookContent];
            [self.pageViewController setViewControllers:@[textVC] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        }
        else if (TopBookModelManager.transitionStyle == kTransitionStyle_PageCurl) {
            self.pageCurrent ++;
            XXBookContentVC *textVC = [self getpageBookContent];
            XXBookReadingBackViewController *backView = [[XXBookReadingBackViewController alloc] init];
            [backView updateWithViewController:textVC];
            [self.pageViewController setViewControllers:@[textVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        }
        else {
            _isTaping = YES;
            LeeWeakSelf(self);
            XXBookContentVC *firstVc = [self.pageViewController.viewControllers firstObject];
            self.pageCurrent = firstVc.page + 1;
            self.view.userInteractionEnabled = NO;
            self.pageViewController.view.userInteractionEnabled = NO;
            XXBookContentVC *textVC = [self getpageBookContent];
            [self.pageViewController setViewControllers:@[textVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
                if (finished) {
                    weakself.isTaping = NO;
                    weakself.pageViewController.view.userInteractionEnabled = YES;
                    weakself.view.userInteractionEnabled = YES;
                }
            }];
        }
    }
}

//点击上一页
- (void)tapPrePage {
    NSLog(@"当前第%ld章",(long)self.pageZJ);
    self.isTaping = YES;
    if (self.pageZJ == 0 && self.pageCurrent == 0) {
        [HUD showMsgWithoutView:@"已经是第一页了!"];
        return;
    }
    if (self.pageCurrent > 0){
        if (TopBookModelManager.transitionStyle == kTransitionStyle_default) {
            self.pageCurrent --;
            XXBookContentVC *textVC = [self getpageBookContent];
            [self.pageViewController setViewControllers:@[textVC] direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
        }
        else if (TopBookModelManager.transitionStyle == kTransitionStyle_PageCurl) {
            self.pageCurrent --;
            XXBookContentVC *textVC = [self getpageBookContent];
            XXBookReadingBackViewController *backView = [[XXBookReadingBackViewController alloc] init];
            [backView updateWithViewController:textVC];
            [self.pageViewController setViewControllers:@[textVC, backView] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
        }else {
           LeeWeakSelf(self);
           XXBookContentVC *firstVc = [self.pageViewController.viewControllers firstObject];
           self.pageCurrent = firstVc.page - 1;
           _isTaping = YES;
           self.view.userInteractionEnabled = NO;
           self.pageViewController.view.userInteractionEnabled = NO;
           XXBookContentVC *textVC = [self getpageBookContent];
           [self.pageViewController setViewControllers:@[textVC] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:^(BOOL finished) {
               if (finished) {
                   weakself.isTaping = NO;
                   weakself.pageViewController.view.userInteractionEnabled = YES;
                   weakself.view.userInteractionEnabled = YES;
               }
           }];
        }        
    }else{
        self.pageZJ --;
        self.isTaping = YES;
        _ispreChapter = YES;
        [self requestDataAndSetViewController];
    }
}

- (void)requestDataAndSetViewController {
    LeeWeakSelf(self);
    NSString *urlHeaderStr = [self xlZJNRSFBookWithBookID:self.bookID];
    [TopBookModelManager getAllReadBookZJNR:[NSString stringWithFormat:@"https://appios3.zygjzl.com//BookFiles/Html/%@/%@/%@.html",urlHeaderStr,self.bookID,self.mlArr[self.pageZJ]] ChapterID:self.mlArr[self.pageZJ] bookIDString:self.bookID success:^(id  _Nonnull responseObject) {
        weakself.xlBookReadZJNRModel = responseObject;
        XXBookContentVC *contentVC = [[XXBookContentVC alloc] init];
        contentVC.xlBookReadZJNRModel = self.xlBookReadZJNRModel;
        //contentVC.chapter = kReadingManager.chapter;
        if (weakself.ispreChapter) {
            [TopBookModelManager pagingWithBounds:kReadingFrame withFont:fontSize(TopBookModelManager.font) andChapter:weakself.xlBookReadZJNRModel];
            contentVC.page = TopBookModelManager.pagePrevious;
            weakself.pageCurrent = TopBookModelManager.pagePrevious;
            if (TopBookModelManager.transitionStyle ==  kTransitionStyle_Scroll){
                [self.pageViewController setViewControllers:@[contentVC] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:^(BOOL finished) {
                    if (finished) {
                        weakself.isTaping = NO;
                    }
                }];
            }else{
                [self.pageViewController setViewControllers:@[contentVC] direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:^(BOOL finished) {
                    if (finished) {
                        weakself.isTaping = NO;
                    }
                }];
            }
        }else{
            NSLog(@"222");
            contentVC.page = weakself.pageCurrent;
            if (TopBookModelManager.transitionStyle ==  kTransitionStyle_Scroll){
                [self.pageViewController setViewControllers:@[contentVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
                    if (finished) {
                        weakself.isTaping = NO;
                    }
                }];
            }else{
                [self.pageViewController setViewControllers:@[contentVC] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:^(BOOL finished) {
                    if (finished) {
                        weakself.isTaping = NO;
                    }
                }];
            }
        }
        
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
#pragma mark - 处理菜单的单击事件
- (void)configMenuTap {
    
    LeeWeakSelf(self);
    
    self.menuView.delegate = [RACSubject subject];
    
    [self.menuView.delegate subscribeNext:^(id  _Nullable x) {
        
        NSUInteger type = [x integerValue];
        
        switch (type) {
            case kBookMenuType_close: {
                //关闭
                
                //保存进度
                //TopBookModel *manager = [TopBookModel shareReadingManager];
                TopBookOneBookDModel *dbmodel = [kDatabase getBookWithId:weakself.bookID];
                TopBookOneBookDModel *model = [TopBookOneBookDModel new];
                BookSettingModel *settingModel = [BookSettingModel decodeModelWithKey:[BookSettingModel className]];
                settingModel.dayMode = TopBookModelManager.dayMode;
                [BookSettingModel encodeModel:settingModel key:[BookSettingModel className]];
                if (dbmodel) {
                    model.Id = self.bookID;
                    model.page = self.pageCurrent;
                    model.chapter = self.pageZJ;
                    model.Img = dbmodel.Img;
                    model.Name = dbmodel.Name;
                    model.LastChapter = dbmodel.LastChapter;
                    [kDatabase deleteBookWithId:self.bookID];
                }else{
                    model.Id = self.bookID;
                    model.page = self.pageCurrent;
                    model.chapter = self.pageZJ;
                    model.Img = TopBookModelManager.topBookOneBookDModel.Img;
                    model.Name = TopBookModelManager.topBookOneBookDModel.Name;
                    model.LastChapter = TopBookModelManager.topBookOneBookDModel.LastChapter;
                }
                
                if ([kDatabase insertBook:model]) {
                    NSLog(@"存储书籍成功");
                }else{
                    NSLog(@"存储书籍失败");
                }
                [weakself go2Back];
            }
                break;
            case kBookMenuType_day: {
                //白天黑夜切换
                [weakself.menuView changeDayAndNight];
            }
                break;
            case kBookMenuType_directory: {
                //目录
                [weakself showDirectoryVCWithIsReplaceSummary:NO];
            }
                
                break;
            case kBookMenuType_down: {
                //下载
                
            }
                break;
            case kBookMenuType_setting: {
                //设置
                [weakself.menuView showOrHiddenSettingView];
                
            }
                break;
                
            default:
                break;
        }
    }];
    
    
        self.menuView.settingView.changeSmallerFontBlock = ^{
            //字体缩小
            NSUInteger font = TopBookModelManager.font - 1;
            [weakself changeWithFont:font];
        };

        self.menuView.settingView.changeBiggerFontBlock = ^{
            //字体放大
            NSUInteger font = TopBookModelManager.font + 1;
            [weakself changeWithFont:font];
        };

        self.menuView.settingView.moreSettingBlock = ^{
            XXReadSettingVC *vc = [[XXReadSettingVC alloc] init];
            [weakself pushViewController:vc];
            vc.transitionStyleBlock = ^(kTransitionStyle style) {
                //先删除pageViewController在重新加上
                [weakself.pageViewController willMoveToParentViewController:nil];
                [weakself.pageViewController.view removeFromSuperview];
                [weakself.pageViewController removeFromParentViewController];
                kDealloc(weakself.pageViewController);
                [weakself pageViewController];
                [weakself requestDataAndSetViewController];
                [weakself showMenu];
            };
        };
}


#pragma mark - 弹出目录
- (void)showDirectoryVCWithIsReplaceSummary:(BOOL)isReplaceSummary {
    
    //[HUD hide];
    TopBookModelManager.chapter = self.pageZJ;
    XXDirectoryVC *directoryVC = [[XXDirectoryVC alloc] initWithIsReplaceSummary:isReplaceSummary];
    directoryVC.dataArr = self.bookZJLBArr;
    [self presentViewController:directoryVC animated:YES completion:^{
        //[directoryVC scrollToCurrentRow];
    }];
    
    //选择章节
    LeeWeakSelf(self);
    NSString *urlHeaderStr = [self xlZJNRSFBookWithBookID:self.bookID];
    directoryVC.selectChapter = ^(NSInteger chapter) {
        [weakself showMenu];
        [TopBookModelManager getAllReadBookZJNR:[NSString stringWithFormat:@"https://appios3.zygjzl.com//BookFiles/Html/%@/%@/%@.html",urlHeaderStr,self.bookID,weakself.mlArr[chapter]] ChapterID:weakself.mlArr[chapter] bookIDString:self.bookID success:^(id  _Nonnull responseObject) {
            weakself.pageCurrent = 0;
            weakself.pageZJ = chapter;
            weakself.xlBookReadZJNRModel = responseObject;
            XXBookContentVC *contentVC = [[XXBookContentVC alloc] init];
            contentVC.xlBookReadZJNRModel = weakself.xlBookReadZJNRModel;
            //contentVC.chapter = kReadingManager.chapter;
            contentVC.page = weakself.pageCurrent;
            weakself.isTaping = NO;
            [weakself.pageViewController setViewControllers:@[contentVC] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        } failure:^(NSError * _Nonnull error) {
            
        }];
        
        //        [kReadingManager requestContentWithChapter:chapter ispreChapter:weakSelf.ispreChapter Completion:^{
        //            [HUD hide];
        //            kReadingManager.chapter = chapter;
        //            kReadingManager.page = 0;
        //
        //            [weakSelf.pageViewController setViewControllers:@[[weakSelf getpageBookContent]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        //
        //        } failure:^(NSString *error) {
        //            [HUD hide];
        //        }];
    };
}


#pragma mark - 改变内容字体大小
- (void)changeWithFont:(NSUInteger)font {

    if (font < 5) return;
        BookSettingModel *md = [BookSettingModel decodeModelWithKey:[BookSettingModel className]];
        md.font = font;
        TopBookModelManager.font = md.font;
        [BookSettingModel encodeModel:md key:[BookSettingModel className]];

        [TopBookModelManager pagingWithBounds:kReadingFrame withFont:fontSize(TopBookModelManager.font) andChapter:self.xlBookReadZJNRModel];

        //跳转回该章的第一页
        if (self.pageCurrent < TopBookModelManager.pagePrevious) {
            self.pageCurrent = 0;
        }
        [self.pageViewController setViewControllers:@[[self getpageBookContent]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}


#pragma mark - 弹出或隐藏菜单
- (void)showMenu {
    
    [self.view insertSubview:self.menuView aboveSubview:self.pageViewController.view];
    
    if (!self.menuView.hidden) {
        //如果没有隐藏，代表已经弹出来了，那么执行的是隐藏操作
        self.hiddenStatusBar = YES;
    } else {
        self.hiddenStatusBar = NO;
    }
    
    [self.menuView showMenuWithDuration:kShowMenuDuration completion:nil];
    
    [self.menuView showTitle:self.bookName bookLink:nil];
}


#pragma mark - get/set

- (void)setPresentComplete:(BOOL)presentComplete {
    _presentComplete = presentComplete;
    if (_presentComplete) {
        self.hiddenStatusBar = YES;
    }
}


//控制状态栏的显示和隐藏
- (void)setHiddenStatusBar:(BOOL)hiddenStatusBar {
    LeeWeakSelf(self);
    _hiddenStatusBar = hiddenStatusBar;
    [UIView animateWithDuration:kShowMenuDuration animations:^{
        //给状态栏的隐藏和显示加动画
        [weakself setNeedsStatusBarAppearanceUpdate];
    }];
}


#pragma mark - getter

//pageViewController
- (UIPageViewController *)pageViewController {
    
    if (!_pageViewController) {
        //NSDictionary *options = @{UIPageViewControllerOptionSpineLocationKey : @(UIPageViewControllerSpineLocationMin)};
        UIPageViewControllerTransitionStyle style;
        //BOOL doubleSided = NO;
        if (TopBookModelManager.transitionStyle == kTransitionStyle_Scroll) {
            style = UIPageViewControllerTransitionStyleScroll;
        }
        else {
            //doubleSided = YES;
            style = UIPageViewControllerTransitionStylePageCurl;
        }
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:style navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
        [self.view addSubview:_pageViewController.view];
        [self addChildViewController:_pageViewController];
        for (UIGestureRecognizer *gesture in _pageViewController.gestureRecognizers) {
            /*
             /UIPageViewControllerTransitionStylePageCurl模拟翻页类型中有UIPanGestureRecognizer UITapGestureRecognizer两种手势，删除左右边缘的点击事件
             */
            if ([gesture isKindOfClass:UITapGestureRecognizer.class]) {
                [_pageViewController.view removeGestureRecognizer:gesture];
            }
        }
    }
    return _pageViewController;
}
//菜单
- (XXBookMenuView *)menuView {
    LeeWeakSelf(self);
    if (!_menuView) {
        _menuView = [[XXBookMenuView alloc] init];
        [self.view addSubview:_menuView];
        
        //第一次进来要隐藏
        _menuView.hidden = YES;
        
        [_menuView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakself.view);
        }];
        
        [_menuView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            //来到这里表示menu已经是弹出来的
            [weakself showMenu];
        }]];
        
        [self configMenuTap];
    }
    return _menuView;
}



@end
