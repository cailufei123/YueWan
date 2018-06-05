//
//  YWRoomMeCheckMeView.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/18.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMMeModel.h"
#import "YWRoomModel.h"
@interface YWRoomMeCheckMeView : UIView
+(instancetype)loadNameRoomMeCheckMeViewXib   ;
@property(nonatomic,strong)  YMMeModel *userHomePageModel;
@property (weak, nonatomic) IBOutlet UILabel *userSegmetLb;
@property(strong,nonatomic) YWRoomModel * roomModel;
@property(copy,nonatomic) void(^userQuitQueue)(void);
@property(copy,nonatomic) void(^kickRoom)(void);
@property(nonatomic,assign)  BOOL isPointMaster;
@property (weak, nonatomic) IBOutlet UIButton *followBt;
@end
