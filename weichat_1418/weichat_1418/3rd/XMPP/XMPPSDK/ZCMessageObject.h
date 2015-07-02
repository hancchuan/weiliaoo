//
//  ZCMessageObject.h
//  XMPPEncapsulation
//
//  Created by ZhangCheng on 14-4-10.
//  Copyright (c) 2014年 zhangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCMessageObject : NSObject
//来自哪里
@property (nonatomic,retain) NSString *messageFrom;
//发送给谁
@property (nonatomic,retain) NSString *messageTo;
//内容
@property (nonatomic,retain) NSString *messageContent;
//时间
@property (nonatomic,retain) NSDate *messageDate;
//类型
@property (nonatomic,retain) NSString *messageType;

//数据库增删改查
+(BOOL)save:(ZCMessageObject*)aMessage;

//获取最近联系人
+(NSMutableArray *)fetchRecentChatByPage:(int)pageIndex;

//更新类型，追加群主题
+(void)upDateType:(NSDictionary*)dic;
@end
