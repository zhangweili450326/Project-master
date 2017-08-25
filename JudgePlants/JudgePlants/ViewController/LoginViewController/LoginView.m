//
//  LoginView.m
//  JudgePlants
//
//  Created by itm on 2017/6/30.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "LoginView.h"
#import "RevolveButton.h"
@interface LoginView (){
   
    UIImageView *img_back;
    
    RevolveButton *btn_login;
    
    UIButton *btn_verify;
    
    UIButton *btn_close;
    
    UITapGestureRecognizer *tap;
    
    UIWindow *tempWindow;
    
    CustomTextField *text_login;
    CustomTextField *text_secret;
    
    UILabel *lbl_agree;
}

@end

@implementation LoginView
IMP_SINGLETON

//+(instancetype)shareInstance
//{
//    static LoginView *loginView = nil;
//    
//    static dispatch_once_t onceToken;
//    
//    dispatch_once(&onceToken, ^{
//        
//        loginView= [[LoginView alloc] init];
//        
//    });
//    
//    return loginView;
//    
//}

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    self.frame=CGRectMake(0, Screen_Height, Screen_Width, Screen_Height);
    if (self) {
        self.backgroundColor=[UIColor groupTableViewBackgroundColor];
        
        img_back=[[UIImageView alloc]initWithFrame:self.bounds];
        img_back.image=[UIImage imageNamed:@"login_background"];
        img_back.userInteractionEnabled=YES;
        [self addSubview:img_back];
        
        btn_close=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width-50,20,44, 44)];
        [btn_close setImage:[UIImage imageNamed:@"login_close"]  forState:UIControlStateNormal];
        [btn_close addTarget:self action:@selector(btn_close) forControlEvents:UIControlEventTouchUpInside];
        
        [img_back addSubview:btn_close];
        
        UIImageView *image_title=[[UIImageView alloc]init];
        image_title.image=[UIImage imageNamed:@"login_title"];
        image_title.size=CGSizeMake(K_SCWIDTH*180, K_SCWIDTH*60);
        image_title.center=CGPointMake(self.centerX, 90+K_SCWIDTH*30);
        [img_back addSubview:image_title];
        
        
        UILabel *lbl_phone=[[UILabel alloc]initWithFrame:CGRectMake(K_SCWIDTH*35,180, 60, 47)];
        lbl_phone.textColor=UIColorFromRGB(0x333333);
        lbl_phone.font=[UIFont systemFontOfSize:16];
        lbl_phone.text=@"手机号";
        [img_back addSubview:lbl_phone];
        
        text_login=[[CustomTextField alloc]initWithFrame:CGRectMake(K_SCWIDTH*35+60, 180, Screen_Width-K_SCWIDTH*70-60, 47)];
        text_login.font=[UIFont systemFontOfSize:16];
        text_login.placeholder=@"请输入手机号";
        text_login.clearButtonMode=UITextFieldViewModeWhileEditing;
        text_login.keyboardType=UIKeyboardTypeNumberPad;
        [img_back addSubview:text_login];
        
        UIView *view_line_top=[[UIView alloc]initWithFrame:CGRectMake(K_SCWIDTH*35, 227, Screen_Width-K_SCWIDTH*70, 1)];
        view_line_top.backgroundColor=UIColorFromRGB(0xb3babd);
        [img_back addSubview:view_line_top];
        
        
        UILabel *lbl_verify=[[UILabel alloc]initWithFrame:CGRectMake(K_SCWIDTH*35,228, 60, 47)];
        lbl_verify.textColor=UIColorFromRGB(0x333333);
        lbl_verify.font=[UIFont systemFontOfSize:16];
        lbl_verify.text=@"验证码";
        [img_back addSubview:lbl_verify];
        
        btn_verify=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width-90-K_SCWIDTH*35, 228+9, 90, 30)];
        btn_verify.accepEventInterval=3;
        btn_verify.layer.borderWidth=1.0;
        btn_verify.layer.borderColor=UIColorFromRGB(0x3acca1).CGColor;
        btn_verify.layer.cornerRadius=30/2;
        [btn_verify setTitle:@"获取验证码" forState:UIControlStateNormal];
        btn_verify.titleLabel.font=[UIFont systemFontOfSize:12];
        [btn_verify setTitleColor:UIColorFromRGB(0x3acca1) forState:UIControlStateNormal];
        [btn_verify addTarget:self action:@selector(btnVerify) forControlEvents:UIControlEventTouchUpInside];
        [img_back addSubview:btn_verify];
        
        text_secret=[[CustomTextField alloc]initWithFrame:CGRectMake(K_SCWIDTH*35+60, 228,Screen_Width-K_SCWIDTH*70-150, 47)];
        text_secret.font=[UIFont systemFontOfSize:16];
        text_secret.placeholder=@"请输入验证码";
        text_secret.clearButtonMode=UITextFieldViewModeWhileEditing;
        text_secret.keyboardType=UIKeyboardTypeNumberPad;
        [img_back addSubview:text_secret];
        
        UIView *view_line_mid=[[UIView alloc]initWithFrame:CGRectMake(K_SCWIDTH*35, 275, Screen_Width-K_SCWIDTH*70, 1)];
        view_line_mid.backgroundColor=UIColorFromRGB(0xb3babd);
        [img_back addSubview:view_line_mid];
        
        
        btn_login=[[RevolveButton alloc]initWithFrame:CGRectMake(K_SCWIDTH*35, 310, Screen_Width-K_SCWIDTH*70, 40)];
        btn_login.titleLabel.font=[UIFont systemFontOfSize:15];
        [btn_login setBackgroundColor:UIColorFromRGB(0x3acca1)];
        [btn_login setTitle:@"登录" forState:UIControlStateNormal];
        [btn_login addTarget:self action:@selector(btn_login) forControlEvents:UIControlEventTouchUpInside];
        btn_login.layer.cornerRadius=20.0;
        [img_back addSubview:btn_login];
        
        lbl_agree=[[UILabel alloc]initWithFrame:CGRectMake(K_SCWIDTH*35, 370, Screen_Width-K_SCWIDTH*70, 15)];
        lbl_agree.textColor=UIColorFromRGB(colorTextLightColor);
        lbl_agree.font=[UIFont systemFontOfSize:13];
        lbl_agree.textAlignment=NSTextAlignmentCenter;
        [img_back addSubview:lbl_agree];
        
        NSMutableAttributedString *strAgree = [[NSMutableAttributedString alloc] initWithString:@"点击登录代表同意《植达人用户协议》"];
        [strAgree addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x3acca1) range:NSMakeRange([strAgree length]-9,9)];
        lbl_agree.attributedText=strAgree;
        
        [lbl_agree addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAgree)]];
        
        
        UIButton *btn_wx=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/2-K_SCWIDTH*70, Screen_Height-K_SCWIDTH*75,K_SCWIDTH*50,K_SCWIDTH*50)];
        [btn_wx setBackgroundImage:[UIImage imageNamed:@"login_wx"] forState:UIControlStateNormal];
        [btn_wx addTarget:self action:@selector(btnLoginWX) forControlEvents:UIControlEventTouchUpInside];
        [img_back addSubview:btn_wx];
        
        UIButton *btn_qq=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/2+K_SCWIDTH*20, Screen_Height-K_SCWIDTH*75, K_SCWIDTH*50, K_SCWIDTH*50)];
        [btn_qq setBackgroundImage:[UIImage imageNamed:@"login_qq"] forState:UIControlStateNormal];
        [btn_qq addTarget:self action:@selector(btnLoginQQ) forControlEvents:UIControlEventTouchUpInside];
        [img_back addSubview:btn_qq];
        
        UIView *view_left=[[UIView alloc]initWithFrame:CGRectMake(K_SCWIDTH*35, btn_wx.y-17, Screen_Width/2-K_SCWIDTH*95, 1)];
        view_left.backgroundColor=UIColorFromRGB(0xb3babd);
        [img_back addSubview:view_left];
        
        UIView *view_right=[[UIView alloc]initWithFrame:CGRectMake(K_SCWIDTH*60+Screen_Width/2, btn_wx.y-17, Screen_Width/2-K_SCWIDTH*95, 1)];
        view_right.backgroundColor=UIColorFromRGB(0xb3babd);
        [img_back addSubview:view_right];
        
        UILabel *lbl_login=[[UILabel alloc]init];
        lbl_login.textAlignment=NSTextAlignmentCenter;
        lbl_login.font=[UIFont systemFontOfSize:13];
        lbl_login.textColor=UIColorFromRGB(colorTextLightColor);
        lbl_login.text=@"第三方登录";
        lbl_login.size=CGSizeMake(K_SCWIDTH*120, 14);
        lbl_login.center=CGPointMake(img_back.centerX, view_left.centerY);
        [img_back addSubview:lbl_login];
        
    }
    
    return self;
}


-(void)pleaseGotoLogin
{
    [UIView animateWithDuration:0.3 animations:^{
    self.frame=CGRectMake(0,0,Screen_Width, Screen_Height);
    }];
  
    if ([[UIApplication sharedApplication].keyWindow isMemberOfClass:[UIWindow class]]) {
        tempWindow = [UIApplication sharedApplication].keyWindow;
    }
    else{
        tempWindow = [UIApplication sharedApplication].windows[[UIApplication sharedApplication].windows.count-2];
    }
    
//    tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_close:)];
//    
//    [tempWindow addGestureRecognizer:tap];
    
    [tempWindow addSubview:self];
    
}

-(void)btnLoginQQ{
    
}

-(void)btnLoginWX{
    [btn_login stopLoadingAnimation];
}

-(void)tapAgree{
    
}

-(void)btn_login
{
    [btn_login startLoadingAnimation];
}

-(void)btnVerify{
    [self getCode];
}

-(void)getCode{
    __block int timeout = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [btn_verify setTitle:@"重新发送" forState:UIControlStateNormal];
                [btn_verify setTitleColor:UIColorFromRGB(0x3acca1) forState:UIControlStateNormal];
                btn_verify.userInteractionEnabled = YES;
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [btn_verify setTitle:[NSString stringWithFormat:@"%@秒后重发",strTime] forState:UIControlStateNormal];
                [btn_verify setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                btn_verify.userInteractionEnabled = NO;
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
}


-(void)btn_close
{
    
    [self removeAlertView];
}

//-(void)tap_close:(UITapGestureRecognizer *)tap
//{
//    [self removeAlertView];
//}

-(void)removeAlertView{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.frame=CGRectMake(0,Screen_Height, Screen_Width,Screen_Height);
      
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        [tempWindow removeGestureRecognizer:tap];
    }];
    
}

-(UIViewController *) findBestViewController:(UIViewController *)vc {
    if (vc.presentedViewController) {
        // Return presented view controller
        return [self findBestViewController:vc.presentedViewController];
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        // Return right hand side
        UISplitViewController *svc = (UISplitViewController *) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        // Return top view
        UINavigationController *svc = (UINavigationController *) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.topViewController];
        else
            return vc;
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        // Return visible view
        UITabBarController *svc = (UITabBarController *) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.selectedViewController];
        else
            return vc;
    } else {
        // Unknown view controller type, return last child view controller
        return vc;
    }
}
-(UIViewController *) currentViewController {
    // Find best view controller
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self findBestViewController:viewController];
}


@end
