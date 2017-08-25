//
//  SetViewController.m
//  JudgePlants
//
//  Created by itm on 2017/6/29.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "SetViewController.h"
#import "MeInformationController.h"
#import "IdeaFeedBackController.h"
#import "ChangePhoneController.h"
#import "AccountSafeController.h"
@interface SetViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tv;
    NSArray *arr_data;
}
@property (nonatomic,strong) UISwitch *switchButton;
@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.lbl_navTitle.text=@"设置";
    arr_data=@[@[@"个人信息",@"账号安全",@"消息提醒设置",@"修改手机"],
               @[@"意见反馈",@"关于直达人",@"去评分"]];
    [self initTableView];
}
    
-(void)initTableView{
    tv=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) style:UITableViewStyleGrouped];
    tv.showsVerticalScrollIndicator=NO;
    tv.dataSource=self;
    tv.delegate=self;
    tv.rowHeight=K_SCWIDTH*50;
    [self.view addSubview:tv];
        
    UIView *viewfoot=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 100)];
    UIButton *btn_back_login=[[UIButton alloc]initWithFrame:CGRectMake(0, 15, Screen_Width, K_SCWIDTH*50)];
    [btn_back_login setTitle:@"退出登录" forState:UIControlStateNormal];
    [btn_back_login setTitleColor:UIColorFromRGB(0xfc5f62) forState:UIControlStateNormal];
    [btn_back_login addTarget:self action:@selector(btn_back_login) forControlEvents:UIControlEventTouchUpInside];
    btn_back_login.backgroundColor=[UIColor whiteColor];
    [viewfoot addSubview:btn_back_login];
    tv.tableFooterView=viewfoot;
    
    _switchButton = [[UISwitch alloc] init];
    [_switchButton setOn:YES];
    [_switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    
}

-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        NSLog(@"是");
    }else {
        NSLog(@"否");
    }
}
    
-(void)btn_back_login{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示"message:@"是否确定退出登录" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定"style:UIAlertActionStyleDestructive handler:^(UIAlertAction*action) {  }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleCancel handler:^(UIAlertAction*action) {    }]];
    [self presentViewController:alert animated:YES completion:nil];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arr_data[section] count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return arr_data.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
        return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 4;
    }
    return 8;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=[[UITableViewCell alloc]init];
   
    cell.textLabel.text=arr_data[indexPath.section][indexPath.row];
    
    if (indexPath.section==0&&indexPath.row==2) {
        
        [cell.contentView addSubview:_switchButton];
        [_switchButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell.contentView).offset(35);
            make.centerY.equalTo(cell.contentView);
            make.width.mas_equalTo(@100);
        }];
      
    }else{
         cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}
    
    
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView performSelector:@selector(deselectRowAtIndexPath:animated:) withObject:indexPath afterDelay:.1];
    
    if (indexPath.section==0) {
        
        switch (indexPath.row) {
            case 0:
            {
                MeInformationController *controller=[[MeInformationController alloc]init];
                [self.navigationController pushViewController:controller animated:YES];
            }
                break;
            case 1:
            {
                AccountSafeController *controller=[[AccountSafeController alloc]init];
                [self.navigationController pushViewController:controller animated:YES];
            }
                break;
                
            case 3:
            {
                ChangePhoneController *controller=[[ChangePhoneController alloc]init];
                [self.navigationController pushViewController:controller animated:YES];
            }
                break;
                
            default:
                break;
        }
    }
    
    if (indexPath.section==1) {
        
        switch (indexPath.row) {
            case 0:
            {
                IdeaFeedBackController *controller=[[IdeaFeedBackController alloc]init];
                [self.navigationController pushViewController:controller animated:YES];
            }
                break;
                
            case 1:{
                
            }
                break;
                
                case 2:
            {
//                [self resetAppReviewManager];
                
                // The AppID is the only required setup
                [UAAppReviewManager setAppID:@"995565009"]; // iBooks
                
                // Debug means that it will popup on the next available change
                [UAAppReviewManager setDebug:YES];
                
                // YES here means it is ok to show, it is the only override to Debug == YES.
                [UAAppReviewManager userDidSignificantEvent:YES];
            }
                break;
            default:
                break;
        }
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
