//
//  TopBookOneBookTJCell.h
//  XLBook
//
//  Created by Lee on 2019/10/23.
//  Copyright © 2019 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopBookOneBookDModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TopBookOneBookTJCell : UITableViewCell
+ (instancetype)xlTopBookOneBookTJCellWithTableView:(UITableView *)tableView IndexPathRow:(NSInteger)row;
- (void)setXLBookOneBookDTJModelCellValue:(TopBookOneBookDModel *)xlBookOneBookDMLModel ArrayWithHXGDataArray:(NSArray *)dataArray;
@property (nonatomic, copy) void(^selectItem)(NSString *bookID);
@end

NS_ASSUME_NONNULL_END
