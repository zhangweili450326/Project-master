//
//  RootViewController.m
//  JudgePlants
//
//  Created by itm on 2017/5/18.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "RootViewController.h"
#import "MeTabBarController.h"
#import "AppDelegate.h"
@interface RootViewController ()
@property (nonatomic,strong)UIImageView *navigationBgView;

@end

@implementation RootViewController


-(void)viewWillAppear:(BOOL)animated
{
   
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];//用于去除导航栏的底线，也就是周围的边线
   
    if (self.navigationController.childViewControllers.count!=1) {
        
        MeTabBarController *tab=(MeTabBarController *)self.tabBarController;
        [tab tabBarHidden];
    }
    
    AppDelegate *appDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if([appDlg.networkStatus currentReachabilityStatus] != NotReachable ){
       //执行网络正常时的代码
        self.netWorkStatus=NetWorkStatusNormal;
    }else{
       //执行网络异常时的代码
        self.netWorkStatus=NetWorkStatusFailure;
     }
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    MeTabBarController *tab=(MeTabBarController *)self.tabBarController;
    [tab tabBarShow];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
//    self.navigationController.navigationBar.translucent=NO;
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
     
     [self.navigationController.navigationBar setShadowImage:[UIImage new]];//用于去除导航栏的底线，也就是周围的边线
    [self setNavigationBar];
    
   
}


-(void)setNavigationBar{
    
    _btn_navLeft=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [_btn_navLeft setImage:[UIImage imageNamed:@"nav_pop"] forState:UIControlStateNormal];
    _btn_navLeft.imageEdgeInsets=UIEdgeInsetsMake(0, -20, 0, 0);
    __weak typeof(self)weakSelf=self;
    [_btn_navLeft bk_addEventHandler:^(id sender) {
        [weakSelf.navigationController popViewControllerAnimated:YES];

    } forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:_btn_navLeft];
    
    
    
    _btn_navRight=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    _btn_navRight.imageEdgeInsets=UIEdgeInsetsMake(0, 20, 0, 0);
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:_btn_navRight];
    
    
    self.navigationBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width,44)];
    self.navigationBgView.userInteractionEnabled=YES;
    self.navigationItem.titleView = self.navigationBgView;
    
    _lbl_navTitle=[[UILabel alloc]initWithFrame:CGRectMake(80, 0, Screen_Width-160, 44)];
    _lbl_navTitle.textAlignment=NSTextAlignmentCenter;
    _lbl_navTitle.textColor=UIColorFromRGB(colorTextBlackColor);
    self.navigationItem.titleView=_lbl_navTitle;
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
