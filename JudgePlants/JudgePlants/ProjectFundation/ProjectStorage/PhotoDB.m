//
//  PhotoDB.m
//  JudgePlants
//
//  Created by itm on 2017/5/24.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "PhotoDB.h"
#import "HistoryPhotoModel.h"
static PhotoDB *instance;
@implementation PhotoDB

+(id)shareInstance{
    if(instance==nil){
        instance = [[[self class] alloc] init];
    }
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    @synchronized(self){
        if (instance == nil) {
            instance = [super allocWithZone:zone];
            return instance;
        }
    }
    return nil;
}


-(void)creteAllManageTable{
    [self createTablePhotoTool];
   
}

/**
 *   工具栏本地数据库
 */

-(void)createTablePhotoTool
{
    NSString *sql=@"CREATE TABLE if not exists 'historyPhoto' ('Id' TEXT PRIMARY KEY UNIQUE,'imgId' TEXT,'name' TEXT,'name_English' TEXT,'createTime' TEXT,'address' TEXT,'detail' TEXT,'reliability' TEXT,'image_local' TEXT,'image_url' TEXT)";
    [super createTable:sql];
}

-(void)updateLocalPhotoTool:(NSArray *)datas
{
    if (datas&&datas.count>0) {
        NSMutableArray *param = [NSMutableArray array];
        for (HistoryPhotoModel *model in datas) {
            NSString *sql = [NSString  stringWithFormat:@"INSERT OR REPLACE INTO historyPhoto(Id,imgId,name,name_English,createTime,address,detail,reliability,image_local,image_url) values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@');",model.Id,model.imgId?model.imgId:@"",model.name ? model.name:@"",model.name_English ? model.name_English:@"",model.createTime ? model.createTime:@"",model.address ? model.address:@"",model.detail ? model.detail:@"",model.reliability ? model.reliability:@"",model.image_local ? model.image_local:@"",model.image_url ? model.image_url:@""];
            [param addObject:sql];
        }
        [self execInsertTransactionSql:param];
    }
}

-(NSArray *)selectPhotoToolById:(NSString *)Id
{
    NSMutableArray *result = [NSMutableArray array];
    NSString *sql = [NSString stringWithFormat:@"select Id,imgId,name,name_English,createTime,address,detail,reliability,image_local,image_url from historyPhoto where Id = '%@'",Id];
    NSArray *data = [self selectData:sql columns:10];
    if (data&&data.count>0) {
        NSArray *row = [data firstObject];
        if (row&&row.count>0) {
            HistoryPhotoModel *tool = [[HistoryPhotoModel alloc] init];
            tool.Id = [row objectAtIndex:0];
            tool.imgId=[row objectAtIndex:1];
            tool.name = [row objectAtIndex:2];
            tool.name_English = [row objectAtIndex:3];
            tool.createTime = [row objectAtIndex:4];
            tool.address = [row objectAtIndex:5];
            tool.detail = [row objectAtIndex:6];
            tool.reliability = [row objectAtIndex:7];
            tool.image_local = [row objectAtIndex:8];
            tool.image_url = [row objectAtIndex:9];
            [result addObject:tool];
        }
    }
    return [NSArray arrayWithArray:result];
}

-(NSMutableArray *)selectManageToolAllObject
{
    NSMutableArray *result = [NSMutableArray array];
    NSString *sql = [NSString stringWithFormat:@"select Id,imgId,name,name_English,createTime,address,detail,reliability,image_local,image_url from historyPhoto "];
    NSArray *data = [self selectData:sql columns:10];
    if (data&&data.count>0) {
        
        for (NSArray *row in data){
            HistoryPhotoModel *tool = [[HistoryPhotoModel alloc] init];
            tool.Id = [row objectAtIndex:0];
            tool.imgId=[row objectAtIndex:1];
            tool.name = [row objectAtIndex:2];
            tool.name_English = [row objectAtIndex:3];
            tool.createTime = [row objectAtIndex:4];
            tool.address = [row objectAtIndex:5];
            tool.detail = [row objectAtIndex:6];
            tool.reliability = [row objectAtIndex:7];
            tool.image_local = [row objectAtIndex:8];
            tool.image_url = [row objectAtIndex:9];
            [result addObject:tool];
        }
    }
    
    return result;
    
}

-(BOOL)deletePhotoToolById:(NSString *)Id
{
    NSString *sql = [NSString stringWithFormat:@"delete from historyPhoto where Id = '%@'",Id];
    return [super dealData:sql paramsarray:[NSMutableArray array]];
}

-(void)deleteLocalManageTooldatas
{
    NSMutableArray *param=[NSMutableArray array];
    NSString *sql=@"delete from historyPhoto";
    [param addObject:sql];
    [self execInsertTransactionSql:param];
}



@end
