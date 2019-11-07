//
//  TopBookOneBookHXJCell.h
//  XLBook
//
//  Created by Lee on 2019/10/24.
//  Copyright © 2019 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopBookOneBookDModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface TopBookOneBookHXJCell : UITableViewCell
+ (instancetype)xlTopBookOneBookHXJCellWithTableView:(UITableView *)tableView IndexPathRow:(NSInteger)row;
- (void)setXLBookOneBookDHXJModelCellValue:(TopBookOneBookDModel *)xlBookOneBookDMLModel ArrayWithHXGDataArray:(NSArray *)dataArray;
@property (nonatomic, copy) void(^selectCell)(NSString *bookID);
@end

NS_ASSUME_NONNULL_END
