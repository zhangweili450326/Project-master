//
//  NSString+Check.m
//  爱药帮
//
//  Created by itm on 2016/12/13.
//  Copyright © 2016年 zwl. All rights reserved.
//

#import "NSString+Check.h"
#import "NSObject+Check.h"
static NSString *token = @"mTxP.*&^38&@7$2";
@implementation NSString (Check)


/**
 *  利用正则表达式判断手机号是否正确
 */
-(BOOL)checkPhoneNumInput{
    
//        NSPredicate *regextMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",PHONE_REGULAR];
//        BOOL isRigth = [regextMobile evaluateWithObject:self];
//        return isRigth;
//    
//        NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
//    
//        NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
//    
//        NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
//    
//        NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
//    
//        NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//        NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//        NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//        NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
//        BOOL res1 = [regextestmobile evaluateWithObject:self];
//        BOOL res2 = [regextestcm evaluateWithObject:self];
//        BOOL res3 = [regextestcu evaluateWithObject:self];
//        BOOL res4 = [regextestct evaluateWithObject:self];
//    
//        if (res1 || res2 || res3 || res4 )
//        {
//            return YES;
//        }
//        else
//        {
//            return NO;
//        }
    return NO;
}

/**
 *  昵称
 */
- (BOOL)checkNickName
{
    NSString *nickReg = @"^([^\f\n\r\t\v@:：]){4,20}$";
    NSPredicate *regextMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nickReg];
    BOOL isRigth = [regextMobile evaluateWithObject:self];
    return isRigth;
}

/**
 *  判断输入的密码是不是6~16字符
 */
//- (BOOL)checkPasswordInput
//{
//    NSString * regex = Miao_PASSWORD_REGULAR;
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    BOOL isMatch = [pred evaluateWithObject:self];
//    return isMatch;
//}

/**
 *  去除字符串中的空格和回车
 */
- (NSString *)stringTrim
{
    NSString *strTrim = [self stringByTrimmingCharactersInSet:
                         [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return strTrim;
}

#pragma mark 使用MD5加密字符串
//- (NSString *)MD5
//{
//    const char *cStr = [self UTF8String];
//    unsigned char digest[CC_MD5_DIGEST_LENGTH];
//    
//    CC_MD5(cStr, strlen(cStr), digest);
//    
//    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
//    
//    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
//        [result appendFormat:@"%02x", digest[i]];
//    }
//    
//    return result;
//}
//
//- (NSString *)myMD5
//{
//    NSString *str = [NSString stringWithFormat:@"%@%@", self, token];
//    
//    return [str MD5];
//}

/**
 *  网址
 */
- (BOOL)checkWebSite
{
    NSString *reg = HTTP_REGULAR;
    NSPredicate *regextSite = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",reg];
    BOOL isRigth = [regextSite evaluateWithObject:self];
    return isRigth;
}

/**
 *邮箱
 */

-(BOOL)checkEmail{
    NSString *reg = emailRegex;
    NSPredicate *regextSite = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",reg];
    BOOL isRigth = [regextSite evaluateWithObject:self];
    return isRigth;
}

/**
 *纯数字
 */

-(BOOL)checkNumber{
    NSString *reg = @"^[0-9]+$";
    NSPredicate *regextSite = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",reg];
    BOOL isRigth = [regextSite evaluateWithObject:self];
    return isRigth;
}


/**
 *正整数或者小数
 */

-(BOOL)checkFloatAndNumber{
    NSString *regFloat = @"^(([0-9]+\\.[0-9]*[1-9][0-9]*)|([1-9][0-9]*\\.[0-9]+)|([1-9][0-9]*)|0)$";
    NSString *regNumber = @"^[0-9]+$";
    NSPredicate *regextFloat = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regFloat];
    NSPredicate *regextNumber = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regNumber];
    BOOL isRigth1 = [regextFloat evaluateWithObject:self];
    BOOL isRigth2 = [regextNumber evaluateWithObject:self];
    if (isRigth1 || isRigth2) {
        return YES;
    }else{
        return NO;
    }
}

/**
 *判断和精确浮点数
 */

-(BOOL)checkFloatAmount:(int)number badges:(int)location{
    if([self rangeOfString:@"."].length==0){
        return YES;
    }else{
        NSUInteger loca  = [self rangeOfString:@"."].location;
        NSString *sufixString = [self substringFromIndex:(loca+1)];
        NSUInteger tempLocation = sufixString.length;
        if(tempLocation<=location){
            return YES;
        }else{
            return NO;
        }
    }
}

//判断数量长度是否大于7位
-(BOOL)checkNSInteger:(NSInteger)index{
    //    if ([self rangeOfString:@"."].length==0) {
    //        if (self.length>index) {
    //            return YES;
    //        }
    //    }else{
    //        NSUInteger loca=[self rangeOfString:@"."].location;
    //        NSString *preString=[self substringToIndex:loca];
    //        if (preString.length>index) {
    //            return YES;
    //        }
    //    }
    if (self.length>index) {
        return YES;
    }
    return NO;
}

/**
 *判断是否为0
 */
-(BOOL)checkIsZero{
    if ([self floatValue]>0) {
        return YES;
    }
    return NO;
}

/**
 *判断不为中文
 */

-(BOOL)checkBarcode{
    NSPredicate *regextSite = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",twocodeRegex];
    BOOL isRigth = [regextSite evaluateWithObject:self];
    return isRigth;
}

/**
 *密码验证
 */
-(BOOL)checkPwd{
    NSString *reg = @"^[a-zA-Z][a-zA-Z0-9_]{5,17}$";
    NSPredicate *regextSite = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",reg];
    BOOL isRigth = [regextSite evaluateWithObject:self];
    return isRigth;
}


-(NSString *)subStringWithFinalZero:(NSString *)floatValue{
    if (!floatValue) {
        if ([floatValue rangeOfString:@"."].location!=NSNotFound) {
            NSString *finalText = [floatValue substringFromIndex:floatValue.length-1];
            if ([@"0" isEqualToString:finalText]) {
                floatValue = [floatValue substringToIndex:floatValue.length-1];
                return  [self subStringWithFinalZero:floatValue];
            }else{
                return floatValue;
            }
        }else{
            return floatValue;
        }
    }
    return nil;
}


-(NSString *)exchangeSpecialChar:(NSString *)str{
    if (str&&str.length>0) {
        str = [str stringByReplacingOccurrencesOfString:@"/" withString:@"//"];
        str = [str stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
        str = [str stringByReplacingOccurrencesOfString:@"[" withString:@"/["];
        str = [str stringByReplacingOccurrencesOfString:@"]" withString:@"/]"];
        str = [str stringByReplacingOccurrencesOfString:@"%" withString:@"/%"];
        str = [str stringByReplacingOccurrencesOfString:@"&" withString:@"/&"];
        str = [str stringByReplacingOccurrencesOfString:@"&" withString:@"/&"];
        str = [str stringByReplacingOccurrencesOfString:@"(" withString:@"/("];
        str = [str stringByReplacingOccurrencesOfString:@")" withString:@"/)"];
        return str;
    }else{
        return str;
    }
}

-(NSString *)subStringWithMariaty{
    NSString *temp = self;
    if (![self isNull]&&self!=nil) {
        NSRange range = [self rangeOfString:@"("];
        if (range.length!=0) {
            temp = [self substringToIndex:range.location];
        }
    }
    return temp;
}

-(NSString *)subStringWithMariatyshow{
    NSString *temp = self;
    if (![self isNull]&&self!=nil) {
        NSRange range = [self rangeOfString:@"(常规)"];
        if (range.length!=0) {
            temp = [self substringToIndex:range.location];
        }
    }
    return temp;
}

-(NSString *)getUniqueDeviceIdentifierAsString{
    NSString *appName=[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey];
    
    NSString *strApplicationUUID =  [SAMKeychain passwordForService:appName account:@"incoding"];
    if (strApplicationUUID == nil)
    {
        strApplicationUUID  = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        
        NSError *error = nil;
        SAMKeychainQuery *query = [[SAMKeychainQuery alloc] init];
        query.service = appName;
        query.account = @"incoding";
        query.password = strApplicationUUID;
        query.synchronizationMode = SAMKeychainQuerySynchronizationModeNo;
        [query save:&error];
        
    }
    
    return strApplicationUUID;
   
}

@end
