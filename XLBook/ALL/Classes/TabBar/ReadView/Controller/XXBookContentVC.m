//
//  XXBookContentVC.m
//  Novel
//
//  Created by app on 2018/1/25.
//  Copyright © 2018年 th. All rights reserved.
//

#import "XXBookContentVC.h"
#import "BatteryView.h"
#import <YYKit/NSAttributedString+YYText.h>
#import "UIImage+Add.h"
@interface XXBookContentVC ()

@property (nonatomic, strong) YYLabel *contentLabel;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) BatteryView *batteryView;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UILabel *pageLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *statusLabel;

@end

@implementation XXBookContentVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //背景颜色的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeBgColorWithNotifiction:) name:kNotificationWithChangeBg object:nil];
    [self bgColorWithManager:TopBookModelManager.bgColor];
    //self.view.backgroundColor = [UIColor colorWithHexString:@"F9EACE"];
}


- (void)changeBgColorWithNotifiction:(NSNotification *)sender {
    kBgColor bgoColor = [[sender userInfo][kNotificationWithChangeBg] integerValue];
    [self changeBgColorWithIndex:bgoColor];
}


- (void)bgColorWithManager:(NSInteger )index{
    NSString *bgImageName;
    switch (TopBookModelManager.bgColor) {
        case 1:
            bgImageName = @"def_bg_375x667_";
            break;
        case 2:
            bgImageName = @"ink_bg_375x667_";
            break;
        case 3:
            bgImageName = @"flax_bg_375x667_";
            break;
        case 4:
            bgImageName = @"green_bg_375x667_";
            break;
        case 5:
            bgImageName = @"peach_bg_375x667_";
            break;
        case 6:
            bgImageName = @"coffee_mode_bg";
            break;
        default:
            break;
    }
    UIImage *bgImage = UIImageName(bgImageName);
    self.view.layer.contents = (__bridge id _Nullable)(bgImage.CGImage);
}


#pragma mark - 改变背景颜色
- (void)changeBgColorWithIndex:(kBgColor)bgoColor {

    NSString *bgImageName;
    switch (TopBookModelManager.bgColor) {
        case kBgColor_default:
            bgImageName = @"def_bg_375x667_";
            break;
        case kBgColor_ink:
            bgImageName = @"ink_bg_375x667_";
            break;
        case kBgColor_flax:
            bgImageName = @"flax_bg_375x667_";
            break;
        case kBgColor_green:
            bgImageName = @"green_bg_375x667_";
            break;
        case kBgColor_peach:
            bgImageName = @"peach_bg_375x667_";
            break;
        case kBgColor_Black:
            bgImageName = @"coffee_mode_bg";
            break;
        default:
            break;
    }

    if (TopBookModelManager.dayMode == kDayMode_night) {
        UIColor *color = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
        NSMutableAttributedString *text = (NSMutableAttributedString *)self.contentLabel.attributedText;
        text.color = color;
        self.contentLabel.attributedText = text;

        self.titleLabel.textColor = color;
        self.timeLabel.textColor = color;
        self.pageLabel.textColor = color;
    } else {

        NSMutableAttributedString *text = (NSMutableAttributedString *)self.contentLabel.attributedText;
        text.color = kblackColor;
        self.contentLabel.attributedText = text;

        self.titleLabel.textColor = knormalColor;
        self.timeLabel.textColor = knormalColor;
        self.pageLabel.textColor = knormalColor;
    }

    UIImage *bgImage = UIImageName(bgImageName);
    self.view.layer.contents = (__bridge id _Nullable)(bgImage.CGImage);

    self.batteryView.backgroundColor = [bgImage mostColor];
    [self.batteryView setNeedsDisplay];
}

#pragma mark - setter

//- (void)setBookModel:(XXBookChapterModel *)bookModel {
//    _bookModel = bookModel;
//    self.titleLabel.text = bookModel.title;
//
//    if (bookModel.status == kbookBodyStatus_loading) {
//        self.contentLabel.hidden = YES;
//        self.statusLabel.text = @"加载中...";
//    }
//    else if (bookModel.status == kbookBodyStatus_error) {
//        self.contentLabel.hidden = YES;
//        self.statusLabel.text = bookModel.errorString;
//    }
//    else {
//        _statusLabel.hidden = YES;
//        self.contentLabel.hidden = NO;
//    }
//}

- (void)setXlBookReadZJNRModel:(XLBookReadZJNRModel *)xlBookReadZJNRModel
{
    _xlBookReadZJNRModel = xlBookReadZJNRModel;
    self.titleLabel.text = xlBookReadZJNRModel.cname;
    [self pagingWithBounds:kReadingFrame withFont:fontSize(18) andChapter:xlBookReadZJNRModel];
    
    
//    if (bookModel.status == kbookBodyStatus_loading) {
//            self.contentLabel.hidden = YES;
//            self.statusLabel.text = @"加载中...";
//        }
//        else if (bookModel.status == kbookBodyStatus_error) {
//            self.contentLabel.hidden = YES;
//            self.statusLabel.text = bookModel.errorString;
//        }
//        else {
//            _statusLabel.hidden = YES;
//            self.contentLabel.hidden = NO;
//        }
}

- (void)setPage:(NSUInteger)page {
    _page = page;
    self.contentLabel.attributedText = [self getStringWithpage:page nsadna:_xlBookReadZJNRModel];
    
    self.timeLabel.text = [[DateTools shareDate] getTimeString];
    self.pageLabel.text = [NSString stringWithFormat:@"%zd/%zd", page+1, _xlBookReadZJNRModel.pageCount];
    //[self changeBgColorWithIndex:kReadingManager.bgColor];
}


- (void)pagingWithBounds:(CGRect)bounds withFont:(UIFont *)font andChapter:(XLBookReadZJNRModel *)xlBookReadZJNRModel {
    
    xlBookReadZJNRModel.pageDatas = @[].mutableCopy;
    
    if (!xlBookReadZJNRModel.content) {
        xlBookReadZJNRModel.content = @"";
    }
    
    NSString *body = [TopBookModelManager adjustParagraphFormat:xlBookReadZJNRModel.content];
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:body];
    attr.font = font;
    attr.color = kblackColor;
    
    // 设置label的行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:AdaWidth(9)];
    [attr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, body.length)];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef) attr);
    
    CGPathRef path = CGPathCreateWithRect(bounds, NULL);
    
    CFRange range = CFRangeMake(0, 0);
    
    NSUInteger rangeOffset = 0;
    
    do {
        CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(rangeOffset, 0), path, NULL);
        
        range = CTFrameGetVisibleStringRange(frame);
        
        rangeOffset += range.length;
        
        //range.location
        [xlBookReadZJNRModel.pageDatas addObject:@(range.location)];
        
        if (frame) {
            CFRelease(frame);
        }
    } while (range.location + range.length < attr.length);
    
    if (path) {
        CFRelease(path);
    }
    
    if (frameSetter) {
        CFRelease(frameSetter);
    }
    
    xlBookReadZJNRModel.pageCount = xlBookReadZJNRModel.pageDatas.count;
    
    xlBookReadZJNRModel.attributedString = attr;
}

- (NSAttributedString *)getStringWithpage:(NSInteger)page nsadna:(XLBookReadZJNRModel *)model {
    
    if (page < model.pageDatas.count) {
        
        NSUInteger loc = [model.pageDatas[page] integerValue];
        
        NSUInteger len = 0;
        
        if (page == model.pageDatas.count - 1) {
            len = model.attributedString.length - loc;
        } else {
            len = [model.pageDatas[page + 1] integerValue] - loc;
        }
        
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:[model.attributedString attributedSubstringFromRange:NSMakeRange(loc, len)]];
        
        if (TopBookModelManager.bgColor == 5) {
                  text.color = kwhiteColor;
              } else {
                  text.color = kblackColor;
              }
        return text;
    }
    return [[NSAttributedString alloc] init];
}

#pragma mark - getter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel newLabel:@"" andTextColor:knormalColor andFont:fontSize(13)];
        [self.view addSubview:_titleLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            CGFloat top = 0;
            if (xx_iPhoneX) {
                top = kSafeAreaInsets.safeAreaInsets.top;
            }
            make.top.mas_equalTo(self.view.mas_top).offset(top);
            make.left.mas_equalTo(self.view.mas_left).offset(kReadSpaceX);
            make.right.mas_equalTo(self.view.mas_right).offset(-kReadSpaceX);
            make.height.mas_equalTo(kReadingTopH);
        }];
    }
    return _titleLabel;
}


- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [UILabel newLabel:@"" andTextColor:kblackColor andFont:kFont_Zhong(16)];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_statusLabel];
        
        [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(44);
            make.left.mas_equalTo(self.view.mas_left).offset(kReadSpaceX);
            make.right.mas_equalTo(self.view.mas_right).offset(-kReadSpaceX);
        }];
    }
    return _statusLabel;
}


- (YYLabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[YYLabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:15];
        [_contentLabel setTextVerticalAlignment:YYTextVerticalAlignmentTop];//居上对齐
        [self.view addSubview:_contentLabel];
        
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom);
            make.left.mas_equalTo(self.view.mas_left).offset(kReadSpaceX);
            make.right.mas_equalTo(self.view.mas_right).offset(-kReadSpaceX);
            make.bottom.mas_equalTo(self.bottomView.mas_top);
        }];
    }
    return _contentLabel;
}


- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        [self.view addSubview:_bottomView];
        
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.bottom.mas_equalTo(self.view.mas_bottom).offset(-kSafeAreaInsets.safeAreaInsets.bottom);
            make.height.mas_equalTo(kReadingBottomH);
        }];
    }
    return _bottomView;
}

- (BatteryView *)batteryView {
    if (!_batteryView) {
        
        _batteryView = [[BatteryView alloc] init];
        _batteryView.fillColor = [UIColor colorWithRed:0.35 green:0.31 blue:0.22 alpha:1.00];
        [self.bottomView addSubview:_batteryView];
        
        [_batteryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.bottomView);
            make.left.mas_equalTo(self.bottomView.mas_left).offset(kReadSpaceX);
            make.size.mas_equalTo(CGSizeMake(AdaWidth(25), AdaWidth(10)));
        }];
    }
    return _batteryView;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel newLabel:@"" andTextColor:knormalColor andFont:fontSize(12)];
        [self.bottomView addSubview:_timeLabel];
        
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.batteryView);
            make.left.mas_equalTo(self.batteryView.mas_right).offset(AdaWidth(8));
        }];
        
    }
    return _timeLabel;
}

- (UILabel *)pageLabel {
    if (!_pageLabel) {
        _pageLabel = [UILabel newLabel:@"" andTextColor:knormalColor andFont:fontSize(12)];
        _pageLabel.textAlignment = NSTextAlignmentRight;
        [self.bottomView addSubview:_pageLabel];
        
        [_pageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.batteryView);
            make.left.mas_equalTo(self.timeLabel.mas_right).offset(AdaWidth(12.f));
            make.right.mas_equalTo(self.bottomView.mas_right).offset(-kReadSpaceX);
        }];
    }
    return _pageLabel;
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
