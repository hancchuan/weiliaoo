//
//  ZCAppDelegate.m
//  weichat_1418
//
//  Created by zhangcheng on 14-9-23.
//  Copyright (c) 2014年 zhangcheng. All rights reserved.
//

#import "ZCAppDelegate.h"
#import "LoginViewController.h"
#import "ZipArchive.h"
#import "MainTabBarController.h"

@implementation ZCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
   /************程序进入统一修改的***********/
    //修改按钮的文字颜色
    [[UIButton appearance]setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    /***************************/
    
    /*程序第一次进入，需要移动主题包进入沙河目录*/
    NSUserDefaults*user=[NSUserDefaults standardUserDefaults];
    
    NSString*first=[user objectForKey:@"appfirst"];
    if (first==nil) {
        //程序第一次进入，我们需要把主题包压缩到沙盒目录中，但是需要注意的是不要放在Documents中，因为这样苹果审核无法通过，根据苹果审核指南，你需要存储在lib文件夹下，在lib文件夹下我们需要创建一个文件夹才可以,我们解压缩的时候，解压缩会自动帮我们创建一个文件夹
        NSString*filePath=[[NSBundle mainBundle]pathForResource:@"com" ofType:@"zip"];
        NSData*data=[NSData dataWithContentsOfFile:filePath];
        //把com.zip文件夹写入到lib文件夹下
        [data writeToFile:[NSString stringWithFormat:@"%@com.zip",LIBPATH] atomically:YES];
        
        //解压缩
        ZipArchive*zip=[[ZipArchive alloc]init];
        //这里绿色简约是解压缩后的文件夹名称
        NSString*unZipPath=[NSString stringWithFormat:@"%@绿色简约",LIBPATH];
        //打开文件
        [zip UnzipOpenFile:[NSString stringWithFormat:@"%@com.zip",LIBPATH]];
        //解压缩到指定路径
        [zip UnzipFileTo:unZipPath overWrite:YES];
        //关闭解压缩  需要注意的是只有执行关闭的时候，才能真正执行解压缩
        [zip UnzipCloseFile];

        //记录当前主题
        [user setObject:@"绿色简约" forKey:THEME];
        [user synchronize];
        //appfirst这个值可以是任意值，只是记录一下，表示程序不在是第一次进入了
        [user setObject:@"appfirst" forKey:@"appfirst"];
        [user synchronize];
    }
    
    
    
//    //明日需要修改
//    LoginViewController*login=[[LoginViewController alloc]init];
//    MainTabBarController*tbc=[[MainTabBarController alloc]init];
    
    
    /*
     登陆的逻辑
     第一次登陆，使用login，不是第一次登陆跳转主界面，主界面执行登陆函数
     不论是否是第一次登陆，都需要记录登陆成功，在下次登陆时候进行判断
     注册成功后，执行登陆，登陆成功后进行记录
     在主界面注销按钮，注销后，删除登陆成功记录，在下次登陆时候使用login
     */
    
    NSString*str=[user objectForKey:isLogin];
    if (str) {
        //已经登陆，直接进入主页面，在主页面中进行登陆
        MainTabBarController*tbc=[[MainTabBarController alloc]init];
        self.window.rootViewController=tbc;
    }else{
        LoginViewController*vc=[[LoginViewController alloc]init];
        self.window.rootViewController=vc;
    
    }
    
    /*
     记录是否登陆的逻辑
     在第一次登陆时候走loginViewController，会执行登陆操作，那么在最近联系人，就不需要执行登陆操作，这个时候我们通过判断isLogin，如果是空，则是通过loginViewController过来的，则不在最近联系人界面中执行登陆操作
     当最近联系人界面执行完成后，在模态跳转的block回调中执行记录isLogin的操作
     
     当之前登陆过，那么我们会直接进入到最近联系人界面，在最近联系人界面中，我们判断如果isLogin有值，则执行登陆操作，因为这个时候，我们是直接显示的最近界面，并不是通过loginViewController跳转过来的
     
     */
    
    
    
    
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
