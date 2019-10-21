//
//  XLBookNavController.m
//  XLBook
//
//  Created by Lee on 2019/10/21.
//  Copyright © 2019 Lee. All rights reserved.
//

#import "XLBookNavController.h"

@interface XLBookNavController ()

@end

@implementation XLBookNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UINavigationBar *app = self.navigationBar;
    app.barTintColor = UIColorHex(@"ffffff");
    app.shadowImage = [UIImage new];
    self.interactivePopGestureRecognizer.delegate = nil;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_return_8x14_"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

@end
