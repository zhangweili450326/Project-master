//
//  CenterAnimationView.h
//  JudgePlants
//
//  Created by itm on 2017/7/26.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <POP.h>
#import "waterWaveView.h"
typedef NS_ENUM(NSInteger, FlyType) {
    FlyTypeUToD     = 0,
    FlyTypeDToD     = 1,
};
@interface CenterAnimationView : UIView
@property (nonatomic, strong) UIView *flyView;
@property (nonatomic, assign) CGFloat fly_w;
@property (nonatomic, assign) CGFloat fly_h;

@property (nonatomic,strong) waterWaveView *waterView;

- (void)startFly:(FlyType)type;

@end
