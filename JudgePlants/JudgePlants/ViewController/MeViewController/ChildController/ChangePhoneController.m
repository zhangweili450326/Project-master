//
//  ChangePhoneController.m
//  JudgePlants
//
//  Created by itm on 2017/7/19.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "ChangePhoneController.h"
#import "RevolveButton.h"
@interface ChangePhoneController ()
{
    CustomTextField *text_login;
    CustomTextField *text_secret;
    UIButton *btn_verify;
    UIButton *btn_sure;
}
@end

@implementation ChangePhoneController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.lbl_navTitle.text=@"修改手机";
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self initUpView];
}

-(void)initUpView{
    
    UIView *viewUp=[[UIView alloc]initWithFrame:CGRectMake(0, 65, Screen_Width, 100)];
    viewUp.userInteractionEnabled=YES;
    viewUp.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:viewUp];
    
    UILabel *lbl_phone=[[UILabel alloc]initWithFrame:CGRectMake(K_SCWIDTH*20,0, 60, 50)];
    lbl_phone.textColor=UIColorFromRGB(0x333333);
    lbl_phone.font=[UIFont systemFontOfSize:16];
    lbl_phone.text=@"手机号";
    [viewUp addSubview:lbl_phone];
    
    text_login=[[CustomTextField alloc]initWithFrame:CGRectMake(K_SCWIDTH*20+60, 0, Screen_Width-K_SCWIDTH*40-60, 50)];
    text_login.font=[UIFont systemFontOfSize:16];
    text_login.placeholder=@"请输入手机号";
    text_login.clearButtonMode=UITextFieldViewModeWhileEditing;
    text_login.keyboardType=UIKeyboardTypeNumberPad;
    [viewUp addSubview:text_login];
    
    UIView *view_line_top=[[UIView alloc]initWithFrame:CGRectMake(K_SCWIDTH*20, 50, Screen_Width-K_SCWIDTH*40, 1)];
    view_line_top.backgroundColor=UIColorFromRGB(colorGroupViewColor);
    [viewUp addSubview:view_line_top];
    
    
    UILabel *lbl_verify=[[UILabel alloc]initWithFrame:CGRectMake(K_SCWIDTH*20,50, 60, 50)];
    lbl_verify.textColor=UIColorFromRGB(0x333333);
    lbl_verify.font=[UIFont systemFontOfSize:16];
    lbl_verify.text=@"验证码";
    [viewUp addSubview:lbl_verify];
    
    btn_verify=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width-90-K_SCWIDTH*20, 60, 90, 30)];
    btn_verify.accepEventInterval=3;
    btn_verify.layer.borderWidth=1.0;
    btn_verify.layer.borderColor=UIColorFromRGB(0x3acca1).CGColor;
    btn_verify.layer.cornerRadius=30/2;
    [btn_verify setTitle:@"获取验证码" forState:UIControlStateNormal];
    btn_verify.titleLabel.font=[UIFont systemFontOfSize:12];
    [btn_verify setTitleColor:UIColorFromRGB(0x3acca1) forState:UIControlStateNormal];
    [btn_verify addTarget:self action:@selector(btnVerify) forControlEvents:UIControlEventTouchUpInside];
    [viewUp addSubview:btn_verify];
    
    text_secret=[[CustomTextField alloc]initWithFrame:CGRectMake(K_SCWIDTH*20+60, 50,Screen_Width-K_SCWIDTH*40-150, 50)];
    text_secret.font=[UIFont systemFontOfSize:16];
    text_secret.placeholder=@"请输入验证码";
    text_secret.clearButtonMode=UITextFieldViewModeWhileEditing;
    text_secret.keyboardType=UIKeyboardTypeNumberPad;
    [viewUp addSubview:text_secret];
    
    
    btn_sure=[[RevolveButton alloc]initWithFrame:CGRectMake(K_SCWIDTH*35,150+65, Screen_Width-K_SCWIDTH*70, 50)];
    btn_sure.titleLabel.font=[UIFont systemFontOfSize:15];
    [btn_sure setBackgroundColor:UIColorFromRGB(0x3acca1)];
    [btn_sure setTitle:@"确定" forState:UIControlStateNormal];
    [btn_sure addTarget:self action:@selector(btnSure) forControlEvents:UIControlEventTouchUpInside];
    btn_sure.layer.cornerRadius=25.0;
    [self.view addSubview:btn_sure];
    
}

-(void)btnSure{
    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
