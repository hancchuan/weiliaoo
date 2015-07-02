
//
//  RegisterViewController4.m
//  weichat_1418
//
//  Created by zhangcheng on 14-9-25.
//  Copyright (c) 2014年 zhangcheng. All rights reserved.
//

#import "RegisterViewController4.h"
#import "MainTabBarController.h"
@interface RegisterViewController4 ()<UITextFieldDelegate>
{
    UITextField*passWordTextField;
    UITextField*phoneNumTextField;
}
@end

@implementation RegisterViewController4

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
    UIImageView*passWordImageView=[ZCControl createImageViewWithFrame:CGRectMake(10, 10, 20, 20) ImageName:@"icon_edit.png"];
    UIView*tempView=[ZCControl viewWithFrame:CGRectMake(0, 0, 40, 40)];
    [tempView addSubview:passWordImageView];
    
    passWordTextField=[ZCControl createTextFieldWithFrame:CGRectMake(0, [ZCControl isIOS7]+40, 320, 40) placeholder:@"起一个狂拽炫酷屌炸天的签名" passWord:NO leftImageView:tempView rightImageView:nil Font:10 backgRoundImageName:nil];
    passWordTextField.backgroundColor=[UIColor whiteColor];
    passWordTextField.delegate=self;
    [self.view addSubview:passWordTextField];
    
    UIImageView*phoneNumImageView=[ZCControl createImageViewWithFrame:CGRectMake(10, 10, 20, 20) ImageName:@"feed_loc_new.png"];
    UIView*tempView1=[ZCControl viewWithFrame:CGRectMake(0, 0, 40, 40)];
    [tempView1 addSubview:phoneNumImageView];
    
    phoneNumTextField=[ZCControl createTextFieldWithFrame:CGRectMake(0, [ZCControl isIOS7]+81, 320, 40) placeholder:@"请输入你的地址" passWord:NO leftImageView:tempView1 rightImageView:nil Font:10 backgRoundImageName:nil];
    phoneNumTextField.backgroundColor=[UIColor whiteColor];
    phoneNumTextField.delegate=self;
    [self.view addSubview:phoneNumTextField];
}
-(void)createNav{
    self.title=@"完善资料（4/4）";
    //右边
    UIButton*rightNavButton=[ZCControl createButtonWithFrame:CGRectMake(0, 0, 60, 30) ImageName:nil Target:self Action:@selector(rightNavClick) Title:@"完成"];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightNavButton];
}
#pragma mark 导航右按钮
-(void)rightNavClick{
    if (passWordTextField.text.length>0&&phoneNumTextField.text.length>0) {
        RegisterManager*manager=[RegisterManager shareManager];
        manager.qmd=passWordTextField.text;
        manager.address=phoneNumTextField.text;
        
        //注册
        NSUserDefaults*user=[NSUserDefaults standardUserDefaults];
        [user setObject:manager.userName forKey:kXMPPmyJID];
        [user setObject:manager.passWord forKey:kXMPPmyPassword];
        [user synchronize];
        
        
        [[ZCXMPPManager sharedInstance]registerMothod:^(BOOL isSucceed) {
            if (isSucceed) {
                NSLog(@"注册成功");
            //当登陆成功以后需要更新个人信息名片
                //获取Vcard
                [[ZCXMPPManager sharedInstance] getMyVcardBlock:^(BOOL isFinish, XMPPvCardTemp *myVcard) {
                    //更新名片需要注意他不支持中文，需要对中心进行转码
                    //NSString*str=@"中文";
                    //str=[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    //str=QRCODE(str);
                    
                    if (isFinish) {
                        
    ZCXMPPManager*manager1=      [ZCXMPPManager sharedInstance];
    myVcard.photo=UIImageJPEGRepresentation(manager.headerImage, 0.01);
    //生日
        [manager1 customVcardXML:QRCODE(manager.birthday) name:BYD myVcard:myVcard];
    //性别
        [manager1 customVcardXML:QRCODE(manager.sex) name:SEX myVcard:myVcard];
    //qmd
        [manager1 customVcardXML:QRCODE(manager.qmd) name:QMD myVcard:myVcard];
    //地址
        [manager1 customVcardXML:QRCODE(manager.address) name:ADDRESS myVcard:myVcard];
    //电话
        [manager1 customVcardXML:QRCODE(manager.phoneNum) name:PHOTONUM myVcard:myVcard];
    //更新服务器数据
        [manager1 upData:myVcard];
    //需要把block指空,否则会产生循环一直调用，造成死机
        manager1.myVcardBlock=nil;
                        
                        
    }
        }];
                
    //执行登陆操作 之前已经执行用户名密码记录在本地。所以在这里无需在记录
        [[ZCXMPPManager sharedInstance]connectLogoin:^(BOOL isSucceed) {
            if (isSucceed) {
                //登陆成功进入主页面
                MainTabBarController*tbc=[[MainTabBarController alloc]init];
               [self presentViewController:tbc animated:YES completion:^{
                   [user setObject:isLogin forKey:isLogin];
                   [user synchronize];
               }];
                
                
                
                
            }else{
            
            
            }
            
        }];
                
    
            
                
                
            }else{
                NSLog(@"注册失败");
                NSString*userName=[NSString stringWithFormat:@"%ld",DTAETIME];
                manager.userName=userName;
                UIAlertView*al=[[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"注册失败，用户名重复，已经为您重新生成账号%@",userName] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"", nil];
                [al show];
            
            }
            
        }];
        
        
        
        
    }else{
    
        UIAlertView*al=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请完善资料" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
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
