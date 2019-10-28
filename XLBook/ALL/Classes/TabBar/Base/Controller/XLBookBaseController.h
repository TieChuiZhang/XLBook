//
//  XLBookBaseController.h
//  XLBook
//
//  Created by Lee on 2019/10/21.
//  Copyright © 2019 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XLBookBaseController : UIViewController
@property (nonatomic, copy) NSDictionary *dlListDic;
/**
 创建UI
 */
- (void)setupViews;
@end

NS_ASSUME_NONNULL_END
