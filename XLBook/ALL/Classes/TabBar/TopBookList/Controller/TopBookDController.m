//
//  TopBookDController.m
//  XLBook
//
//  Created by Lee on 2019/10/21.
//  Copyright © 2019 Lee. All rights reserved.
//

#import "TopBookDController.h"
#import "TopBookModel.h"
@interface TopBookDController ()
@property (nonatomic, copy) NSString *listUrl;
@property (nonatomic, strong) TopBookModel *topBookModel;
@end

@implementation TopBookDController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.topBookModel getAllClassify:[NSString stringWithFormat:@"%@week/5.html",self.listUrl]];
}

- (TopBookModel *)topBookModel
{
    if (!_topBookModel) {
        _topBookModel = [TopBookModel new];
    }
    return _topBookModel;
}
@end
