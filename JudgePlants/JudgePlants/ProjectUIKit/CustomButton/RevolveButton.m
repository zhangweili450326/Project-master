//
//  RevolveButton.m
//  JudgePlants
//
//  Created by itm on 2017/6/29.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "RevolveButton.h"

@interface RevolveButton ()

@property (nonatomic,copy)  NSString *b_title;

@property (nonatomic,assign) CGFloat b_x;

@property (nonatomic,assign) CGFloat b_y;

@property (nonatomic,assign) CGFloat b_width;

@property (nonatomic,assign) CGFloat b_height;

@property (nonatomic,assign) CGPoint centerD;

@property (nonatomic,strong) UIColor *b_color;

@end

@implementation RevolveButton

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.b_x=frame.origin.x;
        self.b_y=frame.origin.y;
        self.b_width=frame.size.width;
        self.b_height=frame.size.height;
        self.centerD=self.center;
        self.layer.cornerRadius=5.0;
    }
    return self;
}


- (void) startLoadingAnimation{
    
    NSLog(@"--%@", self.titleLabel.text);
    if (self.titleLabel.text!=nil) {
        _b_title=self.titleLabel.text;
    }
    if (self.backgroundColor!=nil) {
        _b_color=self.backgroundColor;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
     
        self.height=self.b_height+5;
        self.width=self.b_height+5;
        self.center=self.centerD;
        self.layer.cornerRadius=(self.b_height+5)/2.0;
        self.alpha=1;
        self.clipsToBounds=YES;
        [self setTitle:nil forState:UIControlStateNormal];
       
        
    } completion:^(BOOL finished) {

    [self setBackgroundImage:[UIImage imageNamed:@"image_loading"] forState:UIControlStateNormal];
//         [self setBackgroundColor:[UIColor whiteColor]];
        [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        animation.fromValue = @(0);
        animation.toValue = @(M_PI * 2);
        animation.duration = 1.f;
        animation.repeatCount = INT_MAX;
        
        [self.layer addAnimation:animation forKey:@"rotate"];
        
    }];
}
- (void) stopLoadingAnimation{
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect rect=CGRectMake(self.b_x, self.b_y, self.b_width, self.b_height);
        self.frame=rect;
        self.layer.cornerRadius=5.0;
        self.alpha=1;
         [self.layer removeAnimationForKey:@"rotate"];

        [self setBackgroundImage:nil forState:UIControlStateNormal];
        [self setTitle:_b_title forState:UIControlStateNormal];
        if (_b_color!=nil) {
            [self setBackgroundColor:_b_color];
        }
    } completion:^(BOOL finished) {
        
        
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
