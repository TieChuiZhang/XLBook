//
//  MyBookController.m
//  XLBook
//
//  Created by Lee on 2019/10/21.
//  Copyright © 2019 Lee. All rights reserved.
//

#import "MyBookController.h"
#import "TopBookOneBookTJView.h"
@interface MyBookController ()
@property (nonatomic, strong) TopBookOneBookTJView *topBookOneBookTJView;
@end

@implementation MyBookController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //如果需要考虑横竖屏可以将布局代码写在LayoutSubViews这个方法中
     //九宫格布局单行
     //[self layoutOneLine];
     
     
     //九宫格布局多行 其实跟单行布局差不多，唯一要注意的是要判断换行的问题  为了体现差异，把两种单独写 代码确实有大量重复的
     //多行布局是支持单行的
     [self layoutMultiLine];
     
     
     //分析了代码可以看出来 多行布局和单行布局其实没有什么特殊的地方
     //区别点 1.确定什么时候换行
     //      2.确定距离布局区域顶部的距离多少
     //当前在真是开发环境中还会存在各种差异，但是只要理解了布局思路，相信不管怎么样布局都会游刃有余

}

- (void)layoutMultiLine{
    //多行布局 要考虑换行的问题
    
    CGFloat marginX = 10;  //按钮距离左边和右边的距离
    CGFloat marginY = 1;  //距离上下边缘距离
    CGFloat toTop = 200;  //按钮距离顶部的距离
    CGFloat gapX = 10;    //左右按钮之间的距离
    CGFloat gapY = 10;    //上下按钮之间的距离
    NSInteger col = 3;    //这里只布局5列
    NSInteger count = 6;  //这里先设置布局任意个按钮
    
    CGFloat viewWidth = self.view.bounds.size.width;  //视图的宽度
    CGFloat viewHeight = self.view.bounds.size.height;  //视图的高度
    CGFloat itemWidth = (viewWidth - marginX *2 - (col - 1)*gapX)/col*1.0f;  //根据列数 和 按钮之间的间距 这些参数基本可以确定要平铺的按钮的宽度
    CGFloat itemHeight = itemWidth;   //按钮的高度可以根据情况设定 这里设置为相等
    TopBookOneBookTJView *last = nil;   //上一个按钮
    //准备工作完毕 既可以开始布局了
    for (int i = 0 ; i < count; i++) {
        self.topBookOneBookTJView = [self TopBookOneBookTJView];
        [self.view addSubview:self.topBookOneBookTJView];
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

- (TopBookOneBookTJView *)TopBookOneBookTJView
{
    TopBookOneBookTJView * item = [[TopBookOneBookTJView alloc] init];
    item.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0f];
    return item;
}


//-(void)layoutOneLine{
//    //单行布局 不需要考虑换行的问题
//
//    CGFloat marginX = 10;  //按钮距离左边和右边的距离
//    CGFloat marginY = 10;  //按钮距离布局顶部的距离
//    CGFloat toTop = 50;  //布局区域距离顶部的距离
//    CGFloat gap = 10;    //按钮与按钮之间的距离
//    NSInteger col = 3;    //这里只布局5列
//    NSInteger count = 3;  //这里先设置布局5个按钮
//
//    CGFloat viewWidth = self.view.bounds.size.width;  //视图的宽度
//    CGFloat viewHeight = self.view.bounds.size.height;  //视图的高度
//
//    CGFloat itemWidth = (viewWidth - marginX *2 - (col - 1)*gap)/col*1.0f;  //根据列数 和 按钮之间的间距 这些参数基本可以确定要平铺的按钮的宽度
//    CGFloat height = itemWidth;   //按钮的高度可以根据情况设定 这里设置为相等
//
//    UIButton *last = nil;   //上一个按钮
//    //准备工作完毕 既可以开始布局了
//    for (int i = 0 ; i < count; i++) {
//        UIButton *item = [self buttonCreat];
//        [item setTitle:@(i).stringValue forState:UIControlStateNormal];
//        [self.view addSubview:item];
//
//        //布局
//        [item mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            //宽高是固定的，前面已经算好了
//            make.width.mas_equalTo(itemWidth);
//            make.height.mas_equalTo(height);
//
//            //topTop距离顶部的距离，单行不用考虑太多，多行，还需要计算距离顶部的距离
//            make.top.mas_offset(toTop+marginY);
//            if (!last) {  //last为nil 说明是第一个按钮
//                make.left.mas_offset(marginX);
//
//            }else{
//                //第二个或者后面的按钮 距离前一个按钮右边的距离都是gap个单位
//                make.left.mas_equalTo(last.mas_right).mas_offset(gap);
//            }
//        }];
//        last = item;
//    }
//}
//
//- (void)layoutMultiLine{
//    //多行布局 要考虑换行的问题
//
//    CGFloat marginX = 10;  //按钮距离左边和右边的距离
//    CGFloat marginY = 1;  //距离上下边缘距离
//    CGFloat toTop = 200;  //按钮距离顶部的距离
//    CGFloat gapX = 10;    //左右按钮之间的距离
//    CGFloat gapY = 10;    //上下按钮之间的距离
//    NSInteger col = 3;    //这里只布局5列
//    NSInteger count = 6;  //这里先设置布局任意个按钮
//
//    CGFloat viewWidth = self.view.bounds.size.width;  //视图的宽度
//    CGFloat viewHeight = self.view.bounds.size.height;  //视图的高度
//    CGFloat itemWidth = (viewWidth - marginX *2 - (col - 1)*gapX)/col*1.0f;  //根据列数 和 按钮之间的间距 这些参数基本可以确定要平铺的按钮的宽度
//    CGFloat itemHeight = itemWidth;   //按钮的高度可以根据情况设定 这里设置为相等
//    UIButton *last = nil;   //上一个按钮
//    //准备工作完毕 既可以开始布局了
//    for (int i = 0 ; i < count; i++) {
//        UIButton *item = [self buttonCreat];
//        [item setTitle:@(i).stringValue forState:UIControlStateNormal];
//        [self.view addSubview:item];
//        //布局
//        [item mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            //宽高是固定的，前面已经算好了
//            make.width.mas_equalTo(itemWidth);
//            make.height.mas_equalTo(itemHeight);
//
//            //topTop距离顶部的距离，单行不用考虑太多，多行，还需要计算距离顶部的距离
//            //计算距离顶部的距离 --- 根据换行
//            CGFloat top = toTop + marginY + (i/col)*(itemHeight+gapY);
//            make.top.mas_offset(top);
//            if (!last || (i%col) == 0) {  //last为nil  或者(i%col) == 0 说明换行了 每行的第一个确定它距离左边边缘的距离
//                make.left.mas_offset(marginX);
//
//            }else{
//                //第二个或者后面的按钮 距离前一个按钮右边的距离都是gap个单位
//                make.left.mas_equalTo(last.mas_right).mas_offset(gapX);
//            }
//        }];
//        last = item;
//    }
//}
//
//#pragma mark - Private
//-(UIButton *)buttonCreat{
//    UIButton *item = [[UIButton alloc] init];
//    item.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0f];
//    item.titleLabel.font = [UIFont systemFontOfSize:16];
//    [item setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    return item;
//}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
