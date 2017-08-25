//
//  CenterAnimationView.m
//  JudgePlants
//
//  Created by itm on 2017/7/26.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "CenterAnimationView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface CenterAnimationView ()

@end

@implementation CenterAnimationView
- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        
        [self addSubview:self.flyView];
        [self addSubview:self.waterView];
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClickAction)];
        [self addGestureRecognizer:tapGes];
        
    }
    return self;
}
- (UIView *)flyView
{
    if (!_flyView) {
        _flyView = [[UIView alloc] init];
    }
    return _flyView;
}

-(UIView *)waterView{
    if (!_waterView) {
        _waterView =[[waterWaveView alloc]init];
    }
    return _waterView;
}

- (void)startFly:(FlyType)type
{
    switch (type) {
        case FlyTypeUToD:
        {
            _flyView.frame = CGRectMake(SCREEN_WIDTH / 2 - self.fly_w / 2, -self.fly_h, self.fly_w, self.fly_h);
        }
            break;
        case FlyTypeDToD:
        {
            _flyView.frame = CGRectMake(SCREEN_WIDTH / 2 - self.fly_w / 2, SCREEN_HEIGHT + self.fly_h, self.fly_w, self.fly_h);
        }
        default:
            break;
    }
    _flyView.layer.cornerRadius=5.0;
    _flyView.layer.masksToBounds=YES;
    _flyView.backgroundColor = [UIColor whiteColor];
    
    
    
    _waterView.frame=CGRectMake(0,SCREEN_HEIGHT/2+self.fly_h/2, SCREEN_WIDTH, SCREEN_HEIGHT/2-self.fly_h/2);
    _waterView.waveColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    _waterView.waveSpeed=1.5;
    _waterView.offsetXT=-5;
    _waterView.waveWidth=SCREEN_WIDTH;
    _waterView.waveHeight=20;
    _waterView.waveAmplitude=6;
    
    
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    anim.toValue = [NSValue valueWithCGPoint:self.center];
    // 速度
    anim.springSpeed = 5;
    // 弹力--晃动的幅度 (springSpeed速度)
    anim.springBounciness = 8.0f;
    [_flyView pop_addAnimation:anim forKey:@"animationShow"];
    
    [self performSelector:@selector(waterShowWihte) withObject:nil afterDelay:0.3];
}

-(void)waterShowWihte{
   
    [_waterView splashWater];
    
    [self performSelector:@selector(finishWater) withObject:nil afterDelay:2];
}

-(void)finishWater{
    
    [UIView animateWithDuration:1 animations:^{
         _waterView.waveColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    } completion:^(BOOL finished) {
         [_waterView stopSplashWater];
        [_waterView removeFromSuperview];
    }];
}

- (void)tapClickAction
{
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(self.center.x, SCREEN_HEIGHT + self.fly_h)];
    [_flyView pop_addAnimation:anim forKey:@"animationRemove"];
    anim.springSpeed = 7;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
