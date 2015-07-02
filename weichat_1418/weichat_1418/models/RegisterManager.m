
//
//  RegisterManager.m
//  weichat_1418
//
//  Created by zhangcheng on 14-9-25.
//  Copyright (c) 2014年 zhangcheng. All rights reserved.
//

#import "RegisterManager.h"

@implementation RegisterManager
static RegisterManager*manager=nil;
+(id)shareManager{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[[RegisterManager alloc]init];
    });
    
    return manager;
}
@end
