//
//  TopBookDCell.m
//  XLBook
//
//  Created by Lee on 2019/10/21.
//  Copyright © 2019 Lee. All rights reserved.
//

#import "TopBookDCell.h"
#import "LeeLabel.h"
@interface TopBookDCell()
@property (nonatomic, strong) UIView *bgView;
/**书名  */
@property (nonatomic, copy) UILabel *Name;
/**书籍作者  */
@property (nonatomic, copy) UILabel *Author;
/**图片链接  */
@property (nonatomic, copy) UIImageView *Img;
/**书籍简介  */
@property (nonatomic, copy) LeeLabel *Desc;
/**书籍评分  */
@property (nonatomic, copy) UILabel *Score;
@end
@implementation TopBookDCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.Name];
        [self.bgView addSubview:self.Author];
        [self.bgView addSubview:self.Img];
        [self.bgView addSubview:self.Desc];
        [self.bgView addSubview:self.Score];
        //[self updateConstraintsForView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5);
        make.left.equalTo(self).offset(5);
        make.right.equalTo(self).offset(-5);
        make.bottom.equalTo(self).offset(-5);
    }];
    
    [_Img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).offset(5);
        make.left.equalTo(self.bgView).offset(10);
        make.width.offset(80);
        make.height.offset(80);
    }];
    
    [_Name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).offset(5);
        make.left.equalTo(self.Img.mas_right).offset(10);
        make.right.equalTo(self.bgView.mas_right).offset(-60);
        make.height.offset(20);
    }];
    
    [_Author mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.Name.mas_bottom).offset(5);
        make.left.equalTo(self.Img.mas_right).offset(10);
        make.right.equalTo(self.bgView.mas_right).offset(-10);
        make.height.offset(20);
    }];
    
    [_Desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.Author.mas_bottom).offset(5);
        make.left.equalTo(self.Img.mas_right).offset(10);
        make.right.equalTo(self.bgView.mas_right).offset(-10);
        make.bottom.equalTo(self.bgView).offset(10);
    }];
    
    [_Score mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).offset(5);
        make.right.equalTo(self.bgView).offset(-10);
        make.width.offset(50);
        make.height.offset(20);
    }];
}

+ (instancetype)xlTopBookListCellWithTableView:(UITableView *)tableView IndexPathRow:(NSInteger)row
{
    static NSString *ID = @"TopBookDCell";
    TopBookDCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TopBookDCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [UIView new];
        //_bgView.backgroundColor = [UIColor redColor];
    }
    return _bgView;
}

- (UILabel *)Name
{
    if (!_Name) {
        _Name = [UILabel new];
        _Name.font = [UIFont boldSystemFontOfSize:14];
        _Name.textColor = [UIColor colorWithHexString:@"#666666"];
    }
    return _Name;
}

- (UILabel *)Author
{
    if (!_Author) {
        _Author = [UILabel new];
        _Author.font = [UIFont systemFontOfSize:12];
        _Author.textColor = [UIColor colorWithHexString:@"#666666"];
    }
    return _Author;
}

- (LeeLabel *)Desc
{
    if (!_Desc) {
        _Desc = [LeeLabel new];
        _Desc.font = [UIFont systemFontOfSize:12];
        [_Desc setVerticalAlignment:VerticalAlignmentTop];
        _Desc.numberOfLines = 2.5;
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

- (void)setXLBookListModelCellValue:(TopBookListModel *)topBookListModel
{
    [self.Img setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://imgapi.jiaston.com/BookFiles/BookImages/%@",topBookListModel.Img]]];
    self.Name.text = topBookListModel.Name;
    self.Author.text = [NSString stringWithFormat:@"%@/%@",topBookListModel.Author,topBookListModel.CName];
    self.Desc.text = topBookListModel.Desc;
    self.Score.text = [NSString stringWithFormat:@"%.2f分",[topBookListModel.Score floatValue]];
}

@end
