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
@interface TopBookOneBookTJCell()
@property (nonatomic, strong) TopBookOneBookTJView *topBookOneBookTJView;
@end
@implementation TopBookOneBookTJCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
        //[self updateConstraintsForView];
        CGFloat marginX = 10;  //按钮距离左边和右边的距离
        CGFloat marginY = 1;  //距离上下边缘距离
        CGFloat toTop = 10;  //按钮距离顶部的距离
        CGFloat gapX = 10;    //左右按钮之间的距离
        CGFloat gapY = 10;    //上下按钮之间的距离
        NSInteger col = 3;    //这里只布局5列
        NSInteger count = 6;  //这里先设置布局任意个按钮
        
        CGFloat viewWidth = kScreenWidth;  //视图的宽度
        CGFloat viewHeight = self.bounds.size.height;  //视图的高度
        CGFloat itemWidth = (viewWidth - marginX *2 - (col - 1)*gapX)/col*1.0f;  //根据列数 和 按钮之间的间距 这些参数基本可以确定要平铺的按钮的宽度
        CGFloat itemHeight = itemWidth+15;   //按钮的高度可以根据情况设定 这里设置为相等
        TopBookOneBookTJView *last = nil;   //上一个按钮
        
        for (int i = 0 ; i < count; i++) {
               self.topBookOneBookTJView = [self TopBookOneBookTJView];
               self.topBookOneBookTJView.tag = i;
               [self addSubview:self.topBookOneBookTJView];
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
    

}

- (TopBookOneBookTJView *)TopBookOneBookTJView
{
    TopBookOneBookTJView *item = [[TopBookOneBookTJView alloc] init];
    item.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0f];
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
//    if (xlBookOneBookDMLModel.SameUserBooks.count == 0) {
//        self.height = YES;
//    }

    TopBookOneBookTJView *ooo = [self viewWithTag:1];
    [ooo.Img setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://imgapi.jiaston.com/BookFiles/BookImages/%@",xlBookOneBookDMLModel.Img]]];

    
    
    
  //  [self.topBookOneBookTJView setXLBookOne:xlBookOneBookDMLModel];

}

//- (void)setXLBookOneBookDTJModelCellValue:(TopBookHXGModel *)topBookHXGModel{
//    self.listView.topBookHXGModel = topBookHXGModel;
//    [self.listView.tableView reloadData];
//}

@end
