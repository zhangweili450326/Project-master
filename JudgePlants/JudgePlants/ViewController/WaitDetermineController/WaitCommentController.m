//
//  WaitCommentController.m
//  JudgePlants
//
//  Created by itm on 2017/7/13.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "WaitCommentController.h"
#import "CustomTextField.h"
#import "ContentHeadView.h"
#import "PuBuModel.h"
#import "LbaleTitleCell.h"
#import "CommentTableViewCell.h"
#import "PlTextModel.h"
#import "CenterAnimationView.h"
@interface WaitCommentController ()<UITableViewDelegate,UITableViewDataSource,protocolChangeCellHeighDelegate>
@property (nonatomic,strong) UITableView *tv;
@property (nonatomic,strong) CustomTextField *text_pl;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,assign) CGFloat sectionHeigh;

@property (nonatomic,strong) NSMutableArray *arr_data;
@end

@implementation WaitCommentController


-(NSMutableArray *)arr_data{
    if (_arr_data==nil) {
        _arr_data=[[NSMutableArray alloc]init];
    }
    return _arr_data;
}

-(void)loadView{
    [super loadView];
    _scrollView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.view=_scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavigationBar];
    [self initTableView];
    [self initBottonView];
    
    [self initModel];
}

-(void)initNavigationBar{
    
    self.lbl_navTitle.text=@"植物鉴定";
    [self.btn_navRight setImage:[UIImage imageNamed:@"img_shared"] forState:UIControlStateNormal];
    [self.btn_navRight bk_addEventHandler:^(id sender) {
        
        CenterAnimationView *view = [[CenterAnimationView  alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
        view.fly_h = 350;
        view.fly_w = 250;
        
        [[UIApplication sharedApplication].keyWindow addSubview:view];
        
        [view startFly:FlyTypeUToD];
        
    } forControlEvents:UIControlEventTouchUpInside];

}

-(void)initModel{
    
    for (int i=0; i<8; i++) {
        PlTextModel *model=[PlTextModel new];
        
        model.img_head=[NSString stringWithFormat:@"00%@",@(i+1)];
        model.nickName=@"扎心了老铁";
        model.time=@"50分钟前";
        if (i%2==0) {
          model.content=@"据看看新闻报道，海南海口的李女士，是一名环卫工人，为了多赚钱点，她还做点小生意，平日的货款大多通过微信转账。";
        }else{
           model.content=@"问题竟出在12岁的儿子小龙身上。";
        }
        [self.arr_data addObject:model];
    }
    [_tv reloadData];
}

-(void)initTableView{
    _tv=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-K_SCWIDTH*50-64) style:UITableViewStyleGrouped];
    _tv.dataSource=self;
    _tv.delegate=self;

    [self.view addSubview:_tv];
    _tv.separatorStyle=UITableViewCellSeparatorStyleNone;
    ContentHeadView *head=[[ContentHeadView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, K_SCWIDTH*285+K_SCWIDTH*150)];
    head.model=_model;
    _tv.tableHeaderView=head;
    
    _tv.contentInset=UIEdgeInsetsMake(-K_SCWIDTH*150, 0, 0, 0);
    
    [_tv registerClass:[LbaleTitleCell class] forCellReuseIdentifier:NSStringFromClass([LbaleTitleCell class])];
    
    [_tv registerNib:[UINib nibWithNibName:NSStringFromClass([CommentTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CommentTableViewCell class])];
}

-(void)initBottonView{
    
    UIView *view_botton=[[UIView alloc]initWithFrame:CGRectMake(0, Screen_Height-K_SCWIDTH*50-64, Screen_Width, K_SCWIDTH*50)];
    view_botton.backgroundColor=UIColorFromRGB(colorGroupViewColor);
    view_botton.userInteractionEnabled=YES;
    [self.view addSubview:view_botton];
    
    _text_pl=[[CustomTextField alloc]initWithFrame:CGRectMake(10, K_SCWIDTH*8,Screen_Width-100, K_SCWIDTH*34)];
    _text_pl.backgroundColor=[UIColor whiteColor];
    _text_pl.font=[UIFont systemFontOfSize:14];
    _text_pl.layer.cornerRadius=3.0;
    _text_pl.clearButtonMode=UITextFieldViewModeWhileEditing;
    _text_pl.placeholder=@"简单说几句...";
    [view_botton addSubview:_text_pl];
    
    UIButton *btn_publish=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width-80, K_SCWIDTH*8, 70, K_SCWIDTH*34)];
    btn_publish.layer.cornerRadius=3.0;
    btn_publish.accepEventInterval=3.0;
    [btn_publish setTitle:@"发表" forState:UIControlStateNormal];
    btn_publish.backgroundColor=UIColorFromRGB(colorGreen);
    btn_publish.titleLabel.font=[UIFont systemFontOfSize:15];
    [btn_publish addTarget:self action:@selector(btnPublish) forControlEvents:UIControlEventTouchUpInside];
    [view_botton addSubview:btn_publish];
}

-(void)btnPublish{
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    return _arr_data.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        LbaleTitleCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LbaleTitleCell class])];
        __weak typeof(self)weakSelf=self;
        cell.delegate=weakSelf;
        cell.model=_model;
        return cell;
    }
    CommentTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CommentTableViewCell class])];
    cell.model=_arr_data[indexPath.row];
   
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return _sectionHeigh;
    }
    
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([CommentTableViewCell class]) configuration:^(CommentTableViewCell *cell) {
        cell.model=_arr_data[indexPath.row];
    }];
}

-(void)changeSectionCellHeigh:(CGFloat)heigh{
    _sectionHeigh=heigh;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView performSelector:@selector(deselectRowAtIndexPath:animated:) withObject:indexPath afterDelay:0.2];
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
