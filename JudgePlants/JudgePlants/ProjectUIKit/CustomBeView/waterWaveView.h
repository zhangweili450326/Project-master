//
//  waterWaveView.h
//  ttttt
//
//  Created by zwl on 17/3/2.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface waterWaveView : UIView

/*sin函数
 *
 正弦型函数解析式：y=Asin（ωx+φ）+h
 各常数值对函数图像的影响：
 φ（初相位）：决定波形与X轴位置关系或横向移动距离（左加右减）
 ω：决定周期（最小正周期T=2π/|ω|）
 A：决定峰值（即纵向拉伸压缩的倍数）
 h：表示波形在Y轴的位置关系或纵向移动距离（上加下减）
 *
*/

/*最后我们的公式如下：
CGFloat y = _waveHeight*sinf(2.5*M_PI*i/_waveWidth + 3*_offset*M_PI/_waveWidth + M_PI/4) + _h;
*/

//波纹颜色
@property (nonatomic,strong) UIColor *waveColor;


//波速度
@property (nonatomic,assign) CGFloat waveSpeed;

//波宽
@property (nonatomic,assign) CGFloat waveWidth;

//波高
@property (nonatomic,assign) CGFloat waveHeight;

//倍数
@property (nonatomic,assign) CGFloat waveAmplitude;

//白色波纹的位置
@property (nonatomic,assign) CGFloat offsetXT;

-(void)createLayer;

- (void)splashWater;
- (void)stopSplashWater;

@end
