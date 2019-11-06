//
//  MyBookCell.m
//  XLBook
//
//  Created by Lee on 2019/11/5.
//  Copyright © 2019 Lee. All rights reserved.
//

#import "MyBookCell.h"
@interface MyBookCell()
@property (nonatomic, strong) UIView *bgView;
/**书名  */
@property (nonatomic, copy) UILabel *Name;
/**最新章节  */
@property (nonatomic, copy) UILabel *LastChapter;
/**图片链接  */
@property (nonatomic, copy) UIImageView *Img;

@end
@implementation MyBookCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.Name];
        [self.bgView addSubview:self.LastChapter];
        [self.bgView addSubview:self.Img];
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
        make.height.offset(50);
    }];

    [_Name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).offset(5);
        make.left.equalTo(self.Img.mas_right).offset(10);
        make.right.equalTo(self.bgView.mas_right).offset(-60);
        make.height.offset(20);
    }];

    [_LastChapter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.Name.mas_bottom).offset(5);
        make.left.equalTo(self.Img.mas_right).offset(10);
        make.right.equalTo(self.bgView.mas_right).offset(-10);
        make.height.offset(20);
    }];
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

- (UIImageView *)Img
{
    if (!_Img) {
        _Img = [UIImageView new];
    }
    return _Img;
}

- (UILabel *)LastChapter
{
    if (!_LastChapter) {
        _LastChapter = [UILabel new];
        _LastChapter.font = [UIFont systemFontOfSize:12];
        _LastChapter.textColor = [UIColor colorWithHexString:@"#666666"];
    }
    return _LastChapter;
}



+ (instancetype)xlBookMyBookCellWithTableView:(UITableView *)tableView IndexPathRow:(NSInteger)row
{
    static NSString *ID = @"MyBookCell";
    MyBookCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MyBookCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setXLBookMyBookModelWithCellValue:(TopBookOneBookDModel *)topBookOneBookDModel;
{
    if ([ToolsObj isUrlAddress:topBookOneBookDModel.Img]) {
        [self.Img setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",topBookOneBookDModel.Img]] placeholder:[UIImage imageNamed:@"无封面.jpg"]];
    }else{
         [self.Img setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://imgapi.jiaston.com/BookFiles/BookImages/%@",topBookOneBookDModel.Img]] placeholder:[UIImage imageNamed:@"无封面.jpg"]];
    }
    self.Name.text = topBookOneBookDModel.Name;
    self.LastChapter.text = topBookOneBookDModel.LastChapter;
}
@end
