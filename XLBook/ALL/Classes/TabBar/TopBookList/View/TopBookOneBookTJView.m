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
        [self addSubview:self.Img];
         
    }
    return self;
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
        _Name.font = [UIFont boldSystemFontOfSize:14];
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
        make.width.offset(80);
        make.height.offset(80);
    }];
    
    [_Name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self).offset(-10);
    }];
}

- (void)setXLBookOne:(TopBookOneBookDModel *)xlBookOneBookDMLModel
{
    NSLog(@"%@",xlBookOneBookDMLModel);
    //[self.Img setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://imgapi.jiaston.com/BookFiles/BookImages/%@",xlBookOneBookDMLModel.Img]]];
}
@end
