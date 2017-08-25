//
//  WaitDetermineController.m
//  JudgePlants
//
//  Created by itm on 2017/6/19.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "WaitDetermineController.h"
#import "WJY_WaterFallLayout.h"
#import "PuBuCell.h"
#import "PuBuModel.h"
#import "SDCycleScrollView.h"
#import "WaitCommentController.h"
#define CELLWIDTH (Screen_Width - 15) / 2

@interface WaitDetermineController ()<UICollectionViewDelegate,UICollectionViewDataSource,WaterLayoutDelegate>{
    //网格头部
    UIView *headerViews;
    SDCycleScrollView *_headView;
}
@property (nonatomic,strong)NSMutableArray *arr_data;
@property (nonatomic,strong)NSMutableArray *arr_heigh;
@property (nonatomic,strong)UICollectionView *collectionView;
@end

@implementation WaitDetermineController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=NO;
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
    [self creatCV];
    [self initModel];
    
    _collectionView.mj_header= [JPHeadAnimationRefresh headerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [_collectionView.mj_header endRefreshing];
        });
    }];
    

}

-(void)initModel{
    
    CGFloat maxheigh=0;
    
    for (int i=0; i<10; i++) {
        PuBuModel *model=[[PuBuModel alloc]init];
        if (i==9) {
            model.imgPic=@"010";
            model.imgIcon=@"010";
        }else{
            model.imgPic=[NSString stringWithFormat:@"00%@",@(i+1)];
            model.imgIcon=[NSString stringWithFormat:@"00%@",@(i+1)];
        };
        model.name=[NSString stringWithFormat:@"扎心了老铁%@",@(i+1)];
      
        if (i==0) {
            model.label_pl=@"";
            model.label=@"";
        }else if (i%2==0){
            model.label_pl=@"明月: 绿萝,Mose: 发财树发财发财发发发发发发发发,x小绵羊: 好可爱的揉揉--";
            model.label=@"绿萝,发财树,多肉,椰果,南瓜5,西瓜,哈密瓜9,椰子,火龙果,黄皮果树";
        }else{
             model.label_pl=@"明月: 绿萝,Mose: 发财树发财发财发发发发发发发发";
             model.label=@"绿萝,发财树";
        }
        
        if (i==8) {
            model.label=@"";
        }
        
        model.num=[NSString stringWithFormat:@"%@",@(i+998)];
      
        
        maxheigh=CELLWIDTH+40;
        if ([model.label length]>0) {
            maxheigh+=30;
        }
        if ([model.label_pl length]>0) {
            NSArray *arr=[model.label_pl componentsSeparatedByString:@","];
            if (arr.count==1) {
                maxheigh+=25;
            }else if (arr.count==2){
                maxheigh+=50;
            }else if (arr.count>=3){
                maxheigh+=75;
            }
        }
        [_arr_data addObject:model];
        [_arr_heigh addObject:@(maxheigh)];
    }
    [_collectionView reloadData];
}


#pragma mark 创建 UICollectionView
-(void)creatCV
{
    
    self.arr_data = [NSMutableArray array];
    self.arr_heigh=[NSMutableArray array];
    WJY_WaterFallLayout *waterFallLayout = [[WJY_WaterFallLayout alloc]init];
    waterFallLayout.lineCount = 2;
    waterFallLayout.verticalSpacing = 5;
    waterFallLayout.horizontalSpacing = 5;
    waterFallLayout.sectionInset = UIEdgeInsetsMake(K_SCWIDTH*190, 5, 5, 5);
    waterFallLayout.delegate=self;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,-20, Screen_Width, Screen_Height-49+20) collectionViewLayout:waterFallLayout];
    _collectionView.backgroundColor = UIColorFromRGB(colorGroupViewColor);
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[PuBuCell class] forCellWithReuseIdentifier:@"cell"];
    
    
    headerViews = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, K_SCWIDTH*190-5)];

    [_collectionView addSubview:headerViews];
    
    [self initHeadView];
}

-(void)initHeadView
{
    NSArray *arrIamge=@[@"wait_ader1",@"me_imageBack",@"wait_ader2"];
    _headView=[SDCycleScrollView cycleScrollViewWithFrame:headerViews.bounds imageURLStringsGroup:arrIamge];
    __weak id weakSelf=self;
    _headView.delegate=weakSelf;
    _headView.pageControlStyle=SDCycleScrollViewPageContolStyleClassic;
    _headView.currentPageDotColor=UIColorFromRGB(colorGreen);
    _headView.pageDotColor=[UIColor whiteColor];
    [headerViews addSubview:_headView];
}


#pragma mark -- UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  self.arr_data.count;
}


//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PuBuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (cell==nil) {
        cell=[[PuBuCell alloc]init];
    }
    cell.backgroundColor=[UIColor whiteColor];

    PuBuModel *model = _arr_data[indexPath.item];
    cell.model = model;
    cell.headBlock=^(NSString *str){
        

    };
    return cell;
    
}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((Screen_Width - 15) / 2,[self.arr_heigh[indexPath.item] floatValue]);
}

//定义每个UICollectionView 的 margin
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(10, 10, 10, 10);
//}

#pragma mark --UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WaitCommentController *controller=[[WaitCommentController alloc]init];
    controller.model=_arr_data[indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
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
