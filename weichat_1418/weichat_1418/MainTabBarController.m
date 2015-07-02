
//
//  MainTabBarController.m
//  weichat_1418
//
//  Created by zhangcheng on 14-9-26.
//  Copyright (c) 2014年 zhangcheng. All rights reserved.
//

#import "MainTabBarController.h"
#import "SettingViewController.h"
#import "NewsViewController.h"
#import "FriendViewController.h"
#import "RecentlyViewController.h"
@interface MainTabBarController ()
//记录当前主题
@property(nonatomic,copy)NSString*theme;
@end

@implementation MainTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createViewControllers];
    [self createTabbarItem];
    
    
}
-(void)createTabbarItem{
//先取主题风格，拼接地址
    NSUserDefaults*user=[NSUserDefaults standardUserDefaults];
    self.theme=[NSString stringWithFormat:@"%@%@",LIBPATH,[user objectForKey:THEME]];
    
    NSArray*selectImageName=@[@"tab_recent_press.png",@"tab_buddy_press.png",@"tab_qworld_press.png",@"tab_me_press.png"];
    NSArray*unSelectImageName=@[@"tab_recent_nor.png",@"tab_buddy_nor.png",@"tab_qworld_nor.png",@"tab_me_nor.png"];
    NSArray*titleArray=@[@"最近联系人",@"联系人",@"动态",@"个人设置"];
    
    if (iOS7) {
        for (int i=0; i<self.tabBar.items.count; i++) {
            UIImage*selectImage=[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",self.theme,selectImageName[i]]];
            selectImage=[selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            
            UIImage*unSelectImage=[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",self.theme,unSelectImageName[i]]];
            
            unSelectImage=[unSelectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            
            UITabBarItem*item=self.tabBar.items[i];
            item=[item initWithTitle:titleArray[i] image:selectImage selectedImage:unSelectImage];
        }
    }else{
        for (int i=0; i<self.tabBar.items.count; i++) {
             UIImage*selectImage=[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",self.theme,selectImageName[i]]];
            UIImage*unSelectImage=[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",self.theme,unSelectImageName [i]]];
            UITabBarItem*item=self.tabBar.items[i];
            [item setFinishedSelectedImage:selectImage withFinishedUnselectedImage:unSelectImage];
        }
    
    
    }
    

    [self.tabBar setBackgroundImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/tabbar_bg.png",self.theme]]];
    //去掉阴影线
    [self.tabBar setShadowImage:[[UIImage alloc]init]];
    
    //设置选中时候文字的颜色
    if (iOS7) {
        [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];

    }else{
        [[UITabBarItem appearance]setTitleTextAttributes:@{UITextAttributeTextColor: [UIColor whiteColor]} forState:UIControlStateSelected];
    
    }
    
    
    

}
-(void)createViewControllers{
    RecentlyViewController*vc1=[[RecentlyViewController alloc]init];
    vc1.title=@"最近联系人";
    UINavigationController*nc1=[[UINavigationController alloc]initWithRootViewController:vc1];
    
    FriendViewController*vc2=[[FriendViewController alloc]init];
    vc2.title=@"联系人";
    UINavigationController*nc2=[[UINavigationController alloc]initWithRootViewController:vc2];
    
    NewsViewController*vc3=[[NewsViewController alloc]init];
    vc3.title=@"动态";
    UINavigationController*nc3=[[UINavigationController alloc]initWithRootViewController:vc3];
    
    SettingViewController*vc4=[[SettingViewController alloc]init];
    vc4.title=@"个人设置";
    UINavigationController*nc4=[[UINavigationController alloc]initWithRootViewController:vc4];
    self.viewControllers=@[nc1,nc2,nc3,nc4];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
