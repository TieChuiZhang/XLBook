//
//  TopBookListModel.h
//  XLBook
//
//  Created by Lee on 2019/10/21.
//  Copyright © 2019 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TopBookListModel : NSObject
/**书籍id  */
@property (nonatomic, copy) NSString *Id;
/**书名  */
@property (nonatomic, copy) NSString *Name;
/**书籍作者  */
@property (nonatomic, copy) NSString *Author;
/**图片链接  */
@property (nonatomic, copy) NSString *Img;
/**书籍简介  */
@property (nonatomic, copy) NSString *Desc;
/**书籍类型  */
@property (nonatomic, copy) NSString *CName;
/**书籍评分  */
@property (nonatomic, copy) NSString *Score;
@end

NS_ASSUME_NONNULL_END
