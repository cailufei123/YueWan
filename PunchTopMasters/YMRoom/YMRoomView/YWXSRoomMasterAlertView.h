//
//  YWXSRoomMasterAlertView.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/25.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YWXSRoomMasterAlertView : UIView
@property(strong,nonatomic) YWRoomModel * roomModel;
+(instancetype)loadNameXSRoomMasterAlertViewXib ;
@property(nonatomic,strong)void(^xsMasterUpDataPlayGameRecord)(void);
@end
