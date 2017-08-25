//
//  AppDelegate.h
//  JudgePlants
//
//  Created by itm on 2017/5/18.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Reachability.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) Reachability *networkStatus;
@end

