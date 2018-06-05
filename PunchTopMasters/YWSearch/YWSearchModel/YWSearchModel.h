//
//  YWSearchModel.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/3.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YWSearchModel : NSObject
// (我们的)平台房间号
@property(nonatomic,strong) NSString *  roomId;
// 房主用户Id
@property(nonatomic,strong) NSString *  userId;
//房主头象
@property(nonatomic,strong) NSString *  userLogo;//
// 房主
@property(nonatomic,strong) NSString * userName;
// 房间口号
@property(nonatomic,strong) NSString *  roomSlogan;
// 游戏大区 1 QQ 2 微信
@property(nonatomic,strong) NSString *  gameArea;
// 房间类型 1、AA制 2、撒币 3、 悬赏
@property(nonatomic,strong) NSString * roomType;
// 房间费用 当AA制此值为房间费 撒币和悬赏为房主出价金额
@property(nonatomic,strong) NSString *  roomMoney;
// 房主的段位；
@property(nonatomic,strong) NSString *  segment;
// 段位匹配要求，逗号分隔；
@property(nonatomic,strong) NSString * segMatch;
// 1：平分；2：拼手气；
@property(nonatomic,strong) NSString *  rewardMode;
// 房间密码
@property(nonatomic,strong) NSString *  roomPass;
// 游戏模式 1、多人排位 2、五人排位 3、多人对战
@property(nonatomic,strong) NSString * roomMode;
// 状态 0、房间已解散 1、房间已创建
@property(nonatomic,strong) NSString *  status;
// 0：未开始；1、启动中(房主点击唤起游戏) 2、游戏中(客服收到链接已开始游戏) 3、结算中，(房主手动点击结束游戏) 4、游戏结束；
@property(nonatomic,strong) NSString *  gameStatus;

//默认队列
@property(nonatomic,strong) NSString *  requireQueueCount;
//当前队列
@property(nonatomic,strong) NSString *  currentQueueCount;
@property(nonatomic,strong) NSString *  num;
@property(nonatomic,strong) NSString *  huanChatId;
@property(nonatomic,strong) NSString *  huanUserId;
@property(nonatomic,strong) NSString *  result;
@end
//"message" = ok,
//"data" = {
//    "roomInfo" = {
//        "status" = 0,
//        "gameArea" = 1,
//        "userLogo" = http://i3.letvimg.com/lc05_iptv/201712/22/16/22/1c5664aa-25b7-4104-8fe6-ea67493aaf01.png,
//        "roomMoney" = 20,
//        "segMatch" = 1,2,3,4,5,6,7,
//        "isInQueue" = 0,
//        "segment" = 3,
//        "roomSlogan" = 上分队，来不坑的队友,
//        "roomId" = 726547934,
//        "productType" = 1,
//        "huanChatId" = 46432813907970,
//        "huanUserId" = test100115770,
//        "currentQueueCount" = 0,
//        "gameId" = 0,
//        "id" = 503,
//        "roomType" = 1,
//        "num" = 1,
//        "gameStatus" = 0,
//        "requireQueueCount" = 0,
//        "userName" = 158****8134,
//        "roomMode" = 3,
//        "userId" = 100115770,
//    },
//    "gameStatus" = 0,
//    "gameQueue" = 1 (
//                     {
//                         "gameId" = 498,
//                         "userId" = 100115770,
//                         "roomId" = 726547934,
//                         "id" = 718,
//                         "userGrade" = 3,
//                         "isMgt" = 1,
//                         "status" = 0,
//                         "createDate" = 1523680182646,
//                     },
//                     ),
//    "requireQueueCount" = 0,
//    "result" = 1,
//    "currentQueueCount" = 0,
//},
//}
