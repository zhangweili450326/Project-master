//
//  SubjectsDetailController.m
//  JudgePlants
//
//  Created by itm on 2017/7/20.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "SubjectsDetailController.h"
#import "SDCycleScrollView.h"
#import "SizeTool.h"
@interface SubjectsDetailController ()
@property (nonatomic,strong) UITableView *tv;
@property (nonatomic,strong) UIView *view_foot;
@property (nonatomic,strong) SDCycleScrollView *headView;
@property (nonatomic,strong) UILabel *lbl_title;
@property (nonatomic,strong) UILabel *lbl_nickName;

@property (nonatomic,assign) CGFloat nickHeigh;

@property (nonatomic,strong) UILabel *textView;

@property (nonatomic,strong) UIButton *btn_collection;
@end

@implementation SubjectsDetailController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.lbl_navTitle.text=@"百科详情";
    [self initTableView];
    [self initLabelTitle];
}
-(void)initTableView{
    
    _tv=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) style:UITableViewStylePlain];
    [self.view addSubview:_tv];
    _tv.showsVerticalScrollIndicator=NO;
    
    NSArray *arrIamge=@[@"wait_ader1",@"me_imageBack",@"wait_ader2"];
    _headView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0, Screen_Width, K_SCWIDTH*200) imageURLStringsGroup:arrIamge];
    __weak id weakSelf=self;
    _headView.delegate=weakSelf;
    _headView.pageControlStyle=SDCycleScrollViewPageContolStyleClassic;
    _headView.currentPageDotColor=UIColorFromRGB(colorGreen);
    _headView.pageDotColor=[UIColor whiteColor];
    _tv.tableHeaderView=_headView;
    
    _view_foot=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, self.view.height-K_SCWIDTH*200)];
    _tv.tableFooterView=_view_foot;
}

-(void)initLabelTitle{
    
    _lbl_title=[[UILabel alloc]initWithFrame:CGRectMake(20,0, Screen_Width-100, 50)];
    [_view_foot addSubview:_lbl_title];
    
    NSMutableAttributedString *strTitle = [[NSMutableAttributedString alloc] initWithString:@"红叶石楠"];
    [strTitle addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:25] range:NSMakeRange(0,[strTitle length])];
    _lbl_title.attributedText=strTitle;
    
    _btn_collection=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width-80, _lbl_title.y, 60, _lbl_title.height)];
    [_btn_collection setTitleColor:UIColorFromRGB(colorTextLightColor) forState:UIControlStateNormal];
    [_btn_collection setImage:[UIImage imageNamed:@"subject_collection"] forState:UIControlStateNormal];
    _btn_collection.titleLabel.font=[UIFont systemFontOfSize:15];
    [_btn_collection setTitle:@" 1000" forState:UIControlStateNormal];
    [_btn_collection bk_addEventHandler:^(id sender) {
        
    } forControlEvents:UIControlEventTouchUpInside];
    [_view_foot addSubview:_btn_collection];
    
    UIView *view_line=[[UIView alloc]initWithFrame:CGRectMake(20, 50, Screen_Width-40, 1)];
    view_line.backgroundColor=UIColorFromRGB(colorGroupViewColor);
    [_view_foot addSubview:view_line];
    
    _lbl_nickName=[[UILabel alloc]init];
    _lbl_nickName.font=[UIFont systemFontOfSize:15];
    _lbl_nickName.numberOfLines=0;
    _lbl_nickName.textColor=UIColorFromRGB(colorTextLightColor);
    [_view_foot addSubview:_lbl_nickName];
    
    UILabel *lbl_bie=[[UILabel alloc]initWithFrame:CGRectMake(20, K_SCWIDTH*50+8,50, 25)];
    lbl_bie.textColor=UIColorFromRGB(colorTextLightColor);
    lbl_bie.textAlignment=NSTextAlignmentCenter;
    lbl_bie.font=[UIFont systemFontOfSize:15];
    lbl_bie.layer.borderWidth=1;
    lbl_bie.layer.borderColor=UIColorFromRGB(colorTextLightColor).CGColor;
    lbl_bie.text=@"别称";
    [_view_foot addSubview:lbl_bie];
    
    
    _textView=[[UILabel alloc]init];
    _textView.font=[UIFont systemFontOfSize:15];
    _textView.numberOfLines=0;
    _textView.textColor=UIColorFromRGB(colorGray666666);
    [_view_foot addSubview:_textView];
    
    
    
    [self changeTextFrame];
}

-(void)changeTextFrame{
    NSString *strNickName=@"          火焰红、千年红、红罗宾、红唇、酸叶石楠、酸椰树、千年红、红罗宾、红唇、酸叶石楠、酸椰树";
    CGSize size=[SizeTool sizeTofitWithTitle:strNickName fontAmount:15 width:Screen_Width-40];
    _nickHeigh=size.height+10;
    _lbl_nickName.frame=CGRectMake(20,  K_SCWIDTH*60, Screen_Width-40, size.height+10);
    _lbl_nickName.attributedText=[[NSAttributedString alloc]initWithString:strNickName];
    [UILabel changeSpaceForLabel:_lbl_nickName withLineSpace:8 WordSpace:2];
    
    NSString *detail=@"红叶石楠 （学名：Photiniax fraseri）是蔷薇科石楠属杂交种的统称，为常绿小乔木，叶革质，长椭圆形至倒卵披针形，春季新叶红艳，夏季转绿，秋、冬、春三季呈现红色，霜重色逾浓，低温色更佳。\n做行道树，其杆立如火把；做绿篱，其状卧如火龙；修剪造景，形状可千姿百态，景观效果美丽。 红叶石楠因其新梢和嫩叶鲜红而得名。常见的有红罗宾和红唇两个品种，其中红罗宾的叶色鲜艳夺目，观赏性更佳。春秋两季，红叶石楠的新梢和嫩叶火红，色彩艳丽持久，极具生机。在夏季高温时节，叶片转为亮绿色，给人清新凉爽之感觉。红叶石楠因其鲜红色的新梢和嫩叶而得名，其栽培变种很多。";
    
    
    CGSize sizeB=[SizeTool sizeTofitWithTitle:detail fontAmount:15 width:Screen_Width-40];
    
    _textView.frame=CGRectMake(20, K_SCWIDTH*50+_nickHeigh+30, Screen_Width-40, size.height+20);
    _view_foot.size=CGSizeMake(Screen_Width, K_SCWIDTH*50+_nickHeigh+30+sizeB.height+sizeB.height/15*6);
    
    NSMutableAttributedString *strMayApply = [[NSMutableAttributedString alloc] initWithString:detail];
   
    _textView.attributedText=strMayApply;
   
    [UILabel changeTextSpaceForLabel:_textView withLineSpace:6 WordSpace:1 WithSomeTextColor:UIColorFromRGB(0x5992ca) ColorRange:NSMakeRange(9, 17) withSomeTextFont:[UIFont systemFontOfSize:19] FontRange:NSMakeRange(9, 17)];

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
