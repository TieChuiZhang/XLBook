//
//  XLTopOneBookNav.h
//  XLBook
//
//  Created by Lee on 2019/10/22.
//  Copyright © 2019 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XLTopOneBookNav;
NS_ASSUME_NONNULL_BEGIN
@protocol XLTopOneBookNavDelegate <NSObject>
- (void)dissMissViewControllerCurrentView:(XLTopOneBookNav *)topEView bySender:(NSInteger )sender;
@end
@interface XLTopOneBookNav : UIView
@property (nonatomic, weak) id<XLTopOneBookNavDelegate> delegate;
@property (nonatomic,strong)UIView *navV;
@property (nonatomic,strong)UILabel *navLabel;
@property (nonatomic,assign)BOOL isScrollUp;
@property (nonatomic,strong)UIButton *camareBtn;
@property (nonatomic,strong)UIButton *backBtn;
@end

NS_ASSUME_NONNULL_END
