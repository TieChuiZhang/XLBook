//
//  MyBookCell.h
//  XLBook
//
//  Created by Lee on 2019/11/5.
//  Copyright © 2019 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopBookOneBookDModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyBookCell : UITableViewCell
- (void)setXLBookMyBookModelWithCellValue:(TopBookOneBookDModel *)topBookOneBookDModel;
+ (instancetype)xlBookMyBookCellWithTableView:(UITableView *)tableView IndexPathRow:(NSInteger)row;
@end

NS_ASSUME_NONNULL_END
