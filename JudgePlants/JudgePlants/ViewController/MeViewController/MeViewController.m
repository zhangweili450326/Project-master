//
//  MeViewController.m
//  JudgePlants
//
//  Created by itm on 2017/6/19.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "MeViewController.h"
#import "UINavigationBar+Background.h"
#import "SetViewController.h"
#import "RevolveButton.h"
#import "MeHeadView.h"
#import "LoadingView.h"
#import "MeTableCell.h"
#import "MeContentModel.h"
#import "MejoinViewController.h"
#import "MeCollectionController.h"
#import "MessageViewController.h"
#import <RKNotificationHub.h>
@interface MeViewController ()<UITableViewDelegate,UITableViewDataSource,protocolMeDelegate>{
    RevolveButton *button;
    UIButton *btn_set;
   
}
@property (nonatomic,assign) CGFloat headerView_Height;
@property (nonatomic,strong) UITableView *tv;
@property (nonatomic,assign) CGFloat offSY;
@property (nonatomic,assign) CGFloat cellHeigh;
@property (nonatomic,strong) NSMutableArray *arr_data;
@end

@implementation MeViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;//导航栏的背景色是黑色, 字体为白色
   
    UIColor *color = [UIColor colorWithRed:45/255.0 green:45/255.0 blue:45/255.0 alpha:1];
    if (_offSY<10) {
       
        [self.navigationController.navigationBar cnSetBackgroundColor:[color colorWithAlphaComponent:0]];
    }else{
        CGFloat alpha = MIN(1, _offSY/(_headerView_Height - 64));
        [self.navigationController.navigationBar cnSetBackgroundColor:[color colorWithAlphaComponent:alpha]];
    }
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar cnReset];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavagationBar];
    
    [self initTableView];

    [self initModel];
}

-(void)initNavagationBar{
    
    
    [self.navigationController.navigationBar cnSetBackgroundColor:[UIColor clearColor]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
   
    [self.btn_navLeft setImage:[UIImage imageNamed:@"me_set"] forState:UIControlStateNormal];
    [self.btn_navLeft bk_addEventHandler:^(id sender) {
        SetViewController *controller=[[SetViewController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    
 
    [self.btn_navRight setImage:[UIImage imageNamed:@"me_message"] forState:UIControlStateNormal];
 
    [self.btn_navRight bk_addEventHandler:^(id sender) {
        MessageViewController *controller=[[MessageViewController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    RKNotificationHub* hub = [[RKNotificationHub alloc]initWithView:self.btn_navRight]; // sets the count to 0
    [hub setCircleAtFrame:CGRectMake(self.btn_navRight.width-15, 0, 20, 20)];
    [hub incrementBy:520];
    [hub pop];
    self.lbl_navTitle.text=@"我的";
    self.lbl_navTitle.textColor=[UIColor whiteColor];
    [self.navigationController.navigationBar bringSubviewToFront:self.lbl_navTitle];
}

-(void)initModel{
    _arr_data=[[NSMutableArray alloc]init];
    NSArray *arr=@[@"绿萝,发财树,长青,喇叭花4,玫瑰,梧桐树,紫金花",
                   @"长青,喇叭花5,玫瑰,梧桐树",
                   @"绿萝,发财树,长青,喇叭花,玫瑰7",
                   @"喇叭花,玫瑰2,梧桐树,紫金花",
                   @"绿萝,发财树,长青,喇叭花,玫瑰3,梧桐树,紫金花,绿萝,发财树,长青,喇叭花,玫瑰,梧桐树,紫金花",
                   @"绿萝,发财树,长青,喇叭花5,玫瑰,梧桐树",
                   @"绿萝,发财树8"];
    for (int i=0; i<7; i++) {
        MeContentModel *model=[[MeContentModel alloc]init];
        model.img=@"me_imageBack";
        model.time=[NSString stringWithFormat:@"%@\n十一月",@(i+3)];
        model.title=@"“无名植物”,大神鉴定中...";
        model.str_arr=arr[i];
        [_arr_data addObject:model];
    }
    [_tv reloadData];
    
}

-(void)initTableView{
    _tv=[[UITableView alloc]initWithFrame:CGRectMake(0, 0,Screen_Width, Screen_Height-49) style:UITableViewStylePlain];
    _tv.backgroundColor=UIColorFromRGB(colorGroupViewColor);
    _tv.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tv.dataSource=self;
    _tv.delegate=self;
    [self.view addSubview:_tv];
    
    MeHeadView *meHead=[[MeHeadView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, K_SCWIDTH*270+70)];
    _headerView_Height=meHead.height;
    meHead.delegate=self;
    _tv.tableHeaderView=meHead;
    _tv.tableFooterView=[[UIView alloc]init];
    
    [meHead setModel:@[@"10",@"9",@"5"]];
    
    [_tv registerClass:[MeTableCell class] forCellReuseIdentifier:NSStringFromClass([MeTableCell class])];
    
}

-(void)btn_click:(RevolveButton *)sender{
    
    [sender startLoadingAnimation];
    [self performSelector:@selector(stopD) withObject:nil afterDelay:4];
    [[LoginView sharedInstance] pleaseGotoLogin];
}
-(void)stopD{
    [button stopLoadingAnimation];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arr_data.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return _cellHeigh;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MeTableCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MeTableCell class])];
   cell.model=_arr_data[indexPath.row];
   _cellHeigh=cell.cellHeigh;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView performSelector:@selector(deselectRowAtIndexPath:animated:) withObject:indexPath afterDelay:0.2];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    UIColor *color = [UIColor colorWithRed:45/255.0 green:45/255.0 blue:45/255.0 alpha:1];
    CGFloat offsetY = scrollView.contentOffset.y;
   
    _offSY=offsetY;
    if (offsetY >0) {
        CGFloat alpha = MIN(1, offsetY/(_headerView_Height - 64));
        
        [self.navigationController.navigationBar cnSetBackgroundColor:[color colorWithAlphaComponent:alpha]];
        
        //_descriptionView.alpha = 1 - alpha;
    } else {
        [self.navigationController.navigationBar cnSetBackgroundColor:[color colorWithAlphaComponent:0]];
    }
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
  
    
    UIColor *color = [UIColor colorWithRed:45/255.0 green:45/255.0 blue:45/255.0 alpha:1];
    CGFloat offsetY = scrollView.contentOffset.y;
    _offSY=offsetY;
    if (offsetY >0) {
        CGFloat alpha = MIN(1, offsetY/(_headerView_Height - 64));
        
        [self.navigationController.navigationBar cnSetBackgroundColor:[color colorWithAlphaComponent:alpha]];
        
        //_descriptionView.alpha = 1 - alpha;
    } else {
        [self.navigationController.navigationBar cnSetBackgroundColor:[color colorWithAlphaComponent:0]];
    }
    

}

#pragma mark headViewDelegate
-(void)sendCollectionController{
    MeCollectionController *controller=[[MeCollectionController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)sendJoinController{
    MejoinViewController *controller=[[MejoinViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
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
