//
//  TopBookOneBookTJCell.m
//  XLBook
//
//  Created by Lee on 2019/10/23.
//  Copyright © 2019 Lee. All rights reserved.
//

#import "TopBookOneBookTJCell.h"
#import "TopBookOneBookHXJListView.h"
@interface TopBookOneBookTJCell()
@property (nonatomic, strong) TopBookOneBookHXJListView *listView;
@end
@implementation TopBookOneBookTJCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
        [self addSubview:self.listView];
        //[self updateConstraintsForView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_listView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(self).offset(10);
         make.left.equalTo(self).offset(0);
         make.right.equalTo(self).offset(0);
         make.bottom.equalTo(self).offset(0);
    }];
}

- (TopBookOneBookHXJListView *)listView
{
    if (!_listView) {
        _listView = [TopBookOneBookHXJListView new];
    }
    return _listView;
}


+ (instancetype)xlTopBookOneBookTJCellWithTableView:(UITableView *)tableView IndexPathRow:(NSInteger)row{
    static NSString *ID = @"TopBookOneBookTJCell";
    TopBookOneBookTJCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TopBookOneBookTJCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setXLBookOneBookDTJModelCellValue:(TopBookOneBookDModel *)xlBookOneBookDMLModel ArrayWithHXGDataArray:(NSArray *)dataArray{
//    if (xlBookOneBookDMLModel.SameUserBooks.count == 0) {
//        self.height = YES;
//    }
    self.listView.dataArray = dataArray;
    [self.listView.tableView reloadData];
}

//- (void)setXLBookOneBookDTJModelCellValue:(TopBookHXGModel *)topBookHXGModel{
//    self.listView.topBookHXGModel = topBookHXGModel;
//    [self.listView.tableView reloadData];
//}

@end
