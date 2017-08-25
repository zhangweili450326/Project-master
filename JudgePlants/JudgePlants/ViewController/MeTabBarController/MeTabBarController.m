//
//  MeTabBarController.m
//  JudgePlants
//
//  Created by itm on 2017/6/19.
//  Copyright © 2017年 zwl. All rights reserved.
//

#import "MeTabBarController.h"
#import "TabBarButton.h"
#import "MeViewController.h"
#import "SubjectsViewController.h"
#import "CCCameraViewController.h"
#import "WaitDetermineController.h"
#import "PhotoLibraryController.h"
@interface MeTabBarController ()

@property(nonatomic,strong) PhotoLibraryController *firstController;

@property (nonatomic,strong)WaitDetermineController *secondController;

@property(nonatomic,strong) MeViewController *lastController;

@property(nonatomic,strong) CCCameraViewController *thirdController;

@property(nonatomic,strong) SubjectsViewController  *fourController;

@property(nonatomic,strong)UITabBarItem *imgTabBarItem;

@end

@implementation MeTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTabbar];
  
    [self setupAllChildViewControllers];
   
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 删除系统自动生成的UITabBarButton
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}


/**
 *  初始化tabbar
 */
- (void)setupTabbar
{
    TabBar *customTabBar = [[TabBar alloc] init];
    customTabBar.frame = self.tabBar.bounds;
    customTabBar.delegate = self;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
    
}

/**
 *  监听tabbar按钮的改变
 *  @param from   原来选中的位置
 *  @param to     最新选中的位置
 */
- (void)tabBar:(TabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to
{
    self.selectedIndex = to;
}

-(void)selectTheIMConversationList{
    int a=(int)self.selectedIndex;
    [self tabBar:self.customTabBar didSelectedButtonFrom:a to:4];
}

/**
 *  初始化所有的子控制器
 */
- (void)setupAllChildViewControllers{
    //1.
    self.firstController = [[PhotoLibraryController alloc] init];
   
    [self setupChildViewController:self.firstController  title:@"照片库" imageName:@"photo_no_select" selectedImageName:@"photo_select"];
    
    //2.
   
    _secondController=[[WaitDetermineController alloc]init];
    [self setupChildViewController:_secondController title:@"待鉴定" imageName:@"wait_no_select" selectedImageName:@"wait_select"];
    
    //3.
    _thirdController = [[CCCameraViewController alloc] init];
    [self setupChildViewController:_thirdController title:@"" imageName:@"photo_pai" selectedImageName:@"photo_pai"];
    
    //4.
    _fourController=[[SubjectsViewController alloc]init];
    
    [self setupChildViewController:_fourController title:@"百科" imageName:@"subject_no_select" selectedImageName:@"subject_select"];
    
    //5.
    _lastController = [[MeViewController alloc] init];
    [self setupChildViewController:_lastController title:@"我的" imageName:@"me_no_select" selectedImageName:@"me_select"];
    
    
    
}

/**
 *  初始化一个子控制器
 *
 *  @param childVc           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    
    for (UIView *view in childVc.tabBarController.tabBar.subviews) {
        
        if ([view isKindOfClass:[UIImage class]]) {
            
            [view removeFromSuperview];
            
        }else if ([view isKindOfClass:[UILabel class]])
        {
            [view removeFromSuperview];
            
        }
        
    }
    
    //设置导航控制器的title
    childVc.title = title;
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    
    childVc.tabBarItem.selectedImage = selectedImage;
 
    // 2.包装一个导航控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    // 3.添加tabbar内部的按钮
    [self.customTabBar addTabBarButtonWithItem:childVc.tabBarItem];
    
}

-(void)tabBarHidden
{
    self.tabBar.hidden=YES;
}

-(void)tabBarShow
{
    self.tabBar.hidden=NO;
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
