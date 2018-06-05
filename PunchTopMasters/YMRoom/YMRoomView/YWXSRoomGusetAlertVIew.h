//
//  YWXSRoomGusetAlertVIew.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/25.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YWXSRoomGusetAlertVIew : UIView
@property(strong,nonatomic) YWRoomModel * roomModel;
+(instancetype)loadNameXSRoomGusetAlertVIewXib ;
@property(nonatomic,strong)void(^xsGusetUpDataPlayGameRecord)(void);
@end
