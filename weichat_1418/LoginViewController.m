//  LoginViewController.m
//  weichat_1418
//
//  Created by zhangcheng on 14-9-23.
//  Copyright (c) 2014年 zhangcheng. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController1.h"
#import "MainTabBarController.h"
@interface LoginViewController ()<UITextFieldDelegate>
{
//logo
    UIImageView*logoImageView;
//用户名
    UITextField*_userName;
//密码
    UITextField*_passWord;
//基础一个View，用于弹出键盘和消失键盘一起移动logo和输入框
    UIView*bgView;
//注册按钮
    UIButton*registerButton;
//登陆按钮
    UIButton*loginButton;
}
@end

@implementation LoginViewController

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
    [self createView];
    //观察键盘弹出和消失
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
}
#pragma mark 弹出键盘
-(void)keyboardShow:(NSNotification*)notification{
//计算键盘高度
    float y=[[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    [UIView animateWithDuration:0.3 animations:^{
        bgView.center=CGPointMake(bgView.center.x, bgView.center.y-y/2);
        logoImageView.transform=CGAffineTransformMakeScale(0, 0);
        
        
    }];
    
}
#pragma mark 隐藏键盘
-(void)keyboardHide:(NSNotification*)notification{

    [UIView animateWithDuration:0.3 animations:^{
        bgView.frame=self.view.frame;
        logoImageView.transform=CGAffineTransformMakeScale(1, 1);
    }];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //所有textField结束编辑放弃第一响应对象
    [self.view endEditing:YES];
}

-(void)createView{

    bgView=[ZCControl viewWithFrame:self.view.frame];
    //给View设置颜色 从这张图片上汲取颜色，作为背景色
    bgView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"logo_bg_2@2x.png"]];
    [self.view addSubview:bgView];
    //设置logo
    logoImageView=[ZCControl createImageViewWithFrame:CGRectMake(0, 0, 120, 120) ImageName:@"logo_2.png"];
    //圆角
    logoImageView.layer.cornerRadius=60;
    //设置裁剪
    logoImageView.layer.masksToBounds=YES;
    //设置logo的中心点位置
    int x=self.view.frame.size.width/2;
    int y=80;
    logoImageView.center=CGPointMake(x, y);
    
    [bgView addSubview:logoImageView];
    
    //输入框的背景图片
    UIImageView*bigImageView=[ZCControl createImageViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width-20, 120) ImageName:@"login.png"];
    y=220;
    bigImageView.center=CGPointMake(x, y);
    [bgView addSubview:bigImageView];
    
    //创建输入框
    UIImageView*userNameImageView=[ZCControl createImageViewWithFrame:CGRectMake(5, 5, 20, 20) ImageName:@"userName.png"];
    UIView*userTempView=[ZCControl viewWithFrame:CGRectMake(0, 0, 40, 30)];
    [userTempView addSubview:userNameImageView];
    _userName=[ZCControl createTextFieldWithFrame:CGRectMake(10, 20, bigImageView.frame.size.width-10, 30) placeholder:@"请输入用户名" passWord:NO leftImageView:userTempView rightImageView:nil Font:15 backgRoundImageName:nil];
    
    [bigImageView addSubview:_userName];
    
    
    //密码
    UIImageView*passImageView=[ZCControl createImageViewWithFrame:CGRectMake(5, 5, 20, 20) ImageName:@"passWord.png"];
    UIView*passTempView=[ZCControl viewWithFrame:CGRectMake(0, 0, 40, 30)];
    [passTempView addSubview:passImageView];
    
    _passWord=[ZCControl createTextFieldWithFrame:CGRectMake(10, 80, bigImageView.frame.size.width-10, 30) placeholder:@"请输入密码" passWord:YES leftImageView:passTempView rightImageView:nil Font:15 backgRoundImageName:nil];
    [bigImageView addSubview:_passWord];
    
    //用户名与密码的返回按钮
    _userName.returnKeyType=UIReturnKeyNext;
    _passWord.returnKeyType=UIReturnKeyGo;
    //设置代理
    _userName.delegate=self;
    _passWord.delegate=self;
    registerButton=[ZCControl createButtonWithFrame:CGRectMake(0, 0, 80, 40) ImageName:nil Target:self Action:@selector(registerClick) Title:@"注册"];
    y=320;
    registerButton.center=CGPointMake(x-60, y);
    
    [bgView addSubview:registerButton];
    
    loginButton=[ZCControl createButtonWithFrame:CGRectMake(0, 0, 80, 40) ImageName:nil Target:self Action:@selector(loginClick) Title:@"登陆"];
    loginButton.center=CGPointMake(x+60, y);
    [bgView addSubview:loginButton];
    
    
}
#pragma mark 登陆
-(void)loginClick{
    [self.view endEditing:YES];
    if (_userName.text.length>0&&_passWord.text.length>0) {
        //执行登陆
        NSUserDefaults*user=[NSUserDefaults standardUserDefaults];
        [user setObject:_userName.text forKey:kXMPPmyJID];
        [user setObject:_passWord.text forKey:kXMPPmyPassword];
        [user synchronize];
        //实例化xmpp管理类
        [[ZCXMPPManager sharedInstance] connectLogoin:^(BOOL succeed) {
            if (succeed) {
                NSLog(@"登陆成功");
                
                
                MainTabBarController*tbc=[[MainTabBarController alloc]init];
                [self presentViewController:tbc animated:YES completion:^{
                    NSUserDefaults*user=[NSUserDefaults standardUserDefaults];
                    [user setObject:isLogin forKey:isLogin];
                    [user synchronize];

                }];
                
                
            }else{
                NSLog(@"密码错误或者用户名不存在");
                UIAlertView*al=[[UIAlertView alloc]initWithTitle:@"提示" message:@"密码错误或者用户名不存在" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [al show];
            
            }
        }];
        
        
        
    }else{
        UIAlertView*al=[[UIAlertView alloc]initWithTitle:@"提示" message:@" 请填写完整" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [al show];
    
    }
    
    
}
#pragma mark 注册
-(void)registerClick{
    RegisterViewController1*vc=[[RegisterViewController1 alloc]init];
    //设置模态跳转时候的动画
    vc.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
    UINavigationController*nc=[[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:nc animated:YES completion:nil];

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==_userName) {
        //成为第一响应对象
        [_passWord becomeFirstResponder];
    }else{
        [self loginClick];
    }
    
    
    return YES;

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
