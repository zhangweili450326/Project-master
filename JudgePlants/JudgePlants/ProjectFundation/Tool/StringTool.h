//
//  StringTool.h
//  JudgePlants
//
//  Created by itm on 2017/5/19.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringTool : NSObject
//判断是否为空或者为空字符串
+(BOOL)checkStringIsNull:(NSString *)text;
//判断对象是否为空或者为空字符串
+(BOOL)checkObjectIsNull:(NSObject *)text;

+(BOOL)checkStringIsContainNumber:(NSString *)text;
@end
