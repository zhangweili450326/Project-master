//
//  LoadingView.m
//  HoldStars
//
//  Created by 张君宝 on 16/1/8.
//  Copyright © 2016年 海睿星巢文化. All rights reserved.
//

#import "LoadingView.h"
#import <QuartzCore/QuartzCore.h>

@implementation LoadingView

static LoadingView *mLoadingView = nil;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

///初始化加载框，这个函数是表示LoadingView的大小，如果是Yes，则loadView的大小为整个窗体，在这种情况下网络请求的时候会遮盖整个窗体，用户其他操作都是无效的相当于同步，如果是No，则loadView的大小为为150*80，用户的其他操作是有效的，这种情况相下需要保证loadingView唯一；
- (id)initIsLikeSynchro:(BOOL)isLikeSynchro{
    if (isLikeSynchro) {
        self = [super initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
        
    }else{
        self = [super initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64-49)];
    }
    
    if (self) {
        self.isLikeSynchro = isLikeSynchro;
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        
        conerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        
        [self setCenter:conerView withParentRect:self.frame];
      
        conerView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
       
        [self addSubview:conerView];
        
        imgView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 40, 40)];
        imgView.layer.cornerRadius=20;
        imgView.layer.masksToBounds=YES;
       
        imgView.image=[UIImage imageNamed:@"image_loading"];
        
        [conerView addSubview:imgView];
        
//        UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, 100, 20)];
//        lblTitle.backgroundColor = [UIColor clearColor];
//        lblTitle.textColor = [UIColor whiteColor];
//        lblTitle.textAlignment = NSTextAlignmentCenter;
//        lblTitle.text = @"加载中...";
//        lblTitle.font = [UIFont systemFontOfSize:17];
//        [conerView addSubview:lblTitle];
        
        conerView.layer.cornerRadius = 8;
        conerView.layer.masksToBounds = YES;
    }
    return self;
}

- (void)show{
    
    if ([UIApplication sharedApplication].keyWindow.rootViewController.navigationController) {
        
        [[UIApplication sharedApplication].keyWindow.rootViewController.navigationController.view addSubview:self];
    }else{
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.fromValue = @(0);
    animation.toValue = @(M_PI * 2);
    animation.duration = 1.f;
    animation.repeatCount = INT_MAX;
    
    [conerView.layer addAnimation:animation forKey:@"rotate"];
    
}

- (void)close{
    [conerView.layer removeAnimationForKey:@"rotate"];
    [self removeFromSuperview];
}

+ (LoadingView *)shareLoadingView{
    @synchronized(self){
        if (mLoadingView==nil) {
            mLoadingView = [[self alloc] initIsLikeSynchro:NO];
        }
    }
    return mLoadingView;
}

+ (id)allocWithZone:(NSZone *)zone{
    @synchronized(self){
        if (mLoadingView==nil) {
            mLoadingView = [super allocWithZone:zone];
            return mLoadingView;
        }
    }
    return  nil;
}

///设置子View在父View中居中
- (void)setCenter:(UIView *)child withParentRect:(CGRect)parentRect{
    CGRect rect = child.frame;
    rect.origin.x = (parentRect.size.width - child.frame.size.width)/2;
    rect.origin.y = (parentRect.size.height - child.frame.size.height)/2;
    child.frame = rect;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
