//
//  TopBookDCell.h
//  XLBook
//
//  Created by Lee on 2019/10/21.
//  Copyright © 2019 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopBookListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TopBookDCell : UITableViewCell
- (void)setXLBookListModelCellValue:(TopBookListModel *)topBookListModel;
+ (instancetype)xlTopBookListCellWithTableView:(UITableView *)tableView IndexPathRow:(NSInteger)row;
@end

NS_ASSUME_NONNULL_END
