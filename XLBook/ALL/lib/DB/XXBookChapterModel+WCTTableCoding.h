//
//  XXBookChapterModel+WCTTableCoding.h
//  Novel
//
//  Created by xx on 2018/9/4.
//  Copyright © 2018年 th. All rights reserved.
//

#import "XLBookReadZJLBModel.h"
#import <WCDB/WCDB.h>

@interface XLBookReadZJLBModel (WCTTableCoding) <WCTTableCoding>

WCDB_PROPERTY(id)
WCDB_PROPERTY(name)
@end
