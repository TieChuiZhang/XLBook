//
//  TopBookOneBookHXJListCell.m
//  XLBook
//
//  Created by Lee on 2019/10/23.
//  Copyright © 2019 Lee. All rights reserved.
//

#import "TopBookOneBookHXJListCell.h"
@interface TopBookOneBookHXJListCell()
@property (nonatomic, strong) UIView *bgView;
/**书名  */
@property (nonatomic, copy) UILabel *Name;
/**书籍作者  */
@property (nonatomic, copy) UILabel *Author;
/**图片链接  */
@property (nonatomic, copy) UIImageView *Img;
/**最新章节  */
@property (nonatomic, copy) UILabel *LastChapter;
@end
@implementation TopBookOneBookHXJListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.Name];
        [self.bgView addSubview:self.Author];
        [self.bgView addSubview:self.Img];
        [self.bgView addSubview:self.LastChapter];
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
        make.width.offset(50);
        make.height.offset(70);
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

    [_LastChapter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.Author.mas_bottom).offset(5);
        make.left.equalTo(self.Img.mas_right).offset(10);
        make.right.equalTo(self.bgView).offset(-10);
        make.bottom.equalTo(self.bgView.mas_bottom).offset(-10);
    }];
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [UIView new];
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


- (UILabel *)LastChapter
{
    if (!_LastChapter) {
        _LastChapter = [UILabel new];
        _LastChapter.font = [UIFont boldSystemFontOfSize:12];
        _LastChapter.textColor = [UIColor colorWithHexString:@"#666666"];
    }
    return _LastChapter;
}

- (UIImageView *)Img
{
    if (!_Img) {
        _Img = [UIImageView new];
    }
    return _Img;
}

+ (instancetype)xlTopBookOneBookHXJListCellWithTableView:(UITableView *)tableView IndexPathRow:(NSInteger)row{
    static NSString *ID = @"TopBookOneBookHXJListCell";
    TopBookOneBookHXJListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TopBookOneBookHXJListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setXLBookListModelHXJListCellValue:(TopBookHXGModel *)topBookHXGModel {
    [self.Img setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://imgapi.jiaston.com/BookFiles/BookImages/%@",topBookHXGModel.Img]]];
    self.Name.text = topBookHXGModel.Name;
    self.Author.text = [NSString stringWithFormat:@"%@",topBookHXGModel.Author];
    self.LastChapter.text = topBookHXGModel.LastChapter;
}


@end
