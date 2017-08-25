//
//  UserNameViewController.m
//  JudgePlants
//
//  Created by itm on 2017/7/19.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "UserNameViewController.h"
#import "CustomTextField.h"
#import "RevolveButton.h"
@interface UserNameViewController ()
@property (nonatomic,strong) CustomTextField *textName;
@property (nonatomic,strong) RevolveButton * btn_sub;
@end

@implementation UserNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.lbl_navTitle.text=@"用户名";
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self initText];
    [self initSubmitButton];
}

-(void)initText{
    self.textName=[[CustomTextField alloc]initWithLength:10];
    self.textName.frame=CGRectMake(0,65, Screen_Width-80, 50);
    self.textName.backgroundColor=[UIColor whiteColor];
    self.textName.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.textName.text=self.userName;
    [self.textName becomeFirstResponder];
    [self.view addSubview:self.textName];
    
    UILabel *lbl_num = [[UILabel alloc] initWithFrame:CGRectMake(Screen_Width-80, self.textName.y,80,self.textName.height)];
    lbl_num.backgroundColor=[UIColor whiteColor];
    lbl_num.textColor=UIColorFromRGB(colorTextLightColor);
    lbl_num.font=[UIFont systemFontOfSize:15];
    lbl_num.textAlignment=NSTextAlignmentCenter;
    lbl_num.text=@"10字以内";
    [self.view addSubview:lbl_num];
    self.textName.leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, self.textName.height)];
    self.textName.leftViewMode=UITextFieldViewModeAlways;
    
}

-(void)initSubmitButton{
   
    _btn_sub=[[RevolveButton alloc]initWithFrame:CGRectMake(30, Screen_Height/2-25, Screen_Width-60, 50)];
    _btn_sub.titleLabel.font=[UIFont systemFontOfSize:15];
    [_btn_sub setBackgroundColor:UIColorFromRGB(0x3acca1)];
    [_btn_sub setTitle:@"提交" forState:UIControlStateNormal];
    [_btn_sub addTarget:self action:@selector(btnSub) forControlEvents:UIControlEventTouchUpInside];
    _btn_sub.layer.cornerRadius=25.0;
    [self.view addSubview:_btn_sub];
}

-(void)btnSub{
    [_btn_sub startLoadingAnimation];
    
    [self performSelector:@selector(finishAnimation) withObject:nil afterDelay:3];
}

-(void)finishAnimation{
    [_btn_sub stopLoadingAnimation];
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
