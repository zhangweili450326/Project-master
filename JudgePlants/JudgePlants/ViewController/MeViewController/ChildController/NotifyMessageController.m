//
//  NotifyMessageController.m
//  JudgePlants
//
//  Created by itm on 2017/7/21.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "NotifyMessageController.h"
#import "NotifyPaiCell.h"
#import "NotitfyLabelCell.h"
#import "AppDelegate.h"
#import "MeTabBarController.h"
@interface NotifyMessageController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property (nonatomic,strong) UITableView *tv;

@end

@implementation NotifyMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavigationBar];
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self initTableView];
    [self loadData];
}

-(void)loadData{
    [[NetWorkManager sharedNetWorkManager] GETWithURL:ProjectUrl parameters:nil success:^(NSDictionary *dit) {
      
    } failure:^(NSString *error) {
        self.httpLoadFailure=error;
        [_tv reloadData];
    }];
    
}

-(void)initNavigationBar{
     self.lbl_navTitle.text=@"通知消息";
    [self.btn_navRight setImage:[UIImage imageNamed:@"me_popHome"] forState:UIControlStateNormal];
    [self.btn_navRight bk_addEventHandler:^(id sender) {
        
        AppDelegate *appdelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
        MeTabBarController *contro=[[MeTabBarController alloc]init];
        appdelegate.window.rootViewController=contro;
        contro.customTabBar.selectIndex=0;
        contro.selectedIndex=0;
        
    } forControlEvents:UIControlEventTouchUpInside];
}

-(void)initTableView{
    _tv=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tv.backgroundColor=[UIColor groupTableViewBackgroundColor];
    _tv.dataSource=self;
    _tv.delegate=self;
    _tv.emptyDataSetSource = self;
    _tv.emptyDataSetDelegate = self;
    _tv.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tv];
    self.tv.estimatedRowHeight = 66;//很重要保障滑动流畅性
    _tv.rowHeight=UITableViewAutomaticDimension;
    [_tv registerNib:[UINib nibWithNibName:@"NotifyPaiCell" bundle:nil] forCellReuseIdentifier:@"paicell"];
    [_tv registerNib:[UINib nibWithNibName:@"NotitfyLabelCell" bundle:nil] forCellReuseIdentifier:@"labelCell"];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UILabel *lbl_time=[[UILabel alloc]init];
    lbl_time.textColor=UIColorFromRGB(colorTextLightColor);
    lbl_time.textAlignment=NSTextAlignmentCenter;
    lbl_time.font=[UIFont systemFontOfSize:14];
    lbl_time.text=@"2017-04-25 13:20:10";
    return lbl_time;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section%2==0) {
        NotifyPaiCell *cell=[tableView dequeueReusableCellWithIdentifier:@"paicell"];
        cell.view_back.layer.cornerRadius=3.0;
        cell.view_back.layer.borderWidth=1.0;
        cell.view_back.layer.borderColor=UIColorFromRGB(colorBackLineColor).CGColor;
        cell.view_back.layer.masksToBounds=YES;
        
        cell.lbl_content.attributedText=[[NSAttributedString alloc]initWithString:@"欢迎使用植物达人，快来试试植物识别功能吧!!!!!!"];
        [UILabel changeLineSpaceForLabel:cell.lbl_content WithSpace:5];
        return cell;
    }else{
        NotitfyLabelCell *cell=[tableView dequeueReusableCellWithIdentifier:@"labelCell"];
        cell.view_back.layer.cornerRadius=3.0;
        cell.view_back.layer.borderWidth=1.0;
        cell.view_back.layer.borderColor=UIColorFromRGB(colorBackLineColor).CGColor;
        cell.view_back.layer.masksToBounds=YES;
        
        cell.lbl_content.attributedText=[[NSAttributedString alloc]initWithString:@"恭喜你，已经解锁植物识别功能！走起，让我们鉴别更多植物。"];
        [UILabel changeLineSpaceForLabel:cell.lbl_content WithSpace:5];
        return cell;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  没有数据时候显示的背景
// 空白页图片
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    
    UIImage *image;
  
    if ([self.netWorkStatus isEqualToString:NetWorkStatusNormal]&&self.httpLoadFailure!=nil) {
        image=[UIImage imageNamed:LoadFailureImage];
    }else if ([self.netWorkStatus isEqualToString:NetWorkStatusFailure]){
        image=[UIImage imageNamed:FailNetworkImage];

    }else{ //网络正常 请求成功没有数据
        image=[UIImage imageNamed:nothingDataImage];
    }
    return image;
}

// 图片的动画效果(默认为关闭,需要调用代理方法emptyDataSetShouldAnimateImageView进行开启)
- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"transform"];
    
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 1.0, 0.0)];
    
    animation.duration = 1.0;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}

// 标题文本，富文本样式
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text;
    
    if ([self.netWorkStatus isEqualToString:NetWorkStatusNormal]&&self.httpLoadFailure!=nil) {
        text=@"加载失败";
    }else if ([self.netWorkStatus isEqualToString:NetWorkStatusFailure]){
        text=@"网络异常";
    }else{ //网络正常 请求成功没有数据
       text=@"暂无新消息";
    }

    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

// 标题文本下面的详细描述，富文本样式
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text;
    
    if ([self.netWorkStatus isEqualToString:NetWorkStatusNormal]&&self.httpLoadFailure!=nil) {
        text=@"加载失败,请稍后再试";
    }else if ([self.netWorkStatus isEqualToString:NetWorkStatusFailure]){
        text=@"网络异常,请检查网络";
    }else{ //网络正常 请求成功没有数据
        text=@" ";
    }

    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}



// 是否 允许图片有动画效果，默认NO(设置为YES后,动画效果才会有效)
- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView{
    return YES;
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
