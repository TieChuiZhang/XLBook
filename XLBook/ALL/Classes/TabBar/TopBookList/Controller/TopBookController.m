//
//  TopBookController.m
//  XLBook
//
//  Created by Lee on 2019/10/21.
//  Copyright © 2019 Lee. All rights reserved.
//

#import "TopBookController.h"

@interface TopBookController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation TopBookController

- (UICollectionView *)collectionView {
    
    if (_collectionView == nil) {
        // 创建FlowLayout
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        // 垂直方向滑动
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        // 创建collectionView
        CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        // 设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        // 其他属性
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsVerticalScrollIndicator = NO;          // 隐藏垂直方向滚动条
        // 注册cell
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"MyCell"];
        // 注册Header
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MyHeader"];
        // 注册Footer
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"MyFooter"];
    }
    
    return _collectionView;
}

// 返回Header的尺寸大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(100, 30);
}

// 返回cell的尺寸大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(100, 100);      // 让每个cell尺寸都不一样
}

// 返回Footer的尺寸大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    return CGSizeMake(0, 0);
}

// 返回cell之间行间隙
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 10;
}

// 返回cell之间列间隙
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 10;
}

// 设置上左下右边界缩进
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(20, 20, 20, 20);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];

}

// 返回Section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 2;
}

// 返回cell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 6;
}

// 返回cell内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 创建cell (重用)
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
    
    // 设置cell
    
    cell.backgroundColor = [UIColor darkGrayColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:cell.bounds];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"Cell";
    label.textColor = [UIColor whiteColor];
    [cell addSubview:label];
    
    return cell;
}


// 返回Header/Footer内容
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {          // Header视图
        // 从复用队列中获取HooterView
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MyHeader" forIndexPath:indexPath];
        // 设置HooterView
        UILabel *label = [[UILabel alloc] initWithFrame:headerView.bounds];
        label.textAlignment = NSTextAlignmentRight;
        if (indexPath.section == 0) {
            label.text = @"the 太";
        }else{
             label.text = @"the 大";
        }
        label.textColor = [UIColor whiteColor];
        [headerView addSubview:label];
        // 返回HooterView
        return headerView;
        
    }
    return nil;
}

// 选中某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self clickItemAtIndexPath:indexPath];
}

- (void)clickItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *string;
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                string = [NSString stringWithFormat:@"%@",self.dlListDic[@"最热"][0]];
                break;
                case 1:
                string = [NSString stringWithFormat:@"%@",self.dlListDic[@"评分"][0]];
                break;
            default:
                break;
        }
    }else{
        switch (indexPath.row) {
            case 0:
                string = [NSString stringWithFormat:@"%@",self.dlListDic[@"最热"][1]];
                break;
                case 1:
                string = [NSString stringWithFormat:@"%@",self.dlListDic[@"评分"][1]];
                break;
            default:
                break;
        }
    }
    NSDictionary *dic = @{@"listUrl":string};
    NSLog(@"%@",dic);
    [LeeRunTimePush runtimePush:@"TopBookDController" dic:dic nav:self.navigationController];
}

@end
