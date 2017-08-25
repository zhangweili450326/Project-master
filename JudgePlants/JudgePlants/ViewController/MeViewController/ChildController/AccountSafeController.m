//
//  AccountSafeController.m
//  JudgePlants
//
//  Created by itm on 2017/7/19.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "AccountSafeController.h"

@interface AccountSafeController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tv;
@property (nonatomic,strong) NSArray *arr;

@end

@implementation AccountSafeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.lbl_navTitle.text=@"账号安全";
    _arr=@[@"手机绑定",@"微信绑定",@"QQ绑定"];
    [self initTableView];

}

-(void)initTableView{
    _tv=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tv.backgroundColor=[UIColor groupTableViewBackgroundColor];
    _tv.delegate=self;
    _tv.dataSource=self;
    [self.view addSubview:_tv];
    _tv.tableFooterView=[[UIView alloc]init];
    
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
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    if (indexPath.row==0) {
        cell.detailTextLabel.textColor=UIColorFromRGB(colorGreen);
        cell.detailTextLabel.text=@"15878781234";
    }else{
         cell.detailTextLabel.textColor=UIColorFromRGB(colorTextLightColor);
        cell.detailTextLabel.text=@"恩恩";
    }
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.text=_arr[indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
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
