//
//  XXDatabase.mm
//  Novel
//
//  Created by xx on 2018/9/4.
//  Copyright © 2018年 th. All rights reserved.
//

#import "XXDatabase+WCTTableCoding.h"
#import "XXDatabase.h"
#import <WCDB/WCDB.h>
#import "XXBookModel+WCTTableCoding.h"
#import "XXBookChapterModel+WCTTableCoding.h"
#import "XXBookBodyModel+WCTTableCoding.h"


@interface XXDatabase ()

@property (nonatomic, strong) WCTDatabase *database;

@end

@implementation XXDatabase


+ (instancetype)shareInstance {
    
    static XXDatabase * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XXDatabase alloc] init];
    });
    
    return instance;
}


- (WCTDatabase *)database {
    if (_database) return _database;
    _database = [[WCTDatabase alloc] initWithPath:[NSString getDBPath]];
    if ([_database canOpen]) {
        if ([_database isOpened]) {
            if ([_database isTableExists:kBookTableName]) {
                NSLog(@"kBookTableName表已经存在");
            } else {
                NSLog(@"创建kBookTableName表");
                [_database createTableAndIndexesOfName:kBookTableName withClass:TopBookOneBookDModel.class];
            }
        }
    }
    return _database;
}


//查找书架是否存在某本书
- (TopBookOneBookDModel *)getBookWithId:(NSString *)id {
    TopBookOneBookDModel *object = [self.database getOneObjectOfClass:TopBookOneBookDModel.class fromTable:kBookTableName where:TopBookOneBookDModel.Id == id];
    return object;
}


//插入书架
- (BOOL)insertBook:(TopBookOneBookDModel *)object {
    NSDate *date = [NSDate date];
    NSTimeInterval interval = [date timeIntervalSince1970]*1000;
    object.addTime = interval;
    return [self.database insertObject:object into:kBookTableName];
}


//获取书架列表
- (NSArray <TopBookOneBookDModel *>*)getBooks {
    return [self.database getObjectsOfClass:TopBookOneBookDModel.class fromTable:kBookTableName orderBy:TopBookOneBookDModel.addTime.order(WCTOrderedDescending)];
}


//更新书本
- (BOOL)updateBook:(TopBookOneBookDModel *)object {
    return [self.database updateRowsInTable:kBookTableName onProperties:{TopBookOneBookDModel.Id, TopBookOneBookDModel.chapter, TopBookOneBookDModel.page, TopBookOneBookDModel.LastChapter} withObject:object where:TopBookOneBookDModel.Id == object.Id];
}


//删除某本书籍
- (BOOL)deleteBookWithId:(NSString *)id {
    return [self.database deleteObjectsFromTable:kBookTableName where:TopBookOneBookDModel.Id == id];
}


//插入章节内容
//目前存储章节内容的时候是根据书籍id存储 只能存一章 需要更改
- (BOOL)insertBookBody:(XLBookReadZJLBModel *)object bookId:(NSString *)bookId {
    NSString *name = [self getTableNameWithType:kDataTablaNameType_body name:bookId];
    [self createTableName:name class:XLBookReadZJNRModel.class];
    return [self.database insertObject:object into:name];
}


//查询章节内容
- (XLBookReadZJNRModel *)getBookBodyWithLink:(NSString *)link bookId:(NSString *)bookId {
    NSString *name = [self getTableNameWithType:kDataTablaNameType_body name:bookId];
    [self createTableName:name class:XLBookReadZJNRModel.class];
    return [self.database getOneObjectOfClass:XLBookReadZJNRModel.class fromTable:name where:XLBookReadZJNRModel.cid == link];
}


//插入小说目录
- (BOOL)insertChapters:(NSArray <XLBookReadZJLBModel *>*)objects summaryId:(NSString *)summaryId {
    NSString *name = [self getTableNameWithType:kDataTablaNameType_chapter name:summaryId];
    [self createTableName:name class:XLBookReadZJLBModel.class];
    return [self.database insertObjects:objects into:name];
}


//获取小说目录
- (NSArray <XLBookReadZJLBModel *>*)getChaptersWithSummaryId:(NSString *)summaryId {
    NSString *name = [self getTableNameWithType:kDataTablaNameType_chapter name:summaryId];
    [self createTableName:name class:XLBookReadZJLBModel.class];
    return [self.database getAllObjectsOfClass:XLBookReadZJLBModel.class fromTable:name];
}


//清空小说目录
- (BOOL)deleteChaptersWithSummaryId:(NSString *)summaryId {
    return [self.database deleteAllObjectsFromTable:[self getTableNameWithType:kDataTablaNameType_chapter name:summaryId]];
}


//创建表
- (BOOL)createTableName:(NSString *)name class:(Class)clasz {
    if (![self.database isTableExists:name]) {
        return [self.database createTableAndIndexesOfName:name withClass:clasz];
    }else{
        return NO;
    }
}


//目录用源id拼接区分，内容表直接使用book id 拼接 这样就能让内容表有唯一性，使用link作为主键
- (NSString *)getTableNameWithType:(kDataTablaNameType)nameType name:(NSString *)name {
    if (nameType == kDataTablaNameType_body) {
        static NSString *id = @"XXBody";
        name = NSStringFormat(@"%@%@", id, name);
    }
    else if (nameType == kDataTablaNameType_chapter) {
        static NSString *id = @"XXChapter";
        name = NSStringFormat(@"%@%@", id, name);
    }
    return name;
}


//删除表
- (BOOL)dropTableName:(NSString *)tableName {
    return [self.database dropTableOfName:tableName];
}

@end
