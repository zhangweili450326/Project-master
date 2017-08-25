//
//  SnowflakeFallingView.h
//  fsdfsdfds
//
//  Created by zwl on 17/7/23.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SnowflakeFallingView : UIView

@property(nonatomic,strong) UIImageView *bgImageView;

@property(nonatomic,copy) NSString *snowImgName;

/**
 *  快速创建一个雪花飘落效果的view
 *
 *  @param bgImageName   背景图片的名称
 *  @param snowImageName 雪花图片的名称
 *  @param frame     frame
 *
 *  @return 实例化的 雪花飘落效果的view
 */
+ (instancetype) snowfladeFallingViewWithBackgroundImageName:(UIImage *) bgImageName snowImageName:(NSString *)snowImageName initWithFrame:(CGRect)frame;

//开始下雪
- (void) beginShow;

@property (nonatomic,copy) void (^finishAnimotianBlock)(UIImage *image);

@end
