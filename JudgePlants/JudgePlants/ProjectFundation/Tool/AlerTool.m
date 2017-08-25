//
//  AlerTool.m
//  JudgePlants
//
//  Created by itm on 2017/5/19.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "AlerTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
@implementation AlerTool


+ (void)showSuccess:(NSString *)success
{
    if ([StringTool checkStringIsNull:success]) {
        success = @"";
    }
    [MBProgressHUD showSuccess:success];
}

+ (void)showError:(NSString *)error
{
    if ([StringTool checkObjectIsNull:error]) {
        error = @"服务异常";
    }
    [MBProgressHUD showError:error];
}

+ (void)showMessage:(NSString *)message
{
    if ([message isEqual:[NSNull null]]) {
        message = @"";
    }
    [MBProgressHUD showMessage:message];
}

+ (void)hideHUD
{
    [MBProgressHUD hideHUD];
}

@end
