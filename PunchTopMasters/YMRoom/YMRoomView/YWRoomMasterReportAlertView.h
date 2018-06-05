//
//  YWRoomMasterReportAlertView.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/25.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YWRoomMasterReportAlertView : UIView
@property(strong,nonatomic) YWRoomModel * roomModel;
+(instancetype)loadNameRoomMasterReportAlertViewXib;
@property(nonatomic,strong)void(^masterReportPlayGame)(void);
@end
