//
//  YWMasterCheakGusetMessageAlertView.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/17.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMMeModel.h"
#import "YWRoomModel.h"
@interface YWMasterCheakGusetMessageAlertView : UIView
+(instancetype)loadNameMasterCheakGusetMessageAlertViewXib ;
@property(nonatomic,strong)  YMMeModel *userHomePageModel;
@property (weak, nonatomic) IBOutlet UILabel *userSegmetLb;
@property(strong,nonatomic) YWRoomModel * roomModel;
@end


