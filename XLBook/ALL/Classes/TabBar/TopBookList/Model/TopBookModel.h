//
//  TopBookModel.h
//  XLBook
//
//  Created by Lee on 2019/10/21.
//  Copyright © 2019 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface TopBookModel : NSObject
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
- (void)getAllClassify:(NSString *)urlString;

- (void)changeGroupAtIndex:(NSInteger)index needScroll:(BOOL)need;

- (void)clickItemAtIndexPath:(NSIndexPath *)indexPath;

- (void)startSearch;
@end

NS_ASSUME_NONNULL_END
