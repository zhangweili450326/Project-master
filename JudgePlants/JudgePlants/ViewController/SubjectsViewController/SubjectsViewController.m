//
//  SubjectsViewController.m
//  JudgePlants
//
//  Created by itm on 2017/6/19.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "SubjectsViewController.h"
#import "SubjectsTableViewCell.h"
#import "SubjectsCollectionLayout.h"
#import "SubjectionsCollectionCell.h"
#import "SubjectsDetailController.h"

@interface SubjectsViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>{
    SubjectsCollectionLayout *layout;
    UICollectionView *colletionView;
}
@property (nonatomic,strong) UITableView *tv;
@property (nonatomic,strong) UIImageView *img_head;
@property (nonatomic,strong) UIView *view_foot;
@end

@implementation SubjectsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavigationBar];
    [self initTableView];
    [self initcollectionView];
    [self refreshLoginData];
}

-(void)refreshLoginData{
    LoginUserModel *model1=[SotrageTool getUserInfomationFromKeyChain];
    NSLog(@"电话号码%@--名字%@---%@",model1.iphone,model1.userName,model1.imgName);
}


-(void)initNavigationBar{
    
    self.lbl_navTitle.text=@"植物鉴定";
   
    [self.navigationItem setHidesBackButton:YES];
    self.navigationItem.leftBarButtonItem=nil;
    [self.btn_navRight setImage:[UIImage imageNamed:@"subject_search"] forState:UIControlStateNormal];
    [self.btn_navRight bk_addEventHandler:^(id sender) {
     NSLog(@"搜索");
    } forControlEvents:UIControlEventTouchUpInside];
}

-(void)initTableView{
    _tv=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tv.dataSource=self;
    _tv.delegate=self;
    [self.view addSubview:_tv];
    _tv.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tv.estimatedRowHeight = 250;//很重要保障滑动流畅性
    _tv.rowHeight=UITableViewAutomaticDimension;
    _img_head=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, K_SCWIDTH*125)];
    _img_head.image=[UIImage imageNamed:@"subject_banner"];
    _tv.tableHeaderView=_img_head;
    _view_foot=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 250+20)];
   
    _view_foot.userInteractionEnabled=YES;
    _tv.tableFooterView=_view_foot;
    
    [_tv registerNib:[UINib nibWithNibName:NSStringFromClass([SubjectsTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SubjectsTableViewCell class])];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 44)];
    NSArray *arr_name=@[@"百科知识",@"百科专题"];
    UIView *viewGreen=[[UIView alloc]initWithFrame:CGRectMake(0, 12, 3, 20)];
    viewGreen.backgroundColor=UIColorFromRGB(colorGreen);
    [view addSubview:viewGreen];
    
    UILabel *lblName=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, view.width-15, view.height)];
    lblName.textColor=UIColorFromRGB(colorGray666666);
    lblName.text=arr_name[section];
    lblName.font=[UIFont systemFontOfSize:14];
    [view addSubview:lblName];
    if (section==0) {
        view.backgroundColor=[UIColor whiteColor];
    }else{
        view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    }
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN ;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 2;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   SubjectsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SubjectsTableViewCell class])];
    cell.lbl_content.text=@"开发商今年多次找到4S店，表示不愿意继续租给他们，要他们搬家。但谁也没想到，双方还没达成解除合同的协议，金源居然把他们的房子推倒了，里面还有大量的装修和设备呢，损失金额高达3000多万元。";
    [UILabel changeSpaceForLabel:cell.lbl_content withLineSpace:4 WordSpace:2];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView performSelector:@selector(deselectRowAtIndexPath:animated:) withObject:indexPath afterDelay:0.2];
    SubjectsDetailController *controller=[[SubjectsDetailController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}


-(void)initcollectionView{
    
    layout=[[SubjectsCollectionLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    colletionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0,0, Screen_Width, _view_foot.height-20) collectionViewLayout:layout];
    
    colletionView.delegate=self;
    colletionView.dataSource=self;
    colletionView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    colletionView.showsHorizontalScrollIndicator = NO;
    [_view_foot addSubview:colletionView];
    
    [colletionView registerNib:[UINib nibWithNibName:@"SubjectionsCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"cocell"];
}

#pragma mark  UICollectionDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SubjectionsCollectionCell *cell=[colletionView dequeueReusableCellWithReuseIdentifier:@"cocell" forIndexPath:indexPath];
  
    cell.layer.cornerRadius=5.0;
    cell.layer.masksToBounds=YES;
    cell.btn_check.layer.borderColor=UIColorFromRGB(colorGreen).CGColor;
    cell.btn_check.layer.cornerRadius=5.0;
    cell.btn_check.layer.borderWidth=1.0;
    [cell.btn_check setTitleColor:UIColorFromRGB(colorGreen) forState:UIControlStateNormal];
    cell.lbl_content.attributedText=[[NSAttributedString alloc]initWithString:@"7月19日，林志玲、郭敬明在某活动同台，身穿单肩长裙的志玲姐姐一展女汉子本色，在台上一把抱起郭敬明，踩着高跟鞋转圈圈!看起来很轻松，笑得也是十分欢畅，这画面真是太美了!值得收藏啊"];
    [UILabel changeSpaceForLabel:cell.lbl_content withLineSpace:4 WordSpace:2];
    return cell;
}


#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(250, 250);
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   
}


-(UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 20,0, 20);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 20;
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
