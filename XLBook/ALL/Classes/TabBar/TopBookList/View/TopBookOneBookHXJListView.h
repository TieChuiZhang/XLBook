//
//  TopBookOneBookHXJListView.h
//  XLBook
//
//  Created by Lee on 2019/10/23.
//  Copyright © 2019 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopBookHXGModel.h"
@class TopBookOneBookHXJListView;
NS_ASSUME_NONNULL_BEGIN
@protocol TopBookHXJListCellDelegate <NSObject>
- (void)topBookHXJListCellTapInCellWithView:(TopBookOneBookHXJListView *)TopBookOneBookHXJListView ModelWithCellModel:(TopBookHXGModel *)model byCellIndexRow:(NSInteger )row;
@end
@interface TopBookOneBookHXJListView : UIView
@property (nonatomic, weak) id<TopBookHXJListCellDelegate> delegate;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataArray;
@end

NS_ASSUME_NONNULL_END
