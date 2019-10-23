//
//  TopBookOneBookTJView.h
//  XLBook
//
//  Created by Lee on 2019/10/23.
//  Copyright © 2019 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopBookOneBookDModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TopBookOneBookTJView : UIView
@property (nonatomic, strong) TopBookOneBookDModel *topBookOneBookDModel;
- (void)setXLBookOne:(TopBookOneBookDModel *)xlBookOneBookDMLModel;
/**图片链接  */
@property (nonatomic, copy) UIImageView *Img;
/**书名  */
@property (nonatomic, copy) UILabel *Name;
@end

NS_ASSUME_NONNULL_END
