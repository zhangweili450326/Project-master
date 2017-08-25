//
//  MeCollectionController.m
//  JudgePlants
//
//  Created by itm on 2017/7/20.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "MeCollectionController.h"
#import "MeCollectionTableCell.h"

@interface MeCollectionController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property (nonatomic,strong) UITableView *tv;

@end

@implementation MeCollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.lbl_navTitle.text=@"我的收藏";
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self initTableView];
   
}

-(void)initTableView{
    _tv=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tv.delegate=self;
    _tv.dataSource=self;
    _tv.emptyDataSetSource = self;
    _tv.emptyDataSetDelegate = self;
    _tv.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tv];
    self.tv.estimatedRowHeight = 130;//很重要保障滑动流畅性
    _tv.rowHeight=UITableViewAutomaticDimension;
    
    [_tv registerNib:[UINib nibWithNibName:@"MeCollectionTableCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MeCollectionTableCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.lbl_content.attributedText=[[NSAttributedString alloc]initWithString:@"楠木 为中亚热带常绿乔木，带有闪光色彩的桢楠并非真的金丝楠。"];
    [UILabel changeTextSpaceForLabel:cell.lbl_content withLineSpace:6 WordSpace:1 WithSomeTextColor:[UIColor blackColor] ColorRange:NSMakeRange(0, 2) withSomeTextFont:[UIFont systemFontOfSize:20] FontRange:NSMakeRange(0, 2)];
    
    [UILabel changeTextSpaceForLabel:cell.lbl_from withLineSpace:3 WordSpace:1 WithSomeTextColor:UIColorFromRGB(colorGreen) ColorRange:NSMakeRange(3, cell.lbl_from.text.length-3) withSomeTextFont:nil FontRange:NSMakeRange(0, 0)];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView performSelector:@selector(deselectRowAtIndexPath:animated:) withObject:indexPath afterDelay:0.2];
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
        text=@"收藏空空如也";
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
        text=@"赶紧去发现精彩内容吧~";
    }
    
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

-(CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView{
    return 15;
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
