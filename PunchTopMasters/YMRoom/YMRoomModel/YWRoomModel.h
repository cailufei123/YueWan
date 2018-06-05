//
//  YWRoomModel.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/10.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface YWRoomInfoModel : NSObject
@property(nonatomic,strong) NSString *  createTime;
@property(nonatomic,strong) NSString *  gameArea;//游戏大区 1 QQ 2 微信',
@property(nonatomic,strong) NSString *  huanChatId;//房间环信id
@property(nonatomic,strong) NSString *  huanUserId ;//环信id
@property(nonatomic,strong) NSString * userLogo;//用户头象
@property(nonatomic,strong) NSString *  userName;//房主姓名
@property(nonatomic,strong) NSString *  ID;
@property(nonatomic,strong) NSString *  num;//人数
@property(nonatomic,strong) NSString * productType;//
@property(nonatomic,strong) NSString *  isInQueue ;//是否在队列---仅用于myroom接口！！
@property(nonatomic,strong) NSString * roomType;//房间类型 1、AA制 2、撒币 3、 悬赏',
@property(nonatomic,strong) NSString * rewardMode;//1：平分；2：拼手气；'
@property(nonatomic,strong) NSString * roomId;
@property(nonatomic,strong) NSString * roomMode;//'游戏模式 1、多人排位 2、五人排位 3、多人对战',
@property(nonatomic,strong) NSString * roomMoney;//房间费用 当AA制此值为房间费 撒币和悬赏为房主出价金额',
@property(nonatomic,strong) NSString * roomPass;
@property(nonatomic,strong) NSString * roomSlogan;
//        public int roomType;
@property(nonatomic,strong) NSString * segMatch;//(段位匹配要求，逗号分隔；)
@property(nonatomic,strong) NSString * segment;
@property(nonatomic,strong) NSString * status;
@property(nonatomic,strong) NSString * gameStatus;////0：未开始；1、启动中(房主点击唤起游戏) 2、游戏中(客服收到链接已开始游戏) 3、结算中，(房主手动点击结束游戏) 4、游戏结束；
@property(nonatomic,strong) NSString * updateTime;
@property(nonatomic,strong) NSString *  userId;
@property(nonatomic,strong) NSString * gameId;
@property(nonatomic,strong) NSString *  currentQueueNum;//当前队列人数
@property(nonatomic,strong) NSString *  requireQueueNum;//总座位数
@property(nonatomic,assign) BOOL isClose;//总座位数
@end

@interface YWRoomModel : NSObject
@property(nonatomic,strong) NSString * result;//创建或加入房间结果： 成功 1 ok  2 失败  3 失败-已经在其他房间中
@property(nonatomic,strong) NSMutableArray * gameQueue;
@property(nonatomic,strong) NSMutableArray * roomPerson;
@property(nonatomic,strong) NSString * gameStatus;
@property(nonatomic,strong) NSString * currentQueueCount;//当前队列人数
@property(nonatomic,strong) NSString * requireQueueCount;//总座位数
@property(nonatomic,strong) YWRoomInfoModel * roomInfo;


@end
@interface YWGameQueueModel : NSObject
@property(nonatomic,strong) NSString * createDate;
@property(nonatomic,strong) NSString *  gameId;
@property(nonatomic,strong) NSString * ID;
@property(nonatomic,strong) NSString *  isMgt;//1:房主
@property(nonatomic,strong) NSString * outTradeNo;
@property(nonatomic,strong) NSString * roomId;
@property(nonatomic,strong) NSString *  gameStatus;
@property(nonatomic,strong) NSString *  userGrade;//段位
@property(nonatomic,strong) NSString * userId;
@property(nonatomic,strong) NSString * userLogo;
@property(nonatomic,strong) NSString * userName;
@property(nonatomic,strong) NSString * isFollowedByCurrentUser;//是否被当前用户关注，不用于接口,客户端自定义字段
@property(nonatomic,strong) NSString * huanId;
@end
@interface YWRoomPersonModel : NSObject
@property(nonatomic,strong) NSString * roomId;
@property(nonatomic,strong) NSString * userId;
@property(nonatomic,strong) NSString * userLogo;
@property(nonatomic,strong) NSString * userName;
@property(nonatomic,strong) NSString * userSeg;
@property(nonatomic,strong) NSString * huanid;
//非接口字段， 客户端内部用
@property(nonatomic,strong) NSString * queue_level;//1: 房主 2：队列玩家 3：房客
@property(nonatomic,strong) NSString * isFollowed;//是否被当前用户关注
@end

@interface YWMyRoomModel : NSObject
@property(nonatomic,strong) NSString *rewardMode;//
@property(nonatomic,strong) NSString *status;//" = 1,
@property(nonatomic,strong) NSString *gameArea;//" = 1,
@property(nonatomic,strong) NSString *userLogo;//" = http://thirdqq.qlogo.cn/qqapp/1106722391/A7B52AF2235C66B4C7475CB1FB15BAA0/100,
@property(nonatomic,strong) NSString *roomMoney;//" = 0,
@property(nonatomic,strong) NSString *segMatch;//" = 0,
@property(nonatomic,strong) NSString *isInQueue;//" = 0,
@property(nonatomic,strong) NSString *updateTime;//" = 1523342620000,
@property(nonatomic,strong) NSString *segment;//" = 5,
@property(nonatomic,strong) NSString *roomSlogan;//" = 上分队，来不坑的队友,
@property(nonatomic,strong) NSString *roomId;//" = 726386785,
@property(nonatomic,strong) NSString *productType;//" = 1,
@property(nonatomic,strong) NSString *huanChatId;//" = 46078854496257,
@property(nonatomic,strong) NSString *currentQueueCount;//" = 1,
@property(nonatomic,strong) NSString *gameId;//" = 149,
@property(nonatomic,strong) NSString *ID;//" = 153,
@property(nonatomic,strong) NSString *roomType;//" = 1,
@property(nonatomic,strong) NSString *num;//" = 0,
@property(nonatomic,strong) NSString *gameStatus;//" = 0,
@property(nonatomic,strong) NSString *requireQueueCount;//" = 5,
@property(nonatomic,strong) NSString *userName;//" = Fxxk it.,
@property(nonatomic,strong) NSString *roomMode;//" = 1,
@property(nonatomic,strong) NSString *createTime;//" = 1523342620000,
@property(nonatomic,strong) NSString *userId;//" = 100115786,
@end

//// 状态 0、房间已解散 1、房间已创建
//@property(nonatomic,strong) NSString *  status;
//// 0：未开始；1、启动中(房主点击唤起游戏) 2、游戏中(客服收到链接已开始游戏) 3、结算中，(房主手动点击结束游戏) 4、游戏结束；
//@property(nonatomic,strong) NSString *  gameStatus;
