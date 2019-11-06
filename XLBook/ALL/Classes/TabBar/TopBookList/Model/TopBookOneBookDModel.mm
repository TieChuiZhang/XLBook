//
//  TopBookOneBookDModel.m
//  XLBook
//
//  Created by Lee on 2019/10/22.
//  Copyright © 2019 Lee. All rights reserved.
//

#import "TopBookOneBookDModel.h"
#import <WCDB/WCDB.h>
@implementation TopBookOneBookDModel
WCDB_IMPLEMENTATION(TopBookOneBookDModel)
WCDB_SYNTHESIZE(TopBookOneBookDModel, Id)
WCDB_SYNTHESIZE(TopBookOneBookDModel, Name)
WCDB_SYNTHESIZE(TopBookOneBookDModel, Author)
WCDB_SYNTHESIZE(TopBookOneBookDModel, Img)
WCDB_SYNTHESIZE(TopBookOneBookDModel, Desc)
WCDB_SYNTHESIZE(TopBookOneBookDModel, page)
//WCDB_SYNTHESIZE(TopBookOneBookDModel, updated)
WCDB_SYNTHESIZE(TopBookOneBookDModel, chapter)
WCDB_SYNTHESIZE(TopBookOneBookDModel, LastChapter)
WCDB_SYNTHESIZE(TopBookOneBookDModel, addTime)
@end
