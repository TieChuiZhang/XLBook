//
//  TopBookOneBookMLCell.m
//  XLBook
//
//  Created by Lee on 2019/10/23.
//  Copyright © 2019 Lee. All rights reserved.
//

#import "TopBookOneBookMLCell.h"
@interface TopBookOneBookMLCell()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, copy) UILabel *mlLabel;
/**最新章节  */
@property (nonatomic, copy) UILabel *LastChapter;
/**更新时间  */
@property (nonatomic, copy) UILabel *LastTime;
@end
@implementation TopBookOneBookMLCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.mlLabel];
        [self.bgView addSubview:self.LastChapter];
        [self.bgView addSubview:self.LastTime];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self).offset(0);
    }];
    
    [_mlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).offset(5);
        make.left.equalTo(self.bgView).offset(20);
        make.width.offset(50);
        make.height.offset(20);
    }];
    
    [_LastChapter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).offset(5);
        make.left.equalTo(self.mlLabel.mas_right).offset(10);
        make.right.equalTo(self.bgView).offset(-10);
    }];
    
    [_LastTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.LastChapter.mas_bottom).offset(5);
        make.left.equalTo(self.mlLabel.mas_right).offset(10);
        make.right.equalTo(self.bgView).offset(-10);
        make.bottom.equalTo(self.bgView).offset(-5);
    }];
}

+ (instancetype)xlTopBookOneBookMLCellWithTableView:(UITableView *)tableView IndexPathRow:(NSInteger)row
{
    static NSString *ID = @"TopBookOneBookMLCell";
    TopBookOneBookMLCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TopBookOneBookMLCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
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

- (UILabel *)mlLabel
{
    if (!_mlLabel) {
        _mlLabel = [UILabel new];
        _mlLabel.text = @"无";
        _mlLabel.font = [UIFont boldSystemFontOfSize:13];
        _mlLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    }
    return _mlLabel;
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

- (UILabel *)LastTime
{
    if (!_LastTime) {
        _LastTime = [UILabel new];
        _LastTime.font = [UIFont systemFontOfSize:11];
        _LastTime.textColor = [UIColor colorWithHexString:@"#666666"];
    }
    return _LastTime;
}

- (void)setXLBookOneBookDMLModelCellValue:(TopBookOneBookDModel *)xlBookOneBookDMLModel
{
    self.LastTime.text = xlBookOneBookDMLModel.LastTime;
    self.LastChapter.text = xlBookOneBookDMLModel.LastChapter;
}

@end
