//
//  UILabel+Attributedd.m
//  JudgePlants
//
//  Created by itm on 2017/7/20.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "UILabel+Attributedd.h"

@implementation UILabel (Attributedd)

+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}

+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}

+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}

+(void)changeTextSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace WithSomeTextColor:(UIColor *)color ColorRange:(NSRange)colorRange withSomeTextFont:(UIFont *)font FontRange:(NSRange)fontRange{
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    if (color!=nil&&colorRange.length>0) {
        [attributedString addAttribute:NSForegroundColorAttributeName value:color range:colorRange];
    }
    if (font!=nil&&fontRange.length>0) {
       [attributedString addAttribute:NSFontAttributeName value:font range:fontRange];
    }
    label.attributedText = attributedString;
    [label sizeToFit];
    
}


+(CGSize)textHeightWithString:(NSString *)STR FontOfSize:(CGFloat)fontsize LimitWidth:(CGFloat)width LineSpacing:(CGFloat)lineSpacing{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:fontsize],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    CGSize size = [STR boundingRectWithSize:CGSizeMake(width, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    return size;
}

@end
