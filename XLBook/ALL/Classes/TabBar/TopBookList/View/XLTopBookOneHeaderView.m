//
//  XLTopBookOneHeaderView.m
//  XLBook
//
//  Created by Lee on 2019/10/22.
//  Copyright © 2019 Lee. All rights reserved.
//

#import "XLTopBookOneHeaderView.h"
@interface XLTopBookOneHeaderView()
@property (nonatomic, strong) UIImageView *bgImage;
/**书名  */
@property (nonatomic, strong) UILabel *Name;
/**书籍作者  */
@property (nonatomic, strong) UILabel *Author;
/**图片链接  */
@property (nonatomic, strong) UIImageView *Img;
/**书籍简介  */
@property (nonatomic, strong) UILabel *Desc;
/**书籍评分  */
@property (nonatomic, strong) UILabel *Score;

@property (nonatomic, strong) UIView *bgView;
@end
@implementation XLTopBookOneHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgImage];
        [self addSubview:self.bgView];
        [self addSubview:self.Name];
        [self addSubview:self.Desc];
        [self addSubview:self.Author];
        [self addSubview:self.Img];
        [self addSubview:self.Score];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.left.equalTo(self).offset(0);
        make.width.equalTo(self);
        make.height.offset(200);
    }];
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgImage.mas_bottom).offset(-30);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self).offset(-10);
    }];
    
    [_Img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).offset(-100);
        make.right.equalTo(self).offset(-20);
        make.width.offset(80);
        make.height.offset(110);
    }];
    
    [_Desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).offset(10);
        make.left.equalTo(self.bgView).offset(10);
        make.right.equalTo(self.bgView).offset(-10);
        make.bottom.equalTo(self.bgView).offset(-10);
    }];

    [_Name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgImage).offset(20);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self.Img.mas_left).offset(-20);
        make.height.offset(20);
    }];
    
    [_Author mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.Name.mas_bottom).offset(10);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self.Img.mas_left).offset(-20);
        make.height.offset(20);
    }];
}

- (UIImageView *)bgImage
{
    if (!_bgImage) {
        _bgImage = [UIImageView new];
        _bgImage.image = [UIImage imageNamed:@"headerImage@3x"];
    }
    return _bgImage;
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 2;
    }
    return _bgView;
}

- (UILabel *)Name
{
    if (!_Name) {
        _Name = [UILabel new];
        _Name.font = [UIFont boldSystemFontOfSize:18];
        _Name.textColor = [UIColor colorWithHexString:@"#000000"];
    }
    return _Name;
}

- (UILabel *)Author
{
    if (!_Author) {
        _Author = [UILabel new];
        _Author.font = [UIFont systemFontOfSize:14];
        _Author.textAlignment = NSTextAlignmentCenter;
        _Author.textColor = [UIColor colorWithHexString:@"#666666"];
    }
    return _Author;
}

- (UILabel *)Desc
{
    if (!_Desc) {
        _Desc = [UILabel new];
        _Desc.font = [UIFont systemFontOfSize:12];
        _Desc.text = @"请稍后...";
        _Desc.numberOfLines = 0;
        _Desc.textColor = [UIColor colorWithHexString:@"#666666"];
    }
    return _Desc;
}

- (UILabel *)Score
{
    if (!_Score) {
        _Score = [UILabel new];
        _Score.textAlignment = NSTextAlignmentCenter;
        _Score.textColor = [UIColor colorWithHexString:@"#EF5959"];
        _Score.font = [UIFont systemFontOfSize:12];
    }
    return _Score;
}

- (UIImageView *)Img
{
    if (!_Img) {
        _Img = [UIImageView new];
    }
    return _Img;
}

- (void)setXLBookOneBookWithSXTableView:(UITableView *)tableView HeaderValue:(TopBookOneBookDModel *)topBookOneBookDModel;
{
    self.Desc.text = topBookOneBookDModel.Desc;
    self.Name.text = topBookOneBookDModel.Name;
    self.Author.text = topBookOneBookDModel.Author;
    if ([ToolsObj isUrlAddress:topBookOneBookDModel.Img]) {
         [self.Img setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",topBookOneBookDModel.Img]] placeholder:[UIImage imageNamed:@"无封面.jpg"]];
    }else{
         [self.Img setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://imgapi.jiaston.com/BookFiles/BookImages/%@",topBookOneBookDModel.Img]] placeholder:[UIImage imageNamed:@"无封面.jpg"]];
    }
    [tableView layoutIfNeeded];
}

@end
