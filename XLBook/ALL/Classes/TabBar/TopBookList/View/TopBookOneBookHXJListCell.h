//
//  TopBookOneBookHXJListCell.h
//  XLBook
//
//  Created by Lee on 2019/10/23.
//  Copyright © 2019 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopBookHXGModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TopBookOneBookHXJListCell : UITableViewCell
+ (instancetype)xlTopBookOneBookHXJListCellWithTableView:(UITableView *)tableView IndexPathRow:(NSInteger)row;
- (void)setXLBookListModelHXJListCellValue:(TopBookHXGModel *)topBookHXGModel;
@end

NS_ASSUME_NONNULL_END
