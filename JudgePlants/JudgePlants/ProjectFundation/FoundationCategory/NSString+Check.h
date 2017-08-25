//
//  NSString+Check.h
//  爱药帮
//
//  Created by itm on 2016/12/13.
//  Copyright © 2016年 zwl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
@interface NSString (Check)
/**
 *  利用正则表达式判断手机号是否正确
 */
-(BOOL)checkPhoneNumInput;

/**
 *  判断密码是不是6~16字符
 */
//- (BOOL)checkPasswordInput;

/**
 *  去掉字符串中的空格和回车
 */
- (NSString *)stringTrim;

/**
 *  对现有字符串进行MD5加密
 */
//- (NSString *)myMD5;

/**
 *判断和精确浮点数的类型的精度(位数和小数位数)
 */
-(BOOL)checkFloatAmount:(int)number badges:(int)location;

/**
 *  昵称
 */
- (BOOL)checkNickName;

-(BOOL)checkWebSite;

-(BOOL)checkEmail;

-(BOOL)checkNumber;

//判断大小有没有超过百万级
-(BOOL)checkNSInteger:(NSInteger)index;

-(BOOL)checkIsZero;

/**
 *正整数或者小数
 */
-(BOOL)checkFloatAndNumber;

-(BOOL)checkPwd;

-(BOOL)checkBarcode;

-(NSString *)subStringWithFinalZero:(NSString *)floatValue;

-(NSString *)exchangeSpecialChar:(NSString *)str;

-(NSString *)subStringWithMariaty;

-(NSString *)subStringWithMariatyshow;

-(NSString *)getUniqueDeviceIdentifierAsString;

@end
