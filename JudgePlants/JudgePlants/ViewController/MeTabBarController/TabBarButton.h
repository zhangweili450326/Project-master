//
//  TabBarButton.h
//  JudgePlants
//
//  Created by itm on 2017/6/19.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BadgeButton.h"
@interface TabBarButton : UIButton

@property (nonatomic, strong) UITabBarItem *item;
@property (nonatomic,strong) BadgeButton *badgeButton;

@property (nonatomic,assign) NSInteger index;

@end
