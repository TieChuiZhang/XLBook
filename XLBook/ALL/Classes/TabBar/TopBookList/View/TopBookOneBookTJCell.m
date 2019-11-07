//
//  TopBookOneBookTJCell.m
//  XLBook
//
//  Created by Lee on 2019/10/23.
//  Copyright © 2019 Lee. All rights reserved.
//

#import "TopBookOneBookTJCell.h"
#import "TopBookOneBookHXJListView.h"
#import "TopBookOneBookTJView.h"
@interface TopBookOneBookTJCell()<TopBookOneBookTJViewDelegate>
@property (nonatomic, strong) TopBookOneBookTJView *topBookOneBookTJView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *headerLabel;
@property (nonatomic, copy) NSArray *dataArray;
@end
@implementation TopBookOneBookTJCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.headerLabel];
        //[self updateConstraintsForView];
        CGFloat marginX = 0;  //按钮距离左边和右边的距离
        CGFloat marginY = 1;  //距离上下边缘距离
        CGFloat toTop = 30;  //按钮距离顶部的距离
        CGFloat gapX = 10;    //左右按钮之间的距离
        CGFloat gapY = 10;    //上下按钮之间的距离
        NSInteger col = 3;    //这里只布局5列
        NSInteger count = 6;  //这里先设置布局任意个按钮
        
        CGFloat viewWidth = kScreenWidth-20;  //视图的宽度
        //CGFloat viewHeight = self.bounds.size.height;  //视图的高度
        CGFloat itemWidth = (viewWidth - marginX *2 - (col - 1)*gapX)/col*1.0f;  //根据列数 和 按钮之间的间距 这些参数基本可以确定要平铺的按钮的宽度
        CGFloat itemHeight = itemWidth+50;   //按钮的高度可以根据情况设定 这里设置为相等
        TopBookOneBookTJView *last = nil;   //上一个按钮
        
        for (int i = 0 ; i < count; i++) {
            self.topBookOneBookTJView = [self TopBookOneBookTJView];
            self.topBookOneBookTJView.tag = i+1;
            self.topBookOneBookTJView.delegate = self;
            [self.bgView addSubview:self.topBookOneBookTJView];
            //布局
            [_topBookOneBookTJView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                //宽高是固定的，前面已经算好了
                make.width.mas_equalTo(itemWidth);
                make.height.mas_equalTo(itemHeight);
                
                //topTop距离顶部的距离，单行不用考虑太多，多行，还需要计算距离顶部的距离
                //计算距离顶部的距离 --- 根据换行
                CGFloat top = toTop + marginY + (i/col)*(itemHeight+gapY);
                make.top.mas_offset(top);
                if (!last || (i%col) == 0) {  //last为nil  或者(i%col) == 0 说明换行了 每行的第一个确定它距离左边边缘的距离
                    make.left.mas_offset(marginX);
                    
                }else{
                    //第二个或者后面的按钮 距离前一个按钮右边的距离都是gap个单位
                    make.left.mas_equalTo(last.mas_right).mas_offset(gapX);
                }
            }];
               
            last = self.topBookOneBookTJView;
           }
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
    
    [_headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).offset(5);
        make.left.equalTo(self.bgView).offset(20);
        make.right.equalTo(self.bgView).offset(-10);
        make.height.offset(20);
    }];
}

- (void)topBookOneBookTJViewTapCurrentView:(TopBookOneBookTJView *)topEView
{
    if (_selectItem) {
        _selectItem(self.dataArray[topEView.tag][@"Id"]);
    }
    NSLog(@"%@",self.dataArray[topEView.tag]);
}

- (UILabel *)headerLabel
{
    if (!_headerLabel) {
        _headerLabel = [UILabel new];
        _headerLabel.text = @"同类推荐";
        _headerLabel.font = [UIFont boldSystemFontOfSize:14];
    }
    return _headerLabel;
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor whiteColor];
//        _bgView.layer.cornerRadius = 2;
    }
    return _bgView;
}

- (TopBookOneBookTJView *)TopBookOneBookTJView
{
    TopBookOneBookTJView *item = [[TopBookOneBookTJView alloc] init];
    return item;
}

+ (instancetype)xlTopBookOneBookTJCellWithTableView:(UITableView *)tableView IndexPathRow:(NSInteger)row{
    static NSString *ID = @"TopBookOneBookTJCell";
    TopBookOneBookTJCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TopBookOneBookTJCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setXLBookOneBookDTJModelCellValue:(TopBookOneBookDModel *)xlBookOneBookDMLModel ArrayWithHXGDataArray:(NSArray *)dataArray{
    self.dataArray = xlBookOneBookDMLModel.SameCategoryBooks;
    for (int i = 1; i<=6; i++) {
        [self abdWithUrlString:xlBookOneBookDMLModel.SameCategoryBooks[i][@"Img"] WithNameString:xlBookOneBookDMLModel.SameCategoryBooks[i][@"Name"] ViewTagWithCurrentTag:i];
    }
}

- (void)abdWithUrlString:(NSString *)string WithNameString:(NSString *)nameString ViewTagWithCurrentTag:(NSInteger)tag{
    TopBookOneBookTJView *ooo = [self viewWithTag:tag];
    ooo.Name.text = nameString;
    [ooo.Img setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://imgapi.jiaston.com/BookFiles/BookImages/%@",string]] placeholder:[UIImage imageNamed:@"无封面.jpg"]];
}

@end
