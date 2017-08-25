//
//  UILabel+Attributedd.h
//  JudgePlants
//
//  Created by itm on 2017/7/20.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Attributedd)

/**
 *  改变行间距
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变字间距
 */
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变行间距和字间距
 */
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;


+ (void)changeTextSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace WithSomeTextColor:(UIColor *)color ColorRange:(NSRange)colorRange withSomeTextFont:(UIFont *)font FontRange:(NSRange)fontRange;

+(CGSize)textHeightWithString:(NSString *)STR FontOfSize:(CGFloat)fontsize LimitWidth:(CGFloat)width LineSpacing:(CGFloat)lineSpacing;

@end
