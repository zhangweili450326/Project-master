//
//  MacroPch.h
//  JudgePlants
//
//  Created by itm on 2017/5/18.
//  Copyright © 2017年 zwl. All rights reserved.
//

#ifndef MacroPch_h
#define MacroPch_h


// 以375 为基础的宽比例
#define K_SCWIDTH  [UIScreen mainScreen].bounds.size.width/375.f

#define Screen_Height [UIScreen mainScreen].bounds.size.height
#define Screen_Width [UIScreen mainScreen].bounds.size.width

#define UIColorFromRGB(rgbValue)  [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000)>>16))/255.0 \
green:((float)((rgbValue & 0xFF00)>>8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

///////////////////////
#define PKMAX(A,B) ({__typeof(A) __a = (A);__typeof(B) __b = (B); __a > __b ? __a : __b; }) //比较大小 选择最大那个
#define PKMIN(A,B) ({ __typeof__(A) __a = (A); __typeof__(B) __b = (B); __a < __b ? __a : __b; })

/////////////////////

#if __has_feature(objc_instancetype)

#undef    DEF_SINGLETON
#define   DEF_SINGLETON( ... )  \
+ (instancetype)sharedInstance;

#undef  IMP_SINGLETON
#define IMP_SINGLETON \
+ (instancetype)sharedInstance \
{ \
static dispatch_once_t once; \
static id __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } ); \
return __singleton__; \
}

#else

#undef	DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance;

#undef	IMP_SINGLETON
#define IMP_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[[self class] alloc] init]; } ); \
return __singleton__; \
}

#endif


///////////////////////
#define colorGreen 0x43cba2
#define colorTextBlue5894cc 0x5894cc
#define colorTextBlackColor 0x333333
#define colorTextLightColor 0x999999
#define colorBackLineColor 0xe5e5e5
#define colorGroupViewColor 0xF7F7F7

#define colorGray666666 0x666666


#define NUMBER_FONT_NAME @"DIN Condensed"//特殊数字自定义字体

// 21.正则字符串
#define PHONE_REGULAR @"^(13[0-9]|15[012356789]|18[0123456789]|14[57]|17[0])[0-9]{8}$"//手机号验证规则

#define MESSAGE_CODE_REGULAR @"^\\d{6}$"//短信验证码规则

#define GRAPH_CODE_REGULAR  @"^[A-Za-z0-9]{4}$"//图形验证码规则

#define HTTP_REGULAR @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"  //网址验证

#define emailRegex @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}" //邮箱校验

#define twocodeRegex @"^[^\u4e00-\u9fa5]{0,}$"



// 18.判断字符串是否为空
#define strIsEmpty(str) (((NSNull *)str == [NSNull null]) || (str == nil) || [str length]< 1 ? YES : NO )

#endif /* MacroPch_h */
