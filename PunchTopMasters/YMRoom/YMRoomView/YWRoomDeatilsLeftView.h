//
//  YWRoomDeatilsLeftView.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/11.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YWRoomModel.h"
#import "YMRoomViewController.h"
@interface YWRoomDeatilsLeftView : UIView
+(instancetype)loadNameRoomDeatilsLeftViewXib;
@property(strong,nonatomic) YWRoomModel * roomModel;
@property(strong,nonatomic) YMRoomViewController * roomViewController;
@property(copy,nonatomic) void(^hideRightView)();
@end
