//
//  XLTabBarBookController.m
//  XLBook
//
//  Created by Lee on 2019/10/21.
//  Copyright © 2019 Lee. All rights reserved.
//

#import "XLTabBarBookController.h"
#import "MyBookController.h"
#import "TopBookController.h"
#import "SearchBookController.h"
#import "XLBookNavController.h"
@interface XLTabBarBookController ()

@end

@implementation XLTabBarBookController

+ (void)initialize
{
    [self setupTabBar];
}

+ (void)setupTabBar
{
    //LNSkin *skin = [LNSkinHelper sharedHelper].currentSkin;
    //UITabBarItem *tabBarItem = [UITabBarItem appearance];
    //[tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorHex(skin.tabBarTitleNormalColor)} forState:UIControlStateNormal];
//    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorHex(skin.tabBarTitleSelectColor)} forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupChildVC];
}

- (void)setupChildVC
{
    //LNSkin *skin = [LNSkinHelper sharedHelper].currentSkin;
    //书架
    //[self setupChildVC:[XLBookBaseController class] title:@"书架" image:skin.tabBarOneNormalImage selectImage:skin.tabBarOneSelectImage];
    [self setupChildVC:[MyBookController class] title:@"书架" image:@"icon_tabbar_bookshelf_24x24_" selectImage:@"icon_tabbar_bookshelf_sel_24x24_"];
    //分类
    //[self setupChildVC:[XLBookBaseController class] title:@"排行榜" image:skin.tabBarTwoNormalImage selectImage:skin.tabBarTwoSelectImage];
    [self setupChildVC:[TopBookController class] title:@"排行榜" image:@"icon_tabbar_classify_24x24_" selectImage:@"icon_tabbar_classify_sel_24x24_"];
    //我的
    //[self setupChildVC:[XLBookBaseController class] title:@"搜索" image:skin.tabBarThreeNormalImage selectImage:skin.tabBarThreeSelectImage];
    [self setupChildVC:[SearchBookController class] title:@"搜索" image:@"icon_tabbar_mine_24x24_" selectImage:@"icon_tabbar_mine_sel_24x24_"];
}

- (void)setupChildVC:(Class)child title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage
{
    UIViewController *childVC = [[child alloc] init];
    
    childVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    XLBookNavController *navi = [[XLBookNavController alloc] initWithRootViewController:childVC];
    navi.title = title;
    [self addChildViewController:navi];
}


@end
