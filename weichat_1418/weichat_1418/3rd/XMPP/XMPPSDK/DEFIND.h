#import "ZCXMPPManager.h"
//账号规则
#define  DTAETIME (long)[[NSDate date]timeIntervalSince1970]-1404218190
//用户信息
#define kMY_USER_ID @"myUserId"
#define kMY_USER_PASSWORD @"myUserPassword"
#define kMY_USER_NICKNAME @"myUserNickname"
#define kMY_USER_Head @"myUserHead"
#define kMY_USER_LoginName @"myUserLoginName"
#define kXMPPmyJID @"myXmppJid"
#define kXMPPmyPassword @"myXmppPassword"
#define kXMPPNewMsgNotifaction @"xmppNewMsgNotifaction"
#define kXMPPFriendType @"FriendType"
#define weiduMESSAGE @"weiduxiaoxi"
//发送消息的标记
#define MESSAGE_STR @"[1]"
#define MESSAGE_VOICE @"[2]"
#define MESSAGE_IMAGESTR @"[3]"
#define MESSAGE_BIGIMAGESTR @"[4]"

//区别单聊和群聊的表示
#define SOLECHAT @"[1]"
#define GROUPCHAT @"[2]"


//接收开启推送通知获得的token
//示例如下 需要拼接参数%@token=%@ 返回值只有一个数值，为1
#define deviceTokenURL "http://210.209.120.115:3344/tuisong_1.php?"
//服务器设置

#define DOMAIN @"1000phone.net"
#define IP @"1000phone.net"


//群聊需要设置以下节点名称
//默认
//#define GROUND @"conference"
#define GROUND @"room11"
#define GROUNDROOMCONFIG @"roomconfig"
#define ZIYUANMING @"IOS"
#define FRIENDS_TYPE @"friends_type"
//创建群时候保存群昵称和群描述
#define GROUNDNAME @"groundname"
#define GROUNDDES  @"grounddes"
//个人名片的节点定义
#define BYD @"birthday"
#define SEX @"SEX"
#define PHOTONUM @"photoNum"
#define QMD @"QMD"
#define ADDRESS @"DQ"




//FMDB
#define FMDBQuickCheck(SomeBool) { if (!(SomeBool)) { NSLog(@"Failure on line %d", __LINE__); abort(); } }

#define DATABASE_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]stringByAppendingString:@"/weChat.db"]



