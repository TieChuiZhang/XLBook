//
//  TopBookModel.h
//  XLBook
//
//  Created by Lee on 2019/10/21.
//  Copyright © 2019 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TopBookOneBookDModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TopBookModel : NSObject
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) TopBookOneBookDModel *topBookOneBookDModel;
- (void)getAllClassify:(NSString *)urlString;

- (void)getOneBookClassify:(NSString *)urlString;

- (void)reloadData;
@end

NS_ASSUME_NONNULL_END
