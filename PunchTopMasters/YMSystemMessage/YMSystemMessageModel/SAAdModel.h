//
//  SAAdModel.h
//  SkinAssistant
//
//  Created by 蔡路飞 on 2017/7/19.
//  Copyright © 2017年 LeGame. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAAdModel : NSObject

@property (nonatomic ,strong) NSString *eventId;
@property (nonatomic ,strong) NSString *ID;
@property (nonatomic ,strong) NSString *location;
@property (nonatomic ,strong) NSString *pic;
@property (nonatomic ,strong) NSString *shortLink;
@property (nonatomic ,strong) NSString *sort;
@property (nonatomic ,strong) NSString *title;
@property (nonatomic ,strong) NSString *remark;
@property (nonatomic ,strong) NSString *type;////0商品详情 1H5链接 2皮肤竞拍 3分类 4每日打卡 5我的银子6客服页面7优惠券8收藏夹9收货地址10分享有礼11最新开团动态
@end
