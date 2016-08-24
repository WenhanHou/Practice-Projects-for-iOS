//
//  DBManager.m
//  
//
//  Created by Wenhan on 2/4/16.
//
//
#import <Foundation/Foundation.h>
#import "DBManager.h"


#define DefaultDBName @"userInfo.sqlite"

#define debugMethod(...) NSLog((@"In %s,%s [Line %d] "), __PRETTY_FUNCTION__,__FILE__,__LINE__,##__VA_ARGS__)

static FMDatabase *shareDataBase = nil;

@implementation DBManager


+ (FMDatabase *)createDataBase {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareDataBase = [FMDatabase databaseWithPath:dataBasePath];
    });
    return shareDataBase;
}

/**
 判断数据库中表是否存在
 **/
+ (BOOL) isTableExist:(NSString *)tableName
{
    FMResultSet *rs = [shareDataBase executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
    while ([rs next])
    {
        // just print out what we've got in a number of formats.
        NSInteger count = [rs intForColumn:@"count"];
       // NSLog(@"%@ isOK %d", tableName,count);
        
        if (0 == count)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    
    return NO;
}

/**
 创建表
 **/
+ (BOOL)createTable {
    debugMethod();
    NSLog(@"%@",dataBasePath);
    if (1){
        {
            shareDataBase = [DBManager createDataBase];
            if ([shareDataBase open]) {
                if (![DBManager isTableExist:@"message_table"]) {
                    NSString *sql = @"CREATE TABLE \"message_table\" (\"user_id\" TEXT PRIMARY KEY  NOT NULL  check(typeof(\"message_id\") = 'text') , \"lat\" TEXT, \"log\" TEXT, \"desc\" TEXT)";
                    NSLog(@"成功 ");
                    [shareDataBase executeUpdate:sql];
                }
                [shareDataBase close];
            }
        }
    }
    return YES;
}

/**
 关闭数据库
 **/
+ (void)closeDataBase {
    if(![shareDataBase close]) {
        NSLog(@"数据库关闭异常，请检查");
        return;
    }
}

/**
 删除数据库
 **/
+ (void)deleteDataBase {
    if (shareDataBase != nil) {
        //这里进行数据库表的删除工作
    }
}

+ (BOOL) saveOrUpdataMessage:(UserHistory *)user
{
    BOOL isOk = NO;
    shareDataBase = [DBManager createDataBase];
    if ([shareDataBase open]) {
        isOk = [shareDataBase executeUpdate:
                @"INSERT INTO \"message_table\" (\"user_id\",\"lat\",\"log\",\"desc\") VALUES(?,?,?,?)",user.userId, user.lat, user.log, user.descrition];
        [shareDataBase close];
    }
    return isOk;
}

+ (UserHistory *) selectMessageByMessageId:(NSString*)userId
{
    UserHistory *uh = nil;
    shareDataBase = [DBManager createDataBase];
    if ([shareDataBase open]) {
        FMResultSet *s = [shareDataBase executeQuery:[NSString stringWithFormat:@"SELECT * FROM \"message_table\" WHERE \"user_id\" = '%@'",userId]];
        if ([s next]) {
            uh = [[UserHistory alloc] init];
            uh.userId = [s stringForColumn:@"user_id"];
            uh.lat = [s stringForColumn:@"lat"];
            uh.log = [s stringForColumn:@"log"];
            uh.descrition = [s stringForColumn:@"desc"];
            
        }
        [shareDataBase close];
    }
    return uh;
}

@end
