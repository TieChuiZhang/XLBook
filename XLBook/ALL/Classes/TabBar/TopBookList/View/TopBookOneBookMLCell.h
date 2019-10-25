//
//  TopBookOneBookMLCell.h
//  XLBook
//
//  Created by Lee on 2019/10/23.
//  Copyright © 2019 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopBookOneBookDModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TopBookOneBookMLCell : UITableViewCell
+ (instancetype)xlTopBookOneBookMLCellWithTableView:(UITableView *)tableView IndexPathRow:(NSInteger)row;
- (void)setXLBookOneBookDMLModelCellValue:(TopBookOneBookDModel *)xlBookOneBookDMLModel;
@end

NS_ASSUME_NONNULL_END
