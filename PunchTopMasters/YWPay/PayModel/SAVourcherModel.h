//
//  SAVourcherModel.h
//  SkinAssistant
//
//  Created by 蔡路飞 on 2017/8/18.
//  Copyright © 2017年 LeGame. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SAVourcherModel : NSObject

@property(nonatomic,strong)NSString * days;
@property(nonatomic,strong)NSString * endDate;

@property(nonatomic,strong)NSString * hongbaoId;
@property(nonatomic,strong)NSString * ID;
@property(nonatomic,strong)NSString * man;
@property(nonatomic,strong)NSString * price;
@property(nonatomic,strong)NSString * startDate;
@property(nonatomic,strong)NSString * status;//1领取成功2已经领取 //-1：全部;0：未使用；1:已经使用；2：过期；
@property(nonatomic,strong)NSString * title;
@property(nonatomic,strong)NSString * type;
@property(nonatomic,strong)NSString * use;
@property(nonatomic,strong)NSString * backId;
@property(nonatomic,strong)NSString * couponId;
@property(nonatomic,strong)NSString * count;
@property(nonatomic,strong)NSString * latestTime;
@property(nonatomic,strong)NSString * goodIcon;
@property(nonatomic,strong)NSString * goodId;
@property(nonatomic,strong)NSString * couponCount;
@property(nonatomic,strong)NSString * goodTitle;
@property(nonatomic,strong)NSString * couponTotalPrice;
@property(nonatomic,strong)NSString * endTime;
@property(nonatomic,strong)NSString * validTime;
@property(nonatomic,strong)NSString * startTime;
@property(nonatomic,strong)NSString * createTime;


@end
@interface SACouponVourcherModel : NSObject
@property(nonatomic,strong)SAVourcherModel * coupon;
@property(nonatomic,strong)NSString * status;


@end

