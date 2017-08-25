//
//  BaseDB.m
//  JudgePlants
//
//  Created by itm on 2017/5/24.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "BaseDB.h"

@implementation BaseDB

- (NSString *)filePathPlant {
    NSString *path =[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"tool.sqlite"];
    return path;
}

- (void)createTable:(NSString *)sql {
    
    sqlite3 *sqlite = nil;
    //打开数据库
    if (sqlite3_open([self.filePathPlant UTF8String], &sqlite) != SQLITE_OK) {
        NSLog(@"打开数据库失败");
        sqlite3_close(sqlite);
        return;
    }
    
    //执行创建表SQL语句
    char *errmsg = nil;
    if (sqlite3_exec(sqlite, [sql UTF8String], NULL, NULL, &errmsg) != SQLITE_OK) {
        NSLog(@"创建表失败：%s",errmsg);
        sqlite3_close(sqlite);
    }
    
    //关闭数据库
    sqlite3_close(sqlite);
    
}

-(BOOL)checkTableName:(NSString *)name{
    char *err = nil;
    sqlite3 *sqlite = nil;
    //打开数据库
    if (sqlite3_open([self.filePathPlant UTF8String], &sqlite) != SQLITE_OK) {
        NSLog(@"打开数据库失败");
        sqlite3_close(sqlite);
        return NO;
    }
    
    NSString *sql = [NSString stringWithFormat:@"SELECT COUNT(*) FROM sqlite_master where type='table' and name='%@';",name];
    
    const char *sql_stmt = [sql UTF8String];
    if(sqlite3_exec(sqlite, sql_stmt, NULL, NULL, &err) == 1){
        return YES;
    }else{
        return NO;
    }
}


/**
 * 接口描述：插入数据、删除数据、修改数据
 * 参数：  sql: SQL语句
 * 返回值：是否执行成功
 *
 */
// INSERT INTO User(username,password,email) values(?,?,?)
- (BOOL)dealData:(NSString *)sql paramsarray:(NSArray *)params {
    sqlite3 *sqlite = nil;
    sqlite3_stmt *stmt = nil;
    
    //打开数据库
    if (sqlite3_open([self.filePathPlant UTF8String], &sqlite) != SQLITE_OK) {
        NSLog(@"打开数据库失败");
        sqlite3_close(sqlite);
        return NO;
    }
    
    //编译SQL语句
    if (sqlite3_prepare_v2(sqlite, [sql UTF8String], -1, &stmt, NULL) != SQLITE_OK) {
        //NSLog(@"SQL语句编译失败");
        sqlite3_close(sqlite);
        return NO;
    }
    
    //绑定数据
    for (int i=0; i<params.count; i++) {
        NSString *value = [params objectAtIndex:i];
        sqlite3_bind_text(stmt, i+1, [value UTF8String], -1, NULL);
    }
    
    //执行SQL语句
    if(sqlite3_step(stmt) == SQLITE_ERROR) {
        NSLog(@"SQL语句执行失败");
        sqlite3_close(sqlite);
        return NO;
    }
    
    //关闭数据库
    sqlite3_finalize(stmt);
    sqlite3_close(sqlite);
    
    return YES;
}

/**
 *  接口描述：查询数据
 *  参数：  sql:SQL语句
 *  返回值：[
 [“字段值1”，“字段值2”，“字段值3”],
 [“字段值1”，“字段值2”，“字段值3”],
 [“字段值1”，“字段值2”，“字段值3”],
 ]
 */
//SELECT username,password,email FROM User
- (NSMutableArray *)selectData:(NSString *)sql columns:(int)number {
    sqlite3 *sqlite = nil;
    sqlite3_stmt *stmt = nil;
    //打开数据库
    if (sqlite3_open([self.filePathPlant UTF8String], &sqlite) != SQLITE_OK) {
        NSLog(@"打开数据库失败");
        sqlite3_close(sqlite);
        return nil;
    }
    
    //编译SQL语句
    if (sqlite3_prepare_v2(sqlite, [sql UTF8String], -1, &stmt, NULL) != SQLITE_OK) {
        //NSLog(@"SQL语句编译失败");
        sqlite3_close(sqlite);
        return nil;
    }
    
    //查询数据
    int result = sqlite3_step(stmt);
    NSMutableArray *data = [NSMutableArray array];
    while (result == SQLITE_ROW) {
        NSMutableArray *row = [NSMutableArray arrayWithCapacity:number];
        for (int i=0; i<number; i++) {
            char *columnText = (char *)sqlite3_column_text(stmt, i);
            
            if(columnText!=nil){
                NSString *string = [NSString stringWithUTF8String:columnText];
                [row addObject:string];
            }else{
                [row addObject:@""];
            }
        }
        [data addObject:row];
        
        result = sqlite3_step(stmt);
    }
    
    //关闭数据库
    sqlite3_finalize(stmt);
    sqlite3_close(sqlite);
    
    return data;
}

//执行插入事务语句
-(void)execInsertTransactionSql:(NSMutableArray *)transactionSql
{
    sqlite3 *sqlite = nil;
    sqlite3_stmt *statement = nil;
    
    //打开数据库
    if (sqlite3_open([self.filePathPlant UTF8String], &sqlite) != SQLITE_OK) {
        NSLog(@"打开数据库失败");
        sqlite3_close(sqlite);
        return;
    }
    
    //使用事务，提交插入sql语句
    @try{
        char *errorMsg;
        if (sqlite3_exec(sqlite, "BEGIN", NULL, NULL, &errorMsg)==SQLITE_OK)
        {
            NSLog(@"启动事务成功");
            sqlite3_free(errorMsg);
            for (int i = 0; i<transactionSql.count; i++)
            {
                if (sqlite3_prepare_v2(sqlite,[[transactionSql objectAtIndex:i] UTF8String], -1, &statement,NULL)==SQLITE_OK)
                {
                    if (sqlite3_step(statement)!=SQLITE_DONE) sqlite3_finalize(statement);
                }
            }
            if (sqlite3_exec(sqlite, "COMMIT", NULL, NULL, &errorMsg)==SQLITE_OK)   NSLog(@"提交事务成功");
            sqlite3_free(errorMsg);
        }
        else sqlite3_free(errorMsg);
    }
    @catch(NSException *e)
    {
        char *errorMsg;
        if (sqlite3_exec(sqlite, "ROLLBACK", NULL, NULL, &errorMsg)==SQLITE_OK)  NSLog(@"回滚事务成功");
        sqlite3_free(errorMsg);
    }
    @finally{
        //关闭数据库
        sqlite3_finalize(statement);
        sqlite3_close(sqlite);
    }
}


@end
