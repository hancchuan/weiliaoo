//
//  RegisterViewController3.m
//  weichat_1418
//
//  Created by zhangcheng on 14-9-25.
//  Copyright (c) 2014年 zhangcheng. All rights reserved.
//

#import "RegisterViewController3.h"
#import "RegisterViewController4.h"
@interface RegisterViewController3 ()<UITextFieldDelegate>
{
    UITextField*passWordTextField;
    UITextField*phoneNumTextField;

}
@end

@implementation RegisterViewController3

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
    [self createView];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"logo_bg_2.png"]];
    
    
    
    
}
#pragma mark 2个输入框
-(void)createView{
    UIImageView*passWordImageView=[ZCControl createImageViewWithFrame:CGRectMake(10, 10, 20, 20) ImageName:@"icon_register_password.png"];
    UIView*tempView=[ZCControl viewWithFrame:CGRectMake(0, 0, 40, 40)];
    [tempView addSubview:passWordImageView];
    
    passWordTextField=[ZCControl createTextFieldWithFrame:CGRectMake(0, [ZCControl isIOS7]+40, 320, 40) placeholder:@"设定密码" passWord:YES leftImageView:tempView rightImageView:nil Font:10 backgRoundImageName:nil];
    passWordTextField.backgroundColor=[UIColor whiteColor];
    passWordTextField.delegate=self;
    [self.view addSubview:passWordTextField];
    
    UIImageView*phoneNumImageView=[ZCControl createImageViewWithFrame:CGRectMake(10, 10, 20, 20) ImageName:@"icon_register_mobile.png"];
    UIView*tempView1=[ZCControl viewWithFrame:CGRectMake(0, 0, 40, 40)];
    [tempView1 addSubview:phoneNumImageView];
    
    phoneNumTextField=[ZCControl createTextFieldWithFrame:CGRectMake(0, [ZCControl isIOS7]+81, 320, 40) placeholder:@"设定手机号" passWord:NO leftImageView:tempView1 rightImageView:nil Font:10 backgRoundImageName:nil];
    phoneNumTextField.backgroundColor=[UIColor whiteColor];
    phoneNumTextField.delegate=self;
    [self.view addSubview:phoneNumTextField];
}
-(void)createNav{
    self.title=@"登陆信息（3/4）";
    //右边
    UIButton*rightNavButton=[ZCControl createButtonWithFrame:CGRectMake(0, 0, 60, 30) ImageName:nil Target:self Action:@selector(rightNavClick) Title:@"下一步"];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightNavButton];
}
#pragma mark 导航右按钮
-(void)rightNavClick{
    if (passWordTextField.text.length>0&&phoneNumTextField.text.length>0) {
        RegisterManager*manager=[RegisterManager shareManager];
        manager.passWord=passWordTextField.text;
        manager.phoneNum=phoneNumTextField.text;
        //push下一个界面
        RegisterViewController4*vc=[[RegisterViewController4 alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }else{
        UIAlertView*al=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请完善资料" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [al show];
    
    }
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
