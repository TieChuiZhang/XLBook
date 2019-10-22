//
//  LeeLabel.h
//  中包Bind端
//
//  Created by Lee on 2018/3/21.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    VerticalAlignmentTop=0,
    VerticalAlignmentMiddle,//default
    VerticalAlignmentBottom,
    
}VerticalAlignment;

@interface LeeLabel : UILabel
{
@private
    VerticalAlignment _verticalAlignment;
}

@property(nonatomic)VerticalAlignment verticalAlignment;





@end
