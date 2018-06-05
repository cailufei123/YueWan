//
//  YWHomeModel.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/3/28.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YWHomeModel : NSObject
@property(nonatomic,strong)NSMutableArray * headAds;
@property(nonatomic,strong)NSMutableArray * roomTypeList;

@end

@interface RoomModel : NSObject
@property(nonatomic,strong)NSString * location;//: 0默认首页；1闪屏广告；2英雄标签推荐；3分类标签推荐(小圆图)；4：发现内容配置 ,
@property(nonatomic,strong)NSString * sort;
@property(nonatomic,strong)NSString * ID;
@property(nonatomic,strong)NSString * pic;
@property(nonatomic,strong)NSString * title;
@property(nonatomic,strong)NSString * type;// 类型0商品详情，1：H5链接；2：跳英雄分类；3充值；4分类；5最新揭晓；6客服 9晒单
@property(nonatomic,strong)NSString * eventId;
@property(nonatomic,strong)NSString * shortLink;// 短链接地址 ,

@end

