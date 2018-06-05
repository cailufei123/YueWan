//
//  YWPlayRecordDateilsModel.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/5/7.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface YWRecordInfoModel : NSObject
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

@end
@interface YWuserGameFLowModel : NSObject

@property(nonatomic,strong) NSString *  amountMoney;// 总的奖金额度 ,
@property(nonatomic,strong) NSString *  canComment ;//
@property(nonatomic,strong) NSString *  createTime ;// 创建时间 ,
@property(nonatomic,strong) NSString *  gameArea ;// 游戏大区 1 QQ 2 微信 ,
@property(nonatomic,strong) NSString *  gameId;// 一局的游戏ID ,
@property(nonatomic,strong) NSString *  gameStatus ;//0：未开始；1、启动中(房主点击唤起游戏) 2、游戏中(客服收到链接已开始游戏) 3、结算中，(房主手动点击结束游戏) 4、游戏结束； ,
@property(nonatomic,strong) NSString *  huanId ;//
@property(nonatomic,strong) NSString *  ID ;//
@property(nonatomic,strong) NSString *  isComment ;// 0:没有评价，1：已经评价 ,
@property(nonatomic,strong) NSString *  isLiu ;// 是否流局，0 否，1 是 ,
@property(nonatomic,strong) NSString *  isMvp ;//是否mvp，0 否 1 是 ,
@property(nonatomic,strong) NSString *  isWin;// 是否盈局，0 否 1 是 ,
@property(nonatomic,strong) NSString *  mark ;// 备注 ,
@property(nonatomic,strong) NSString *  outTradeNo;// 关联的订单流水号 ,
@property(nonatomic,strong) NSString *  roomHuanId ;//
@property(nonatomic,strong) NSString *  roomId ;// 平台房间Id ,
@property(nonatomic,strong) NSString *  roomMode;//游戏模式 1、多人排位 2、五人排位 3、多人对战 ,
@property(nonatomic,strong) NSString *  roomType;// 房间类型 1、AA制 2、撒币 3、 悬赏 ,
@property(nonatomic,strong) NSString *  roomUserIcon;//
@property(nonatomic,strong) NSString *  roomUserId;//房间的房主ID ,
@property(nonatomic,strong) NSString *  roomUserName ;//
@property(nonatomic,strong) NSString *  status;// 开黑状态 游戏中1,战绩待汇报2，战绩审核中4，战绩待确认5，战绩已超时201，已确认101，被驳回102，已完成103，战绩已失效202 ,
@property(nonatomic,strong) NSString *  userGameFlowId ;//
@property(nonatomic,strong) NSString *  userGrade;// 用户游戏段位 1 倔强青铜 2 秩序白银 3 荣耀黄金 4 尊贵铂金 5 永恒钻石 6 至尊星耀 7 最强王者 ,
@property(nonatomic,strong) NSString *  userIcon;//
@property(nonatomic,strong) NSString *  userId;// 玩游戏用户Id ,
@property(nonatomic,strong) NSString *  userName ;//
@property(nonatomic,strong) NSString *  userType ;// 用户类型 1 房主
@property(nonatomic,strong) NSString *  winMoney ;//
@property(nonatomic,strong) NSString * rewardMode;//1：平分；2：拼手气；'
@end

@interface YWPvosModel : NSObject

@property(nonatomic,strong) NSString *  amountMoney;// 总的奖金额度 ,
@property(nonatomic,strong) NSString *  canComment ;//
@property(nonatomic,strong) NSString *  createTime ;// 创建时间 ,
@property(nonatomic,strong) NSString *  gameArea ;// 游戏大区 1 QQ 2 微信 ,
@property(nonatomic,strong) NSString *  gameId;// 一局的游戏ID ,
@property(nonatomic,strong) NSString *  gameStatus ;//0：未开始；1、启动中(房主点击唤起游戏) 2、游戏中(客服收到链接已开始游戏) 3、结算中，(房主手动点击结束游戏) 4、游戏结束； ,
@property(nonatomic,strong) NSString *  huanId ;//
@property(nonatomic,strong) NSString *  ID ;//
@property(nonatomic,strong) NSString *  isComment ;// 0:没有评价，1：已经评价 ,
@property(nonatomic,strong) NSString *  isLiu ;// 是否流局，0 否，1 是 ,
@property(nonatomic,strong) NSString *  isMvp ;//是否mvp，0 否 1 是 ,
@property(nonatomic,strong) NSString *  isWin;// 是否盈局，0 否 1 是 ,
@property(nonatomic,strong) NSString *  mark ;// 备注 ,
@property(nonatomic,strong) NSString *  outTradeNo;// 关联的订单流水号 ,
@property(nonatomic,strong) NSString *  roomHuanId ;//
@property(nonatomic,strong) NSString *  roomId ;// 平台房间Id ,
@property(nonatomic,strong) NSString *  roomMode;//游戏模式 1、多人排位 2、五人排位 3、多人对战 ,
@property(nonatomic,strong) NSString *  roomType;// 房间类型 1、AA制 2、撒币 3、 悬赏 ,
@property(nonatomic,strong) NSString *  roomUserIcon;//
@property(nonatomic,strong) NSString *  roomUserId;//房间的房主ID ,
@property(nonatomic,strong) NSString *  roomUserName ;//
@property(nonatomic,strong) NSString *  status;// 开黑状态 游戏中1,战绩待汇报2，战绩审核中4，战绩待确认5，战绩已超时201，已确认101，被驳回102，已完成103，战绩已失效202 ,
@property(nonatomic,strong) NSString *  userGameFlowId ;//
@property(nonatomic,strong) NSString *  userGrade;// 用户游戏段位 1 倔强青铜 2 秩序白银 3 荣耀黄金 4 尊贵铂金 5 永恒钻石 6 至尊星耀 7 最强王者 ,
@property(nonatomic,strong) NSString *  userIcon;//
@property(nonatomic,strong) NSString *  userId;// 玩游戏用户Id ,
@property(nonatomic,strong) NSString *  userName ;//
@property(nonatomic,strong) NSString *  userType ;// 用户类型 1 房主
@property(nonatomic,strong) NSString *  winMoney ;//
@property(nonatomic,strong) NSString *  shouqi ;//
@property(nonatomic,strong) NSString * rewardMode;//1：平分；2：拼手气；'
@end


@interface YWOrderModel : NSObject

@property(nonatomic,strong) NSString *  callbackType  ;//
@property(nonatomic,strong) NSString *  cpChannel  ;//
@property(nonatomic,strong) NSString *  createTime ;//
@property(nonatomic,strong) NSString *  gameId ;//游戏一局的id ,
@property(nonatomic,strong) NSString *  ID  ;//
@property(nonatomic,strong) NSString *  originalPrice ;// 原始价格 ,
@property(nonatomic,strong) NSString *  outTradeNo  ;//订单号 ,
@property(nonatomic,strong) NSString *  payChannel ;// 支付方式：8:支付宝APP支付;25:微信WAP支付; ,
@property(nonatomic,strong) NSString *  payTime ;//
@property(nonatomic,strong) NSString *  platfrom  ;//
@property(nonatomic,strong) NSString *  price ;//支付价 ,
@property(nonatomic,strong) NSString *  productCount ;//拍卖参加数量 ,
@property(nonatomic,strong) NSString *  productId  ;// 商品ID,用户的房间号 ,
@property(nonatomic,strong) NSString *  productName ;// 商品名称 ,
@property(nonatomic,strong) NSString *  productUrls  ;// 团购图片 ,
@property(nonatomic,strong) NSString *  roomType  ;// 房间类型，1、AA制 2、撒币 3、 悬赏 ,
@property(nonatomic,strong) NSString *  status ;//
@property(nonatomic,strong) NSString *  userCouponId ;//
@property(nonatomic,strong) NSString *  userId ;// 用户ID
@end


@interface YWOrderCouponInfoModel : NSObject

@property(nonatomic,strong) NSString * couponId  ;// 用户ID
@property(nonatomic,strong) NSString * createTime  ;// 用户ID
@property(nonatomic,strong) NSString * ID ;// 用户ID
@property(nonatomic,strong) NSString * letvUserId  ;// 用户ID
@property(nonatomic,strong) NSString * man  ;// 用户ID
@property(nonatomic,strong) NSString * outTradeNo  ;// 用户ID
@property(nonatomic,strong) NSString * price ;// 用户ID
@property(nonatomic,strong) NSString * userCouponId ;// 用户ID
@end



@interface YWPlayRecordDateilsModel : NSObject
@property(nonatomic,strong) NSString * result;//创建或加入房间结果： 成功 1 ok  2 失败  3 失败-已经在其他房间中
@property(nonatomic,strong) NSMutableArray * vos;
@property(nonatomic,strong) YWRecordInfoModel * roomInfo;
@property(nonatomic,strong) YWuserGameFLowModel * userGameFLow;
@property(nonatomic,strong) YWOrderModel * order;
@property(nonatomic,strong) YWOrderCouponInfoModel * orderCouponInfo;

@end
