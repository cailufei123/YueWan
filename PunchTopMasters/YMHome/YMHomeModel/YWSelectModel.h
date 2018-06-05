//
//  YWSelectModel.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/3/29.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YWSelectModel : NSObject
@property(nonatomic,strong)NSString * erviceArea;//服务区
@property(nonatomic,strong)NSString * pattern;//模式
@property(nonatomic,strong)NSMutableArray * levels;//级别要求
@property(nonatomic,strong)NSMutableArray * roomType;//房间类型

@end

@interface LevelModel : NSObject
@property(nonatomic,strong)NSString * number;
@property(nonatomic,strong)NSString * name;
@end
