//
//  SotrageTool.h
//  JudgePlants
//
//  Created by itm on 2017/8/22.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginUserModel.h"
@interface SotrageTool : NSObject

/**
 删除所有的NSUserDefualt类信息
 */
+(void)clearAllNSUserDefualtInfomation;

/**
 存储相关信息到NSUserDefualt

 @param object 任意类型
 @param keyName 主键名称
 */
+(void)addObject:(id)object toNSUserDefualtName:(NSString *)keyName;


/**
 移除NSUserDefualt相应的信息

 @param keyName 相应的主键
 */
+(void)removeObjectWithKeyName:(NSString *)keyName;


/**
 添加用户信息到keychain

 @param dic 字典
 */
+(void)addUserInfomationToKeyChain:(NSDictionary *)dic;


/**
 获取用户个人信息

 @return 返回用户信息model
 */
+(LoginUserModel *)getUserInfomationFromKeyChain;


/**
 从keychain中移除用户信息
 */
+(void)remoeUserInfomationFromKeyChain;

@end
