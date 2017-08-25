//
//  waterWaveView.m
//  ttttt
//
//  Created by zwl on 17/3/2.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "waterWaveView.h"

#define kDripCount          7     // 水滴总数

@interface waterWaveView ()


@property (nonatomic,strong) CAShapeLayer *waveShapeLayerT;

@property (nonatomic,strong) CADisplayLink *waveDisplayLink;


@property (nonatomic, assign) BOOL increase;
@property (nonatomic, assign) CGFloat variable;

@property (strong, nonatomic) NSMutableArray *dripLayers;
@property (strong, nonatomic) NSMutableArray *waveLayers;

@end

@implementation waterWaveView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    
    if (self) {
        [self createLayer];
    }
    return self;
}



-(void)createLayer
{
    
    self.variable = 5;
    self.increase = NO;
    
    self.waveShapeLayerT = [CAShapeLayer layer];
    self.waveShapeLayerT.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:self.waveShapeLayerT];
    /*
     *CADisplayLink是一个能让我们以和屏幕刷新率相同的频率将内容画到屏幕上的定时器。我们在应用中创建一个新的 CADisplayLink 对象，把它添加到一个runloop中，并给它提供一个 target 和selector 在屏幕刷新的时候调用。
     */
//    self.waveDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getCurrentWave)];
//    [self.waveDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

-(void)setWaveColor:(UIColor *)waveColor{
    _waveColor=waveColor;
//     self.waveShapeLayerT.fillColor = _waveColor.CGColor;
}

//CADispayLink相当于一个定时器 会一直绘制曲线波纹 看似在运动，其实是一直在绘画不同位置点的余弦函数曲线
- (void)getCurrentWave {
    [self amplitudeChanged];
    
    
    /*
     *  第四个白色
     */
    
    self.offsetXT += self.waveSpeed;
    CGMutablePathRef pathT = CGPathCreateMutable();
    CGPathMoveToPoint(pathT, nil, 0, self.waveHeight+50);
    
    CGFloat yT = 0.f;
    for (float x = 0.f; x <= self.waveWidth ; x++) {
        yT = self.waveAmplitude*0.35 * sin((220/ self.waveWidth) * (x * M_PI / 60) - self.offsetXT * M_PI / 180) + self.waveHeight*1.3;
        
        //        NSLog(@"%--f %f",x,yT);
        CGPathAddLineToPoint(pathT, nil, x, yT-7);
    }
    CGPathAddLineToPoint(pathT, nil, self.waveWidth, self.frame.size.height);
    CGPathAddLineToPoint(pathT, nil, 0, self.frame.size.height);
    CGPathCloseSubpath(pathT);
    self.waveShapeLayerT.path = pathT;
    CGPathRelease(pathT);
}

//水波在上升过程中振幅的轻微变化
- (void)amplitudeChanged
{
    if (self.increase)
    {
        self.variable += 0.05;
    }
    else
    {
        self.variable -= 0.05;
    }
    
    // 变化的范围
    if (self.variable <= 2.5)
    {
        self.increase = YES;
    }
    
    if (self.variable >= 5)
    {
        self.increase = NO;
    }
    
    self.waveAmplitude = self.variable * 5;
}


#pragma mark - Splash water
- (void)splashWater
{
    if (!_dripLayers) {
        _dripLayers = [[NSMutableArray alloc] initWithCapacity:kDripCount];
        
        for (int i = 0; i < kDripCount; i++) {
            
            CALayer *dripLayer = [CALayer layer];
            [_dripLayers addObject:dripLayer];
            
        }
    }
    
    for (int i = 0; i < kDripCount; i++) {
        
        [self performSelector:@selector(addAnimationToDrip:) withObject:_dripLayers[i] afterDelay:i * 0.01];
    }
    
}

- (void)stopSplashWater
{
    [_dripLayers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeAllAnimations];
        [obj removeFromSuperlayer];
    }];
}
- (void)addAnimationToDrip:(CALayer *)dripLayer
{
    CGFloat width = arc4random() % 12 + 1;
    dripLayer.frame = CGRectMake((self.bounds.size.width - width)* 0.5f,50, width, width);
    dripLayer.cornerRadius = dripLayer.frame.size.width * 0.5f;
    dripLayer.backgroundColor = self.waveColor.CGColor;
    
    [self.layer addSublayer:dripLayer];
    
    CGFloat x3 = arc4random() % ((int)self.bounds.size.width) + 1;
    CGFloat y3 = self.bounds.size.height * 0.5f + 60;
    
    CGFloat height = arc4random() % ((int)(self.bounds.size.height * 0.5f)+100);
    
    [self throwDrip:dripLayer
               from:dripLayer.position
                 to:CGPointMake(x3, y3)
             height:height
           duration:0.7f];
}

- (void)throwDrip:(CALayer *)drip
             from:(CGPoint)start
               to:(CGPoint)end
           height:(CGFloat)height
         duration:(CGFloat)duration
{
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, start.x, start.y);
    CGPathAddQuadCurveToPoint(path, NULL, (end.x + start.x) * 0.5f, -height+10, end.x, end.y);
    

    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [animation setPath:path];
    animation.duration = duration;
    CFRelease(path);
    path = nil;
    
    [drip addAnimation:animation forKey:@"position"];
    
    [self performSelector:@selector(colorClear:) withObject:drip afterDelay:0.2];
    
}

-(void)colorClear:(CALayer *)layer{
    
    [UIView animateWithDuration:0.4 animations:^{
        layer.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0].CGColor;
    } completion:^(BOOL finished) {
        [layer removeFromSuperlayer];
    }];
}


#pragma mark - Animation did stop

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag) {
        [self stopSplashWater];
    }
}



@end
