//
//  PhotoDB.h
//  JudgePlants
//
//  Created by itm on 2017/5/24.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "BaseDB.h"

@interface PhotoDB : BaseDB

+(id)shareInstance;
-(void)creteAllManageTable;

-(void)createTablePhotoTool;
-(void)updateLocalPhotoTool:(NSArray *)datas;
-(NSMutableArray *)selectManageToolAllObject;
-(NSArray *)selectPhotoToolById:(NSString *)Id;
-(void)deleteLocalManageTooldatas;
-(BOOL)deletePhotoToolById:(NSString *)Id;

@end
