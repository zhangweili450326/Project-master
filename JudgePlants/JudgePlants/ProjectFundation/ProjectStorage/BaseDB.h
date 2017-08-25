//
//  BaseDB.h
//  JudgePlants
//
//  Created by itm on 2017/5/24.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface BaseDB : NSObject

//创建表
- (void)createTable:(NSString *)sql;

/**
 * 接口描述：插入数据、删除数据、修改数据
 * 参数：  sql: SQL语句
 * 返回值：是否执行成功
 *
 */
- (BOOL)dealData:(NSString *)sql paramsarray:(NSArray *)params;

/**
 *  接口描述：查询数据
 *  参数：  sql:SQL语句
 *  返回值：[
 [“字段值1”，“字段值2”，“字段值3”],
 [“字段值1”，“字段值2”，“字段值3”],
 [“字段值1”，“字段值2”，“字段值3”],
 ]
 */
- (NSMutableArray *)selectData:(NSString *)sql columns:(int)number;

-(void)execInsertTransactionSql:(NSMutableArray *)transactionSql;

-(BOOL)checkTableName:(NSString *)name;

@end
