//
//  SexViewController.m
//  JudgePlants
//
//  Created by itm on 2017/7/19.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "SexViewController.h"
#import "SexTableViewCell.h"
@interface SexViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tv;
@property (nonatomic,strong) NSArray *arr;

@end

@implementation SexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.lbl_navTitle.text=@"性别";
    _arr=@[@"男",@"女"];
    [self initTableView];
}

-(void)initTableView{
    _tv=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tv.backgroundColor=[UIColor groupTableViewBackgroundColor];
    _tv.delegate=self;
    _tv.dataSource=self;
    [self.view addSubview:_tv];
    _tv.tableFooterView=[[UIView alloc]init];
    
    [_tv registerNib:[UINib nibWithNibName:@"SexTableViewCell" bundle:nil] forCellReuseIdentifier:@"SexTableViewCell"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SexTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SexTableViewCell"];
    cell.lbl_sex.text=_arr[indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
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
