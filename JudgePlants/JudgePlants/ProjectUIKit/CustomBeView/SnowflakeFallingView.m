//
//  SnowflakeFallingView.m
//  fsdfsdfds
//
//  Created by zwl on 17/7/23.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "SnowflakeFallingView.h"

@interface SnowflakeFallingView ()
{
    CADisplayLink *link;
    
    CIImage *beginImage;
    CIFilter * filter;
    
    UIImageView *apImageView;
}

@end

@implementation SnowflakeFallingView

/**
 *  <#Description#>
 *
 *  @param bgImageName   bgImageName 背景图片
 *  @param snowImageName snowImageName 雪花图片
 *  @param frame         frame 视图的位置和大小
 *
 *  @return view        需要绘制的视图
 */
+ (instancetype) snowfladeFallingViewWithBackgroundImageName:(UIImage *) bgImageName snowImageName:(NSString *)snowImageName initWithFrame:(CGRect)frame{
    
    SnowflakeFallingView *view = [[SnowflakeFallingView alloc] initWithFrame:frame];
  
    view.bgImageView.image = bgImageName;
    view.snowImgName = snowImageName;
    
    return  view;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        
        //添加背景图片的imageview
        self.bgImageView = [[UIImageView alloc] init];
        self.bgImageView.frame = self.bounds;
        self.bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.bgImageView];
        
        
        apImageView=[[UIImageView alloc]initWithFrame:self.bgImageView.bounds];
        apImageView.backgroundColor=[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.2];
        [self.bgImageView addSubview:apImageView];
       
    }
    return self;
}

//开始下雪
- (void) beginShow{
    
    //启动定时器,使得一直调用setNeedsDisplay从而调用- (void) drawRect:(CGRect )rect
    //不得手动调用- (void) drawRect:(CGRect )rect
    link = [CADisplayLink displayLinkWithTarget:self selector:@selector(setNeedsDisplay)];
    //让定时器循环调用
    [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
  
    [self performSelector:@selector(removeLink) withObject:nil afterDelay:0.5];
    
    beginImage = [CIImage imageWithCGImage:self.bgImageView.image.CGImage];
    NSLog(@"这个为空%@",beginImage);
    filter = [CIFilter filterWithName:@"CIColorControls"];
    [filter setValue:beginImage forKey:kCIInputImageKey];
    
}

-(void)removeLink{
    
    
    ///////////////给背景图片增加饱和度等
    
    //  饱和度      0---2
    [filter setValue:[NSNumber numberWithFloat:1.3] forKey:@"inputSaturation"];
//    //  亮度  10   -1---1
//    [filter setValue:[NSNumber numberWithFloat:0.5] forKey:@"inputBrightness"];
//    //  对比度 -11  0---4
//    [filter setValue:[NSNumber numberWithFloat:2] forKey:@"inputContrast"];
    
    // 得到过滤后的图片
    CIImage *outputImage = [filter outputImage];
    // 转换图片, 创建基于GPU的CIContext对象
    CIContext *context = [CIContext contextWithOptions: nil];
    CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *newImg = [UIImage imageWithCGImage:cgimg];
    NSLog(@"新图片%@",cgimg);
    
    // 显示图片
    [self.bgImageView setImage:newImg];
    // 释放C对象
    CGImageRelease(cgimg);
    
    if (self.finishAnimotianBlock) {
        self.finishAnimotianBlock(newImg);
    }
    
    [link invalidate];
}

- (void) drawRect:(CGRect)rect {
    
    //控制雪花最多的个数
    if (self.subviews.count >1000) {
        return;
    }
    
    //雪花的宽度
    int width = arc4random() % 5;
    while (width < 1) {
        width = arc4random() % 5;
    }
    //雪花的速度
//    int speed = arc4random() % 10;
//    while (speed < 5) {
//        speed = arc4random() % 10;
//    }
    
    int speed =1;
    //雪花起点y
    int startY =  (arc4random() % (int)self.bounds.size.height);
    //雪花起点x
    int startX = -arc4random() %20;
    //雪花终点x
    int endY = arc4random() % (int) self.bounds.size.height;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_snowImgName]];
    imageView.backgroundColor=[UIColor whiteColor];
    imageView.layer.borderWidth=1.0;
    imageView.layer.borderColor=[UIColor whiteColor].CGColor;
    imageView.alpha=0.8;
    imageView.frame = CGRectMake(startX, startY, width, width);
    imageView.layer.cornerRadius=width/2.0f;
    imageView.layer.masksToBounds=YES;
    [self addSubview:imageView];
    
    
    //设置动画
    [UIView animateWithDuration:speed animations:^{
        //设置雪花最终的frame
        imageView.frame = CGRectMake(self.bounds.size.width+20,endY , width, width);
        //设置雪花的旋转
        imageView.transform = CGAffineTransformRotate(imageView.transform, M_PI);
        //设置雪花透明度,使得雪花快落地的时候就像快消失的一样
        imageView.alpha = 0.4;
        
        apImageView.frame=CGRectMake(self.bgImageView.bounds.size.width, 0, 0, self.bgImageView.bounds.size.height);
        
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
        [apImageView removeFromSuperview];
        
    }];
    
    
}

@end
