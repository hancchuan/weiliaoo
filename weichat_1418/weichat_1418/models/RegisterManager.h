//
//  RegisterManager.h
//  weichat_1418
//
//  Created by zhangcheng on 14-9-25.
//  Copyright (c) 2014年 zhangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegisterManager : NSObject
@property(nonatomic,copy)NSString*userName;
@property(nonatomic,copy)NSString*passWord;
@property(nonatomic,copy)NSString*nickName;
@property(nonatomic,copy)NSString*birthday;
@property(nonatomic,copy)NSString*sex;
@property(nonatomic,copy)NSString*phoneNum;
@property(nonatomic,copy)NSString*qmd;
@property(nonatomic,copy)NSString*address;
@property(nonatomic,retain)UIImage*headerImage;
+(id)shareManager;


@end
