//
//  MeInformationController.m
//  JudgePlants
//
//  Created by itm on 2017/7/19.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "MeInformationController.h"
#import "UserNameViewController.h"
#import "SexViewController.h"
@interface MeInformationController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tv;
@property (nonatomic,strong) NSArray *arr;

@property (nonatomic,strong) UIImageView *imgHead;

@end

@implementation MeInformationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.lbl_navTitle.text=@"个人信息";
    _arr=@[@"头像",@"用户名",@"性别"];
    [self initTableView];
}

-(void)initTableView{
    _tv=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tv.backgroundColor=[UIColor groupTableViewBackgroundColor];
    _tv.delegate=self;
    _tv.dataSource=self;
    [self.view addSubview:_tv];
    _tv.tableFooterView=[[UIView alloc]init];
    
    _imgHead=[[UIImageView alloc]init];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 80;
    }
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"cell%@",@(indexPath.row)]];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[NSString stringWithFormat:@"cell%@",@(indexPath.row)]];
    }
    if (indexPath.row==0) {
        [cell.contentView addSubview:_imgHead];
        
        [_imgHead mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell.contentView).offset(-15);
            make.centerY.equalTo(cell.contentView);
            make.width.and.height.mas_equalTo(@60);
            
        }];
        
        _imgHead.image=[UIImage imageNamed:@"me_default_head"];
        
    }else{
         cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextLabel.text=@"呵呵";
    }
    
    cell.textLabel.text=_arr[indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView performSelector:@selector(deselectRowAtIndexPath:animated:) withObject:indexPath afterDelay:0.2];
    
    switch (indexPath.row) {
        case 0:
            
            break;
            
        case 1:
        {
            UserNameViewController *controller=[[UserNameViewController alloc]init];
            controller.userName=@"haha";
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
            
        case 2:
        {
            SexViewController *controller=[[SexViewController alloc]init];
            controller.sex=@"1";
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
            
        default:
            break;
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
