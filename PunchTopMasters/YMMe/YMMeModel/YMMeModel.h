//
//  YMMeModel.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/12.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface YMUserGameFlowStatModel : NSObject
@property(nonatomic,strong)NSString * count ;//
@property(nonatomic,strong)NSString * mvp ;//
@property(nonatomic,strong)NSString * stat ;//
@property(nonatomic,strong)NSString * userId ;//
@end
@interface YMUserStatModel : NSObject
@property(nonatomic,strong)NSString * fanCount;//
@property(nonatomic,strong)NSString * ID;//
@property(nonatomic,strong)NSString * gameStatus;//
@property(nonatomic,strong)NSString * followCount;//
@property(nonatomic,strong)NSString * userId;//
@property(nonatomic,strong)NSString * commentScore;//
@end
@interface YMUserModel : NSObject
@property(nonatomic,strong)NSString * isFeng;//
@property(nonatomic,strong)NSString * huanId;//
@property(nonatomic,strong)NSString * icon;// = http://i3.letvimg.com/lc05_iptv/201712/22/16/22/1c5664aa-25b7-4104-8fe6-ea67493aaf01.png,
@property(nonatomic,strong)NSString * source;// = 1,
@property(nonatomic,strong)NSString * userId;// = 100115770,
@property(nonatomic,strong)NSString * name;// = 158****8134,
@end

@interface YMMeModel : NSObject
@property(nonatomic,strong)NSMutableArray * userGradeStats;
@property(nonatomic,strong)NSMutableArray * roomModeStats;
@property(nonatomic,strong)YMUserStatModel * userStat;
@property(nonatomic,strong)NSString * gameCount;
@property(nonatomic,strong)NSString * mvpCount;
@property(nonatomic,strong)YMUserModel * user;
@property(nonatomic,strong)YMUserGameFlowStatModel * UserGameFlowStat;

@end
@interface YMUserGameFlowStatM : NSObject
@property(nonatomic,strong)NSString * count ;//
@property(nonatomic,strong)NSString * mvp ;//
@property(nonatomic,strong)NSString * stat ;//
@property(nonatomic,strong)NSString * userId ;//
@property(nonatomic,assign)BOOL  playmode ;//
@end
