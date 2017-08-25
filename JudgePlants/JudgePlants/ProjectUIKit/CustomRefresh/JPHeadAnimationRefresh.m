//
//  JPHeadAnimationRefresh.m
//  JudgePlants
//
//  Created by itm on 2017/7/28.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "JPHeadAnimationRefresh.h"
#import <MJRefresh.h>

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define AnimationDISTANCE 100

@interface JPHeadAnimationRefresh ()
{
    NSTimer  *timer;
}
@property(nonatomic,weak)UIImageView *logo;

@property(nonatomic,weak)UIView *bgView;

@end


@implementation JPHeadAnimationRefresh

#pragma mark- 重写方法
#pragma 在这里做一些初始化配置（比如添加子控件）
-(void)prepare{
    [super prepare];
    
    //设置控件高度
    self.mj_h=80;
    
    //bgview
    UIView *bgView=[[UIView alloc]init];
    bgView.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    [self addSubview:bgView];
    self.bgView=bgView;
    
    //logo
    UIImageView *logo=[[UIImageView alloc]init];
    logo.image = [UIImage imageNamed:@"RefreshFlowerImage"];
    [bgView addSubview:logo];
    self.logo=logo;
    
    
    
    
    
}
#pragma mark--设置子控件的布局
-(void)placeSubviews{
    [super placeSubviews];
    
    self.bgView.frame=CGRectMake(0, 0,kScreenWidth, self.mj_h);
    self.logo.frame=CGRectMake(0.5*kScreenWidth-15,self.mj_h/2-15, 30, 30);
    
}
#pragma mark--监听scrollview的contenoffset的改变
-(void)scrollViewContentOffsetDidChange:(NSDictionary *)change{
    [super scrollViewContentOffsetDidChange:change];
    
}
#pragma mark--监听scrollview的contentsize的改变
-(void)scrollViewContentSizeDidChange:(NSDictionary *)change{
    [super scrollViewContentSizeDidChange:change];
    
}
#pragma mark--监听scrollview的拖拽状态的改变
-(void)scrollViewPanStateDidChange:(NSDictionary *)change{
    [super scrollViewPanStateDidChange:change];
    
}
#pragma mark--监听控件的刷新状态
-(void)setState:(MJRefreshState)state{
    MJRefreshCheckState;
    switch (state) {
        case MJRefreshStateIdle:
        [self performSelector:@selector(endAnimation) withObject:nil afterDelay:0.2];
            break;
        case MJRefreshStatePulling:
            [self endAnimation];
            break;
        case MJRefreshStateRefreshing:
            [self startAnimation];
             break;
        default:
            break;
    }
}


#pragma mark--监听控件的拖拽比例（控件被拖出来的比例）
-(void)setPullingPercent:(CGFloat)pullingPercent{
    [super setPullingPercent:pullingPercent];
    
}

#pragma mark--画圈
-(void)addLayer{
    
    UIBezierPath *path=[UIBezierPath bezierPathWithRoundedRect:CGRectMake(-5, -5, self.logo.frame.size.width+10, self.logo.frame.size.height+10) cornerRadius:(self.logo.width+10)/2.0];
    
    path.lineWidth=1;
    CAShapeLayer *layer=[[CAShapeLayer alloc]init];
    layer.path=path.CGPath;
    layer.strokeColor=[UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:0.7].CGColor;
    
    layer.fillColor=[UIColor clearColor].CGColor;
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.logo.width, self.logo.height)];
    [self.logo addSubview:view];
    [view.layer addSublayer:layer];
    [UIView setAnimationRepeatCount:2];
    //动画
    [UIView animateWithDuration:1 animations:^{
        view.transform=CGAffineTransformScale(view.transform, 2.0, 2.0);
        view.alpha=0;
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
    }];

    
}

#pragma mark 图片旋转
- (void)startAnimation
{
    CABasicAnimation *basicAni= [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    basicAni.removedOnCompletion = NO;
    basicAni.fillMode = kCAFillModeForwards;
    basicAni.fromValue = @(0);
    basicAni.toValue = @(M_PI * 2);
    basicAni.duration = 1.f;
    basicAni.repeatCount = INT_MAX;
    
    [self.logo.layer addAnimation:basicAni forKey:nil];
    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
        timer=[NSTimer timerWithTimeInterval:2 target:self selector:@selector(addLayer) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        
//    });
    [self addLayer];
}
- (void)endAnimation
{
    [self.logo.layer removeAllAnimations];
    [timer invalidate];
    timer=nil;
}



@end
