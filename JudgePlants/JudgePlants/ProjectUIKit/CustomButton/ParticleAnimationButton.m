//
//  ParticleAnimationButton.m
//  fsdfsdfds
//
//  Created by zwl on 17/7/22.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "ParticleAnimationButton.h"
#import "ParticleAnimationImageView.h"
@interface ParticleAnimationButton ()

//两种不同的CAEmitterLayer
@property (strong, nonatomic) CAEmitterLayer *chargeLayer;
@property (strong, nonatomic) CAEmitterLayer *explosionLayer;

@property (nonatomic,strong) ParticleAnimationImageView *img;

@end

@implementation ParticleAnimationButton

/**
 *  通过fram初始化
 *
 *  @param frame WclEmitterButton的fram
 *
 *  @return 返回WclEmitterButton对象
 */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
     
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
     
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];

    if (selected) {
        
        NSInteger width=(NSInteger)[UIScreen mainScreen].bounds.size.width;
        NSInteger imgX=0;
        if (arc4random()%width<120) {
            imgX=120;
        }else if(arc4random()%width>width-120){
            imgX=width-120;
        }else{
            imgX=arc4random()%width;
        }
        
        _img=[[ParticleAnimationImageView alloc]initWithFrame:CGRectMake(self.center.x, self.center.y, 0, 0)];
        _img.image=[UIImage imageNamed:@"photo_zan_red"];
        [self.superview addSubview:_img];
        _img.isSelect=YES;
        [UIView animateWithDuration:1.0 animations:^{
            _img.frame=CGRectMake(imgX, self.center.y-80-arc4random()%40, 20, 20);
            
        } completion:^(BOOL finished) {
            [_img animation];
        }];
        
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        animation.values = @[@1.3 ,@0.8, @1.0,@1.2,@1.0];
        animation.duration = 0.5;
        animation.calculationMode = kCAAnimationCubic;
        [self.layer addAnimation:animation forKey:@"transform.scale"];
        
    }else{
        
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        animation.values = @[@1.5 ,@1.2,@1.0];
        animation.duration = 0.5;
        animation.calculationMode = kCAAnimationCubic;
        [self.layer addAnimation:animation forKey:@"transform.scale"];
        
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
