//
//  TopBookOneBookHXJListView.h
//  XLBook
//
//  Created by Lee on 2019/10/23.
//  Copyright © 2019 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopBookHXGModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TopBookOneBookHXJListView : UIView
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataArray;
@end

NS_ASSUME_NONNULL_END
