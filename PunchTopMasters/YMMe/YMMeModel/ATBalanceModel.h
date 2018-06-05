//
//  ATBalanceModel.h
//  Auction
//
//  Created by 蔡路飞 on 2017/11/1.
//  Copyright © 2017年 Cailufei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ATBalanceModel : NSObject

@property(nonatomic,strong) NSString * ID;
@property(nonatomic,strong) NSString * userId;
@property(nonatomic,strong) NSString * point;
@property(nonatomic,strong) NSString * detailTypeV;
@property(nonatomic,strong) NSString * type;
@property(nonatomic,strong) NSString * createTime;

@property(nonatomic,strong) NSString * typeV;
@property(nonatomic,strong) NSString * channel;
@property(nonatomic,strong) NSString * relateId;

@property(nonatomic,strong) NSString * op;
@property(nonatomic,strong) NSString * coin;

@property(nonatomic,strong) NSString *orderId; //订单号
@property(nonatomic,strong) NSString *totalFee; //double类型 用户实际提现额度
@property(nonatomic,strong) NSString *serviceFee;   //double类型 提现手续费
@property(nonatomic,strong) NSString *realFee;  //double类型 提现扣除总额
@property(nonatomic,strong) NSString *aliAcount;//"123777788",
@property(nonatomic,strong) NSString *payer_show_name;//"truong",
@property(nonatomic,strong) NSString *payee_real_name;//"truong",
@end


@interface BalanceModel : NSObject


@property(nonatomic,strong) NSString * createTime;
@property(nonatomic,strong) NSString *orderId; //订单号
@property(nonatomic,strong) NSString *totalFee; //double类型 用户实际提现额度
@property(nonatomic,strong) NSString *serviceFee;   //double类型 提现手续费
@property(nonatomic,strong) NSString *realFee;  //double类型 提现扣除总额
@property(nonatomic,strong) NSString *aliAcount;//"123777788",
@property(nonatomic,strong) NSString *payer_show_name;//"truong",
@property(nonatomic,strong) NSString *payee_real_name;//"truong",




@property(nonatomic,strong) NSString *statusName; //" = 审核中,
@property(nonatomic,strong) NSString *userId; //" = 100115779,

@property(nonatomic,strong) NSString *remark; //" = 提现,

@property(nonatomic,strong) NSString *status; //" = 0,

@end
