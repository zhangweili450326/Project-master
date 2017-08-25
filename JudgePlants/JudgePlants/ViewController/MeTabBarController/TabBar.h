//
//  TabBar.h
//  JudgePlants
//
//  Created by itm on 2017/6/19.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TabBar;

@protocol TabBarDelegate <NSObject>

@optional
- (void)tabBar:(TabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to;

@end

@interface TabBar : UIView

- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

@property (nonatomic,assign) NSInteger selectIndex;

@property (nonatomic, weak) id<TabBarDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *tabBarButtons;

@end
