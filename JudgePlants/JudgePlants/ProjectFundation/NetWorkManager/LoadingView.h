//
//  LoadingView.h
//  HoldStars
//
//  Created by 张君宝 on 16/1/8.
//  Copyright © 2016年 海睿星巢文化. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView
{

    ///包含指示器和文字的view
    UIView *conerView;
    UIImageView *imgView;
}
///是否是加载在window上还是navagationBar上
@property (nonatomic) BOOL isLikeSynchro;

///显示加载框
- (void)show;

///关闭加载框
- (void)close;

///获取LoadingView单例,isLikeSynchro  Yes:类似同步，通过遮盖整个窗体实现 No:异步
+ (LoadingView *)shareLoadingView;

@end
