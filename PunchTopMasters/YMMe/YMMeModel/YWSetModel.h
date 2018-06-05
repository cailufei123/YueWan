//
//  YWSetModel.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/20.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YWSetModel : NSObject
@property(nonatomic,strong)NSMutableArray * botInfos;// 机器人信息列表 ,
@property(nonatomic,strong)NSString * bindStatus;// 0 已绑定 1 未绑定 ,
@property(nonatomic,strong)NSString * verify;// 加客服时验证信息
@end
@interface BotInfoModel : NSObject
@property(nonatomic,strong)NSString *status;//
@property(nonatomic,strong)NSString *ID;//
@property(nonatomic,strong)NSString *createTime;//
@property(nonatomic,strong)NSString *botId;//: QQ号或微信号 ,
@property(nonatomic,strong)NSString *botType;//  机器人类型 1 QQ 2 微信 ,

@end
