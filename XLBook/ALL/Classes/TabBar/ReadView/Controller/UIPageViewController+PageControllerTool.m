//
//  UIPageViewController+PageControllerTool.m
//  XLBook
//
//  Created by Lee on 2019/11/8.
//  Copyright © 2019 Lee. All rights reserved.
//

#import "UIPageViewController+PageControllerTool.h"

@implementation UIPageViewController (PageControllerTool)



-(BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
        return NO;
    }
    return YES;
}
@end
