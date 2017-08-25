//
//  CCCameraViewController.h
//  CCCamera
//
//  Created by wsk on 16/8/22.
//  Copyright © 2016年 cyd. All rights reserved.
//

#import "RootViewController.h"

@interface CCCameraViewController :RootViewController

@property (nonatomic,assign) BOOL isShowPhoto;

@property (nonatomic, copy) void (^clickedCustomImage)(UIImage *);

@property (nonatomic, copy) void (^clickedCustomMedia)(NSURL *);

@end
