//
//  MeTabBarController.h
//  JudgePlants
//
//  Created by itm on 2017/6/19.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBar.h"
@interface MeTabBarController : UITabBarController <TabBarDelegate>

/**
 *  自定义的tabbar
 */
@property (nonatomic, weak)TabBar *customTabBar;

-(void)tabBarShow;
-(void)tabBarHidden;

@end
