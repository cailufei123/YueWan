//
//  YWPlayGameRecordModel.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/25.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YWPlayGameRecordModel : NSObject
@property(nonatomic,copy) NSString *  amountMoney;// 总的奖金额度 ,
@property(nonatomic,copy) NSString *  createTime ;// 创建时间 ,
@property(nonatomic,copy) NSString *  gameArea ;//游戏大区 1 QQ 2 微信 ,
@property(nonatomic,copy) NSString *  gameId ;// 一局的游戏ID ,
@property(nonatomic,copy) NSString *  gameStatus ;//: 0：未开始；1、启动中(房主点击唤起游戏) 2、游戏中(客服收到链接已开始游戏) 3、结算中，(房主手动点击结束游戏) 4、游戏结束； ,
@property(nonatomic,copy) NSString *  ID  ;//
@property(nonatomic,copy) NSString *  isLiu ;// 是否流局，0 否，1 是 ,
@property(nonatomic,copy) NSString *  isMvp ;//是否mvp，0 否 1 是 ,
@property(nonatomic,copy) NSString *  isWin ;//是否盈局，0 否 1 是 ,
@property(nonatomic,copy) NSString *  mark ;//备注 ,
@property(nonatomic,copy) NSString *  outTradeNo ;//关联的订单流水号 ,
@property(nonatomic,copy) NSString *  roomId ;// 平台房间Id ,
@property(nonatomic,copy) NSString *  roomMode ;// 游戏模式 1、多人排位 2、五人排位 3、多人对战 ,
@property(nonatomic,copy) NSString * roomType ;// 房间类型 1、AA制 2、撒币 3、 悬赏 ,
@property(nonatomic,copy) NSString *  roomUserId ;// 房间的房主ID ,
@property(nonatomic,copy) NSString *  status ;// 开黑状态 游戏中1,战绩待汇报2，战绩审核中4，战绩待确认5，战绩已超时201，已确认101，被驳回102，已完成103，战绩已失效202 ,
@property(nonatomic,copy) NSString *  userGrade ;// 用户游戏段位 1 倔强青铜 2 秩序白银 3 荣耀黄金 4 尊贵铂金 5 永恒钻石 6 至尊星耀 7 最强王者 ,
@property(nonatomic,copy) NSString *  userId ;// 玩游戏用户Id ,
@property(nonatomic,copy) NSString * userType ;// 用户类型 1 房主 2 房客 ,
@property(nonatomic,copy) NSString *  winMoney ;//赢取的奖金


@end
