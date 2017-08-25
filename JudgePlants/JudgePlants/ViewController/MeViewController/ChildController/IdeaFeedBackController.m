//
//  IdeaFeedBackController.m
//  JudgePlants
//
//  Created by itm on 2017/7/19.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "IdeaFeedBackController.h"
#import "CustomTextView.h"
#import "CustomTextField.h"
#import "RevolveButton.h"
@interface IdeaFeedBackController ()

@property (nonatomic,strong)CustomTextView *textView;

@property (nonatomic,strong)CustomTextField *textField;

@property (nonatomic,strong)RevolveButton *btn_sub;

@end

@implementation IdeaFeedBackController

-(void)loadView{
    [super loadView];
    
   UIScrollView* _scrollView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.view=_scrollView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.lbl_navTitle.text=@"意见反馈";
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self initText];
    [self initSubmitButton];
    
}

-(void)initText{
    
   _textView=[[CustomTextView alloc]initWithFrame:CGRectMake(15,16, Screen_Width-30, K_SCWIDTH*180)];
    _textView.backgroundColor=[UIColor whiteColor];
    _textView.font=[UIFont systemFontOfSize:17];
    _textView.layer.cornerRadius=3.0;
    _textView.xx_placeholderFont = [UIFont systemFontOfSize:16.0f];
    _textView.xx_placeholderColor = UIColorFromRGB(colorTextLightColor);
    _textView.xx_placeholder=@"请描述您遇到的问题或建议";
    [self.view addSubview:_textView];
    
    UILabel *lbl_phone=[[UILabel alloc]initWithFrame:CGRectMake(_textView.x, _textView.height+_textView.y, Screen_Width-80,40)];
    lbl_phone.textColor=UIColorFromRGB(colorGray666666);
    lbl_phone.adjustsFontSizeToFitWidth=YES;
    [self.view addSubview:lbl_phone];
  
    NSMutableAttributedString *strGreen = [[NSMutableAttributedString alloc] initWithString:@"请留下您的联系方式,以便我们及时联系！ (选填)"];
    [strGreen addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(colorGreen) range:NSMakeRange([strGreen length]-4,4)];
    lbl_phone.attributedText=strGreen;
    
    _textField=[[CustomTextField alloc]initWithFrame:CGRectMake(_textView.x, lbl_phone.height+lbl_phone.y, Screen_Width-30,50)];
    _textField.backgroundColor=[UIColor whiteColor];
    _textField.layer.cornerRadius=3.0;
    _textField.placeholder=@"手机/微信/QQ邮箱";
    [self.view addSubview:_textField];
    
    _textField.leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, _textField.height)];
    _textField.leftViewMode=UITextFieldViewModeAlways;
}

-(void)initSubmitButton{
    
    _btn_sub=[[RevolveButton alloc]initWithFrame:CGRectMake(30, _textField.y+_textField.height+25, Screen_Width-60, 50)];
    _btn_sub.titleLabel.font=[UIFont systemFontOfSize:15];
    [_btn_sub setBackgroundColor:UIColorFromRGB(0x3acca1)];
    [_btn_sub setTitle:@"提交" forState:UIControlStateNormal];
    [_btn_sub addTarget:self action:@selector(btnSub) forControlEvents:UIControlEventTouchUpInside];
    _btn_sub.layer.cornerRadius=25.0;
    [self.view addSubview:_btn_sub];
    
    
    UILabel *lbl_tishi=[[UILabel alloc]initWithFrame:CGRectMake(_btn_sub.x, _btn_sub.height+_btn_sub.y, _btn_sub.width,40)];
    lbl_tishi.textColor=UIColorFromRGB(colorGray666666);
    lbl_tishi.textAlignment=NSTextAlignmentCenter;
    lbl_tishi.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:lbl_tishi];
    
    NSMutableAttributedString *strGreen = [[NSMutableAttributedString alloc] initWithString:@"*植达人客服热线: 400-000-0000"];
    [strGreen addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(colorGreen) range:NSMakeRange([strGreen length]-12,12)];
    lbl_tishi.attributedText=strGreen;
}

-(void)btnSub{
    
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
