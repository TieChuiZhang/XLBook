//
//  XLBookReadZJLBModel.m
//  XLBook
//
//  Created by Lee on 2019/10/24.
//  Copyright © 2019 Lee. All rights reserved.
//

#import "XLBookReadZJLBModel.h"
#import <WCDB/WCDB.h>
@implementation XLBookReadZJLBModel
WCDB_IMPLEMENTATION(XLBookReadZJLBModel)
WCDB_SYNTHESIZE(XLBookReadZJLBModel, id)
WCDB_SYNTHESIZE(XLBookReadZJLBModel, name)
@end


@implementation XLBookReadZJNRModel

WCDB_IMPLEMENTATION(XLBookReadZJNRModel)
WCDB_SYNTHESIZE(XLBookReadZJNRModel, id)
WCDB_SYNTHESIZE(XLBookReadZJNRModel, name)
WCDB_SYNTHESIZE(XLBookReadZJNRModel, cname)
WCDB_SYNTHESIZE(XLBookReadZJNRModel, cid)
WCDB_SYNTHESIZE(XLBookReadZJNRModel, content)
WCDB_PRIMARY(XLBookReadZJNRModel, cid)
@end

