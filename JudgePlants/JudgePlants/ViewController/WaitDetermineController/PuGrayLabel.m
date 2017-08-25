//
//  PuGrayLabel.m
//  JudgePlants
//
//  Created by itm on 2017/7/13.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "PuGrayLabel.h"
#import "StringTool.h"
@implementation PuGrayLabel

-(instancetype)initWithText:(NSString *)text x:(CGFloat)x y:(CGFloat)y size:(CGSize)size{
    self = [super init];
    if (self) {
        if ([StringTool checkStringIsNull:text]) {
            text = @"";
        }
        self.frame = CGRectMake(x, y, size.width, size.height+4);
        self.backgroundColor=UIColorFromRGB(colorGroupViewColor);
//        self.layer.cornerRadius = 3.0;
//        self.layer.masksToBounds = YES;
        self.text = text;
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = [UIColor grayColor];
        self.font =[UIFont systemFontOfSize:13];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
