//
//  XLTopOneBookNav.m
//  XLBook
//
//  Created by Lee on 2019/10/22.
//  Copyright © 2019 Lee. All rights reserved.
//

#import "XLTopOneBookNav.h"

@implementation XLTopOneBookNav

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self bulidUI];
    }
    return self;
}

- (void)bulidUI {
    
    UIView *navV = [[UIView alloc]initWithFrame:self.bounds];
    navV.backgroundColor = RGBCOLOR(239, 239, 239);
    navV.alpha = 0;
    [self addSubview:navV];
    self.navV = navV;
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(20, navV.height - 40 , 30, 30);
    [backBtn setImage:[UIImage imageNamed:@"back_w"] forState:0];
    [self addSubview:backBtn];
    self.backBtn = backBtn;
    
    UIButton *camareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    camareBtn.frame = CGRectMake(kScreenWidth - 20 - 30,navV.height - 40 , 30, 30);
    [camareBtn setImage:[UIImage imageNamed:@"camera_w"] forState:0];
    [self addSubview:camareBtn];
    self.camareBtn = camareBtn;
    
    UILabel *navLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, navV.height - 40, kScreenWidth, 30)];
    navLabel.textAlignment = 1;
    navLabel.text = @"书籍详情";
    navLabel.alpha = 0;
    navLabel.font = [UIFont boldSystemFontOfSize:17];
    [self addSubview:navLabel];
    self.navLabel = navLabel;
}
- (void)setIsScrollUp:(BOOL)isScrollUp {
    
    _isScrollUp = isScrollUp;
    
    if (_isScrollUp) {
        
        [self.backBtn setImage:[UIImage imageNamed:@"back"] forState:0];
        [self.camareBtn setImage:[UIImage imageNamed:@"camera"] forState:0];
        
    } else {
        
        [self.backBtn setImage:[UIImage imageNamed:@"back_w"] forState:0];
        [self.camareBtn setImage:[UIImage imageNamed:@"camera_w"] forState:0];
    }
    
}
@end
