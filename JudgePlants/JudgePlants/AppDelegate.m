//
//  AppDelegate.m
//  JudgePlants
//
//  Created by itm on 2017/5/18.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "AppDelegate.h"
#import "IQKeyboardManager.h"
#import "MeTabBarController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
     [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    [[PhotoDB shareInstance] creteAllManageTable];
    
    MeTabBarController *controller=[[MeTabBarController alloc]init];
    controller.selectedIndex=2;
    controller.customTabBar.selectIndex = 2;
    self.window.backgroundColor=[UIColor whiteColor];
    self.window.rootViewController=controller;
    
    
    //键盘
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    
    [self reachNetWork];
    return YES;
}

-(void)reachNetWork{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStateChange) name:kReachabilityChangedNotification object:nil];
    _networkStatus = [Reachability reachabilityForInternetConnection];
    [_networkStatus startNotifier];
}

-(void)networkStateChange{
    
    // 1.检测wifi状态
    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    
    // 2.检测手机是否能上网络(WIFI\3G\2.5G)
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    // 3.判断网络状态
    if ([wifi currentReachabilityStatus] != NotReachable) { // 有wifi
        NSLog(@"有wifi");
    } else if ([conn currentReachabilityStatus] != NotReachable) { // 没有使用wifi, 使用手机自带网络进行上网
        NSLog(@"使用手机自带网络进行上网");
    } else { // 没有网络
        NSLog(@"没有网络");
       
    }

}

- (void)dealloc
{
    [self.networkStatus stopNotifier];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
