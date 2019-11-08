//
//  XXBookBodyModel+WCTTableCoding.h
//  Novel
//
//  Created by xx on 2018/9/5.
//  Copyright © 2018年 th. All rights reserved.
//

#import "XLBookReadZJLBModel.h"
#import <WCDB/WCDB.h>

@interface XLBookReadZJNRModel (WCTTableCoding) <WCTTableCoding>
WCDB_PROPERTY(cname)
WCDB_PROPERTY(content)
WCDB_PROPERTY(id)
WCDB_PROPERTY(cid)

@end
