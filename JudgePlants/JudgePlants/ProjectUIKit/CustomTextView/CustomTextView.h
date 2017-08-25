//
//  CustomTextView.h
//  JudgePlants
//
//  Created by itm on 2017/7/19.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTextView : UITextView

@property (copy, nonatomic, nullable) IBInspectable NSString *xx_placeholder;

@property (strong, nonatomic, nullable) IBInspectable UIColor *xx_placeholderColor;

@property (strong, nonatomic, nullable) UIFont *xx_placeholderFont;

@end
