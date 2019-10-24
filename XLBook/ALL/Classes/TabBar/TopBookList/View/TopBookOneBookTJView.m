//
//  TopBookOneBookTJView.m
//  XLBook
//
//  Created by Lee on 2019/10/23.
//  Copyright © 2019 Lee. All rights reserved.
//

#import "TopBookOneBookTJView.h"
@interface TopBookOneBookTJView()
///**图片链接  */
//@property (nonatomic, copy) UIImageView *Img;
///**书名  */
//@property (nonatomic, copy) UILabel *Name;
@end
@implementation TopBookOneBookTJView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.Img];
        [self addSubview:self.Name];
        [self addGestureRecognizer:({
            [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topTopBookOneBookTJViewTap:)];
               })];
    }
    return self;
}

- (void)topTopBookOneBookTJViewTap:(UITapGestureRecognizer *)tjViewTap
{
    if ([self.delegate respondsToSelector:@selector(topBookOneBookTJViewTapCurrentView:)]) {
        [self.delegate topBookOneBookTJViewTapCurrentView:self];
    }
}

- (UIImageView *)Img
{
    if (!_Img) {
        _Img = [UIImageView new];
    }
    return _Img;
}

- (UILabel *)Name
{
    if (!_Name) {
        _Name = [UILabel new];
        _Name.font = [UIFont systemFontOfSize:12];
        _Name.numberOfLines = 2;
        _Name.textColor = [UIColor colorWithHexString:@"#666666"];
    }
    return _Name;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_Img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.height.offset(110);
    }];
    
    [_Name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.Img.mas_bottom).offset(0);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.height.offset(40);
    }];
}

- (void)setXLBookOne:(TopBookOneBookDModel *)xlBookOneBookDMLModel
{
    //NSLog(@"%@",xlBookOneBookDMLModel);
    //[self.Img setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://imgapi.jiaston.com/BookFiles/BookImages/%@",xlBookOneBookDMLModel.Img]]];
}
@end
