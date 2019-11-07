//
//  TopBookOneBookHXJListView.m
//  XLBook
//
//  Created by Lee on 2019/10/23.
//  Copyright © 2019 Lee. All rights reserved.
//

#import "TopBookOneBookHXJListView.h"
#import "TopBookOneBookHXJListCell.h"
@interface TopBookOneBookHXJListView ()<UITableViewDataSource,UITableViewDelegate>
@end
@implementation TopBookOneBookHXJListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tableView];
       
    }
    return self;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.layer.cornerRadius = 2;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (void)layoutSubviews
{
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(self).offset(5);
         make.left.equalTo(self).offset(10);
         make.right.equalTo(self).offset(-10);
         make.bottom.equalTo(self).offset(0);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TopBookOneBookHXJListCell *cell = [TopBookOneBookHXJListCell xlTopBookOneBookHXJListCellWithTableView:tableView IndexPathRow:indexPath.row];
    [cell setXLBookListModelHXJListCellValue:self.dataArray[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(topBookHXJListCellTapInCellWithView:ModelWithCellModel:byCellIndexRow:)]) {
        [self.delegate topBookHXJListCellTapInCellWithView:self ModelWithCellModel:self.dataArray[indexPath.row] byCellIndexRow:indexPath.row];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 40)];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, self.tableView.frame.size.width, 20)];
        lab.font = [UIFont boldSystemFontOfSize:14];
        lab.text = [NSString stringWithFormat:@"作者还写过"];
        [header addSubview:lab];
        return header;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

@end
