//
//  XLTopBookOneHeaderView.h
//  XLBook
//
//  Created by Lee on 2019/10/22.
//  Copyright © 2019 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopBookOneBookDModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface XLTopBookOneHeaderView : UIView
- (void)setXLBookOneBookWithSXTableView:(UITableView *)tableView HeaderValue:(TopBookOneBookDModel *)topBookOneBookDModel;
@end

NS_ASSUME_NONNULL_END
