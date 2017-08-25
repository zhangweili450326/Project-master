//
//  AlerTool.h
//  JudgePlants
//
//  Created by itm on 2017/5/19.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlerTool : NSObject
+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;
+ (void)showMessage:(NSString *)message;
+ (void)hideHUD;
@end
