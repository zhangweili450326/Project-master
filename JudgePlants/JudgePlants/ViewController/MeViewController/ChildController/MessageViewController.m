//
//  MessageViewController.m
//  JudgePlants
//
//  Created by itm on 2017/7/20.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageHeadCell.h"
#import "MessageRowCell.h"
#import "NotifyMessageController.h"
@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tv;

@end

@implementation MessageViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
}

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
    _tv.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tv];
    self.tv.estimatedRowHeight = 130;//很重要保障滑动流畅性
    _tv.rowHeight=UITableViewAutomaticDimension;
    
    [_tv registerNib:[UINib nibWithNibName:@"MessageRowCell" bundle:nil] forCellReuseIdentifier:@"cellRow"];
    [_tv registerNib:[UINib nibWithNibName:@"MessageHeadCell" bundle:nil] forCellReuseIdentifier:@"cellHead"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    return 6;
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
    if (indexPath.section==0) {
        MessageHeadCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellHead"];
        [UILabel changeSpaceForLabel:cell.lbl_content withLineSpace:5 WordSpace:1];
        return cell;
    }
    
    MessageRowCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellRow"];
    
    [UILabel changeTextSpaceForLabel:cell.lbl_name withLineSpace:3 WordSpace:1 WithSomeTextColor:UIColorFromRGB(colorTextBlue5894cc) ColorRange:NSMakeRange(0, 7) withSomeTextFont:[UIFont systemFontOfSize:17] FontRange:NSMakeRange(0, 7)];
    [UILabel changeTextSpaceForLabel:cell.lbl_content withLineSpace:6 WordSpace:2 WithSomeTextColor:nil ColorRange:NSMakeRange(0, 0) withSomeTextFont:nil FontRange:NSMakeRange(0, 0)];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView performSelector:@selector(deselectRowAtIndexPath:animated:) withObject:indexPath afterDelay:0.2];
    if (indexPath.section==0) {
        NotifyMessageController *controller=[[NotifyMessageController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    }
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
