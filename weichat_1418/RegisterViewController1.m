
//
//  RegisterViewController1.m
//  weichat_1418
//
//  Created by zhangcheng on 14-9-25.
//  Copyright (c) 2014年 zhangcheng. All rights reserved.
//

#import "RegisterViewController1.h"
#import "RegisterViewController2.h"
@interface RegisterViewController1 ()<UITextFieldDelegate>
{
    UILabel*userName;
    UILabel*infoLabel;
    UITextField*_textField;
    
}
@end

@implementation RegisterViewController1

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
    [self createNav];
    //设置背景色
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"logo_bg_2.png"]];
    //设置输入的内容
    [self createView];
    
    
}
-(void)createView{
    userName=[ZCControl createLabelWithFrame:CGRectMake(30, [ZCControl isIOS7], 200, 40) Font:15 Text:[NSString stringWithFormat:@"您的数字账号为：%ld",DTAETIME]];
    [self.view addSubview:userName];
    
    infoLabel=[ZCControl createLabelWithFrame:CGRectMake(30, [ZCControl isIOS7]+30, 200, 10) Font:5 Text:@"苍老师正在为您创建数字账号，不满意请点击重试，重新生成数字账号"];
    infoLabel.textColor=[UIColor grayColor];
    [self.view addSubview:infoLabel];
    
    UIButton*againButton=[ZCControl createButtonWithFrame:CGRectMake(320-60, [ZCControl isIOS7]+10, 44, 30) ImageName:nil Target:self Action:@selector(againClick) Title:@"重试"];
    [self.view addSubview:againButton];
    //创建输入框
    UIImageView*leftImageView=[ZCControl createImageViewWithFrame:CGRectMake(20, 10, 20, 20) ImageName:@"icon_register_name.png"];
    UIView*tempView=[ZCControl viewWithFrame:CGRectMake(0, 0, 60,40)];
    [tempView addSubview:leftImageView];
    
    
    _textField=[ZCControl createTextFieldWithFrame:CGRectMake(0, infoLabel.frame.origin.y+20, 320, 44) placeholder:@"请输入您的昵称" passWord:NO leftImageView:tempView rightImageView:nil Font:15 backgRoundImageName:nil];
    _textField.delegate=self;
    _textField.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_textField];
    
    
    

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self rightNavClick];
    return YES;
}

-(void)againClick{
    userName.text=[NSString stringWithFormat:@"您的数字账号为：%ld",DTAETIME];
}
//设置导航按钮
-(void)createNav{
    self.title=@"请输入昵称（1/4）";
    //设置左右导航按钮
    UIButton*leftButton=[ZCControl createButtonWithFrame:CGRectMake(0, 0, 44, 30) ImageName:@"header_leftbtn_black_nor.png" Target:self Action:@selector(leftNavClick) Title:@"返回"];
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    UIButton*rightButton=[ZCControl createButtonWithFrame:CGRectMake(0, 0, 60, 30) ImageName:nil Target:self Action:@selector(rightNavClick) Title:@"下一步"];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightButton];
}
//左导航触发的按钮
-(void)leftNavClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//右导航触发的按钮
-(void)rightNavClick{
    //收回键盘
    [self.view endEditing:YES];
    //判断输入框是否有内容
    if (_textField.text.length>0) {
        //有内容使用单例进行记录
        RegisterManager*manager=[RegisterManager shareManager];
        manager.userName=[userName.text substringFromIndex:8];
        manager.nickName=_textField.text;
        
        //然后push下一页
        RegisterViewController2*vc=[[RegisterViewController2 alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
        
        
        
    }else{
        UIAlertView*al=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入昵称" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [al show];
    }
    
    //需要注意一点~就是我们的注册界面，需要有一个用协议，你可以写注册即同意用户协议，这个必须有，否则上线审核无法通过
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
