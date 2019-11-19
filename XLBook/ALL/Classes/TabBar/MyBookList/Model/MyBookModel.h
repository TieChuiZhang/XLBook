//
//  MyBookModel.h
//  XLBook
//
//  Created by Lee on 2019/11/11.
//  Copyright © 2019 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, kDayMode) {
    kDayMode_light = 1, //白天
    kDayMode_night //黑夜
};

typedef NS_ENUM(NSInteger, kBgColor) {
    kBgColor_default = 1, //默认
    kBgColor_ink,
    kBgColor_flax,
    kBgColor_green,
    kBgColor_peach,
    kBgColor_Black, //黑色
};

typedef NS_ENUM(NSInteger, kTransitionStyle) {
    kTransitionStyle_Scroll,//左右翻页
    kTransitionStyle_PageCurl, //模拟翻页
    kTransitionStyle_default, //默认无效果
};

typedef NS_ENUM(NSInteger, kbookBodyStatus) {
    kbookBodyStatus_success,
    kbookBodyStatus_error,
    kbookBodyStatus_loading
};


@interface MyBookModel : NSObject

@end
NS_ASSUME_NONNULL_END

@interface BookSettingModel : BaseModel

@property (nonatomic, assign) NSUInteger font;

@property (nonatomic, assign) kBgColor bgColor;

@property (nonatomic, assign) kDayMode dayMode;

/* 点击全屏翻下页 */
@property (nonatomic, assign) BOOL isFullTapNext;

@property (nonatomic, assign) kTransitionStyle transitionStyle;

/** 是否横屏 */
@property (nonatomic, assign) BOOL isLandspace;
@end
