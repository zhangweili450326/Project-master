//
//  JPFooterRefresh.m
//  JudgePlants
//
//  Created by itm on 2017/7/28.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "JPFooterRefresh.h"
#import <MJRefresh.h>
@interface JPFooterRefresh ()

@property(nonatomic,weak) UIView * headerFreshView;
@property(nonatomic,weak)UILabel * label;
@property(nonatomic,weak)UIImageView * imageView;

@end

@implementation JPFooterRefresh


#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    // 设置控件的高度
    self.mj_h = 55;
    
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [self addSubview:view];
    self.headerFreshView = view;
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = UIColorFromRGB(colorTextLightColor);
    label.font = [UIFont boldSystemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [self.headerFreshView addSubview:label];
    self.label = label;
    
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"RefreshFlowerImage"];
    [self.headerFreshView addSubview:imageView];
    self.imageView = imageView;
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.headerFreshView.bounds = CGRectMake(0, 0,self.mj_w,self.mj_h);
    self.headerFreshView.center = CGPointMake(self.mj_w/2, self.mj_h/2);
    
    self.imageView.frame = CGRectMake(self.mj_w/2-12.5,5 ,25, 25);
    
     self.label.frame = CGRectMake(self.mj_w/2-50,35, 100, 15);
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            self.label.text = @"上拉加载";
             [self performSelector:@selector(endAnimation) withObject:nil afterDelay:0.2];
            break;
        case MJRefreshStatePulling:
            self.label.text = @"松开加载更多";
            [self endAnimation];
            break;
        case MJRefreshStateRefreshing:
            self.label.text = @"加载中...";
            [self startAnimation];
            break;
        case MJRefreshStateNoMoreData:
            self.label.text = @"已加载全部";
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
}


#pragma mark 图片旋转
-(void)startAnimation
{
    CABasicAnimation *basicAni= [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    basicAni.removedOnCompletion = NO;
    basicAni.fillMode = kCAFillModeForwards;
    basicAni.fromValue = @(0);
    basicAni.toValue = @(M_PI * 2);
    basicAni.duration = 1.f;
    basicAni.repeatCount = INT_MAX;
    
    [self.imageView.layer addAnimation:basicAni forKey:nil];
}

- (void)endAnimation
{
    [self.imageView.layer removeAllAnimations];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
