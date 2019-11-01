//
//  XLBookBaseController.m
//  XLBook
//
//  Created by Lee on 2019/10/21.
//  Copyright © 2019 Lee. All rights reserved.
//

#import "XLBookBaseController.h"

@interface XLBookBaseController ()

@end

@implementation XLBookBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"EBECF0"];
    self.dlListDic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"FLList" ofType:@"plist"]];
    [self setupViews];
    self.titleArr = @[@[@"最热榜",@"评分榜",@"收藏榜",@"推荐榜",@"完结榜",@"新书榜"],@[@"最热榜",@"评分榜",@"收藏榜",@"推荐榜",@"完结榜",@"新书榜"]];
}


//创建UI
- (void)setupViews {
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
