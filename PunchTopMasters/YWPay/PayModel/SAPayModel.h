//
//  SAPayModel.h
//  SkinAssistant
//
//  Created by 蔡路飞 on 2017/7/5.
//  Copyright © 2017年 LeGame. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAPayModel : NSObject

@property(nonatomic,strong)NSString * outTradeNo;
@property(nonatomic,strong)NSString * price;
@property(nonatomic,strong)NSString * vcMsg;
@end
@interface SACoinCardModel : NSObject
@property(nonatomic,strong)NSString * ID;//充值卡id
@property(nonatomic,strong)NSString * name;//名称
@property(nonatomic,strong)NSString * price;//价格
@property(nonatomic,strong)NSString * coin;//虚拟币数量
@property(nonatomic,strong)NSString * originCoin;//原始虚拟币数量，以coin为主不同时，可能有优惠
@property(nonatomic,strong)NSString * sort;//	排序号
@property(nonatomic,strong)NSString * status;//	0：无效；1:有效
@property(nonatomic,strong)NSString * isPay;//	0：无效；1:有效
@property(nonatomic,strong)NSString * jiaobiao;
@property(nonatomic,strong)NSString * createTime;
@end
