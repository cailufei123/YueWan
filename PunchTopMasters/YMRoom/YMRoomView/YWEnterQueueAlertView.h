//
//  YWEnterQueueAlertView.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/11.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YWRoomModel.h"
@interface YWEnterQueueAlertView : UIView
+(instancetype)loadNameEnterQueueAlertViewXib ;
@property(strong,nonatomic) YWRoomModel * roomModel;
@property(copy,nonatomic) void(^joinQueue)(NSString * userGrade);
@property(copy,nonatomic) void(^joinEnterQueue)(NSString * userGrade);
@end
