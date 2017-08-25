//
//  PhotoAlertView.m
//  JudgePlants
//
//  Created by itm on 2017/7/27.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "PhotoAlertView.h"

@implementation PhotoAlertView
{
    UIButton *btn_alert;
}

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        btn_alert=[UIButton buttonWithType:UIButtonTypeCustom];
        btn_alert.titleLabel.font=[UIFont systemFontOfSize:15];
        [self addSubview:btn_alert];
        
    }
    return self;
}


+(instancetype)shareInstance
{
    static PhotoAlertView *_alertView = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _alertView = [[PhotoAlertView alloc] initWithFrame:CGRectMake(50, 0,[UIScreen mainScreen].bounds.size.width-100 , 40)];
    });
    
    return _alertView;
}
-(void)showAlertViewWithMessage:(NSString *)message andSuccess:(BOOL)status{
    
    [btn_alert setTitle:[NSString stringWithFormat:@"%@  ",message] forState:UIControlStateNormal];
    if (status==YES) {
        [btn_alert setImage:[UIImage imageNamed:@"smileFaceImage"] forState:UIControlStateNormal];
        self.backgroundColor=UIColorFromRGB(colorGreen);
    }else{
         [btn_alert setImage:[UIImage imageNamed:@"sadFaceImage"] forState:UIControlStateNormal];
        self.backgroundColor=[UIColor redColor];
    }
   
   
 
    
    UIWindow *tempWindow = [UIApplication sharedApplication].keyWindow;
    self.size= CGSizeMake(140, 40);
    self.center=tempWindow.center;
    self.alpha=1;
    self.layer.cornerRadius=20;
    self.layer.masksToBounds=YES;
    btn_alert.frame=self.bounds;
     [btn_alert setRightImage];
    
    [tempWindow addSubview:self];
  
    [self performSelector:@selector(removeAlertView) withObject:nil afterDelay:1.0f];
}



-(void)removeAlertView{
    
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha=0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
