//
//  BezierView.m
//  JudgePlants
//
//  Created by itm on 2017/5/18.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "BezierView.h"

@implementation BezierView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled=YES;
        self.backgroundColor = [UIColor clearColor];
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 2;
        self.layer.cornerRadius=5.0;
        [self initBezierView];
    }
    
    return self;
}

-(void)initBezierView{
    
    // 最里层镂空
    UIBezierPath *transparentRoundedRectPath = [UIBezierPath bezierPathWithRoundedRect:self.frame cornerRadius:self.layer.cornerRadius];
    
    // 最外层背景
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.frame];
    [path appendPath:transparentRoundedRectPath];
    [path setUsesEvenOddFillRule:YES];
    
//    CAShapeLayer *fillLayer = [CAShapeLayer layer];
//    fillLayer.path = path.CGPath;
//    fillLayer.fillRule = kCAFillRuleEvenOdd;
//    fillLayer.fillColor = [UIColor blackColor].CGColor;
//    fillLayer.opacity = 0.6;
//    [self.layer addSublayer:fillLayer];
//    CGRect frame =self.frame;
//    CGFloat ratio =2;
//    frame.origin.x *=ratio;
//    frame.origin.y *=ratio;
//    frame.size.width *=ratio;
//    frame.size.height *=ratio;
    
    self.pathRect=self.frame;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
