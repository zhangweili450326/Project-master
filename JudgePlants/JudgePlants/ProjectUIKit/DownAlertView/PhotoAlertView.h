//
//  PhotoAlertView.h
//  JudgePlants
//
//  Created by itm on 2017/7/27.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoAlertView : UIView

+(instancetype)shareInstance;

-(void)showAlertViewWithMessage:(NSString *)message  andSuccess:(BOOL )status ;


@end
