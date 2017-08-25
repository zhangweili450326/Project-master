//
//  SotrageTool.m
//  JudgePlants
//
//  Created by itm on 2017/8/22.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "SotrageTool.h"

#define  appName [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey]
@implementation SotrageTool

+(void)clearAllNSUserDefualtInfomation{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dictionary = [userDefaults dictionaryRepresentation];
    for(NSString* key in [dictionary allKeys]){
        [userDefaults removeObjectForKey:key];
        [userDefaults synchronize];
    }
}

+(void)addObject:(id)object toNSUserDefualtName:(NSString *)keyName{
    
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    [userDefault setObject:object forKey:keyName];
    [userDefault synchronize];
    
}

+(void)removeObjectWithKeyName:(NSString *)keyName{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault removeObjectForKey:keyName];
    [userDefault synchronize];
}

+(void)addUserInfomationToKeyChain:(NSDictionary *)dic{
    
    if (!dic) {return;}
    LoginUserModel *model=[LoginUserModel mj_objectWithKeyValues:dic];
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:model];
    [SAMKeychain setPasswordData:data forService:appName account:ProjectUserInformation];
}

+(LoginUserModel *)getUserInfomationFromKeyChain{

    NSData *data1=[SAMKeychain passwordDataForService:appName account:ProjectUserInformation];
    LoginUserModel *model1=[NSKeyedUnarchiver unarchiveObjectWithData:data1];
    return model1;
}

+(void)remoeUserInfomationFromKeyChain{
    [SAMKeychain deletePasswordForService:appName account:ProjectUserInformation];
}

@end
