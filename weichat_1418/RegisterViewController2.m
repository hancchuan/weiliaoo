
//
//  RegisterViewController2.m
//  weichat_1418
//
//  Created by zhangcheng on 14-9-25.
//  Copyright (c) 2014年 zhangcheng. All rights reserved.
//

#import "RegisterViewController2.h"
#import "RegisterViewController3.h"
@interface RegisterViewController2 ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    //性别的图标
    UIImageView*sexImageView;
    //头像
    UIButton*headerButton;
    //日期滚动的一个控件
    UIDatePicker*_datePicker;
    //生日
    UILabel*birLabel;
    //性别
    UILabel*sexLabel;
    
    RegisterManager*manager;

}
@end

@implementation RegisterViewController2

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
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"logo_bg_2.png"]];
    
    [self createRightNav];
    manager=[RegisterManager shareManager];
    
}
-(void)createRightNav{
    UIButton*button=[ZCControl createButtonWithFrame:CGRectMake(0, 0, 60, 30) ImageName:nil Target:self Action:@selector(rightNavClick) Title:@"下一步"];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
}
-(void)rightNavClick{
    [self nextClick];
    //判断单例记录数据是否完全，如果完全，进入下一个界面
    //需要判断的有生日、头像、性别
    if (manager.birthday!=nil&&manager.headerImage!=nil&&manager.sex!=nil) {
        RegisterViewController3*vc=[[RegisterViewController3 alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        UIAlertView*al=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请完善资料" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [al show];
    }
    
    
   

}
-(void)createNav{
    self.title=@"个人资料（2/4）";
    headerButton=[ZCControl createButtonWithFrame:CGRectMake(0, 0, 120, 120) ImageName:@"icon_register_camera.png" Target:self Action:@selector(headerButtonClick) Title:nil];
    [self.view addSubview:headerButton];
    headerButton.center=CGPointMake(self.view.center.x, 130);
    
    UIView*birView=[ZCControl viewWithFrame:CGRectMake(0, 200, 320, 44)];
    birView.backgroundColor=[UIColor whiteColor];
    UIImageView*birImageView=[ZCControl createImageViewWithFrame:CGRectMake(10, 10, 20, 20) ImageName:@"icon_register_birthday.png"];
    [birView addSubview:birImageView];
    
    birLabel=[ZCControl createLabelWithFrame:CGRectMake(40, 10, 200, 20) Font:10 Text:@"请输入生日"];
    birLabel.textColor=[UIColor grayColor];
    [birView addSubview:birLabel];
    
    UIImageView*rightView=[ZCControl createImageViewWithFrame:CGRectMake(320-40, 10, 20, 20) ImageName:@"btn_forward_disabled.png"];
    [birView addSubview:rightView];
    [self.view addSubview:birView];
    
    
    UIView*sexView=[ZCControl viewWithFrame:CGRectMake(0, 245, 320, 44)];
    sexView.backgroundColor=[UIColor whiteColor];
    sexImageView=[ZCControl createImageViewWithFrame:birImageView.frame ImageName:@"icon_register_gender.png"];
    [sexView addSubview:sexImageView];
    
    sexLabel=[ZCControl createLabelWithFrame:birLabel.frame Font:10 Text:@"请选择您的性别"];
    sexLabel.textColor=[UIColor grayColor];
    [sexView addSubview:sexLabel];
    
    UIImageView*rightView1=[ZCControl createImageViewWithFrame:rightView.frame ImageName:@"btn_forward_disabled.png"];
    [sexView addSubview:rightView1];
    
    [self.view addSubview:sexView];
    
    //2个control
    UIControl*birControl=[[UIControl alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [birControl addTarget:self action:@selector(birClick) forControlEvents:UIControlEventTouchUpInside];
    [birView addSubview:birControl];

    UIControl*sexControl=[[UIControl alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [sexControl addTarget:self action:@selector(sexClick) forControlEvents:UIControlEventTouchUpInside];
    [sexView addSubview:sexControl];
    
    
    //1个label
    UILabel*infoLabel=[ZCControl createLabelWithFrame:CGRectMake(30, 300, 200, 10) Font:10 Text:@"性别选择后无法更改（泰国除外）"];
    infoLabel.textColor=[UIColor grayColor];
    [self.view addSubview:infoLabel];
    
}
#pragma mark 选择头像
-(void)headerButtonClick{
    UIActionSheet*sheet=[[UIActionSheet alloc]initWithTitle:@"提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"相册", nil];
    sheet.tag=1000;
    [sheet showInView:self.view];
}

#pragma mark 选择性别
-(void)sexClick{
    UIActionSheet*sheet=[[UIActionSheet alloc]initWithTitle:@"选择性别" delegate:self cancelButtonTitle:@"" destructiveButtonTitle:nil otherButtonTitles:@"♂男",@"♀女",@"取消", nil];
    sheet.tag=2000;
    [sheet showInView:self.view];
    
    
}
#pragma mark 选择生日
-(void)birClick{
    if (_datePicker) {
        return;
    }
    _datePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-216, 0, 0)];
    [_datePicker setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    //日期模式
    [_datePicker setDatePickerMode:UIDatePickerModeDate];
    //定义最小日期
    NSDateFormatter *formatter_minDate = [[NSDateFormatter alloc] init];
    [formatter_minDate setDateFormat:@"yyyy-MM-dd"];
    NSDate *minDate = [formatter_minDate dateFromString:@"1920-01-01"];
    
    NSDate *maxDate = [NSDate date];
    
    [_datePicker setMinimumDate:minDate];
    [_datePicker setMaximumDate:maxDate];
    [_datePicker addTarget:self action:@selector(dataValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_datePicker];
    
    [UIView animateWithDuration:1 animations:^{
        _datePicker.frame=CGRectMake(0, self.view.frame.size.height-216, 0, 0);
    }];
}
- (void) dataValueChanged:(UIDatePicker *)sender
{
    UIDatePicker *dataPicker_one = (UIDatePicker *)sender;
    NSDate *date_one = dataPicker_one.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    birLabel.text = [formatter stringFromDate:date_one];
    
    manager.birthday=birLabel.text;

}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self nextClick];
}

-(void)nextClick{

//收日期
    if (_datePicker) {
        [UIView animateWithDuration:0.3 animations:^{
            _datePicker.frame=CGRectMake(0, self.view.frame.size.height, 0, 0);
            
        }completion:^(BOOL finished) {
            //ARC如果全局指针指向nil，自动释放
            _datePicker=nil;
        }];
    }
    
    
    

}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==1000) {
        //选择相机或者相册
        UIImagePickerController*picker=[[UIImagePickerController alloc]init];
        picker.delegate=self;
        if (buttonIndex==0) {
            //相机
            picker.sourceType=UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:nil];
        }else{
            if (buttonIndex==1) {
                //相册
                picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentViewController:picker animated:YES completion:nil];
            }
        
        }
        
    }
    
    if (actionSheet.tag==2000) {
        if (buttonIndex==0) {
            //男
            sexImageView.image=[UIImage imageNamed:@"icon_register_man.png"];
            sexLabel.text=@"男";
            //单例记录
            manager.sex=sexLabel.text;
        }else{
            if (buttonIndex==1) {
                //女
                sexImageView.image=[UIImage imageNamed:@"icon_register_woman.png"];
                sexLabel.text=@"女";
                //单例记录
                manager.sex=sexLabel.text;
            }
        
        }
    }
    

}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage*image=[info objectForKey:UIImagePickerControllerOriginalImage];
    [headerButton setBackgroundImage:image forState:UIControlStateNormal];
    //在这里需要使用单例进行记录
    manager.headerImage=image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
