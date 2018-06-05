//
//  YWSBRoomGusetAlertView.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/25.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YWSBRoomGusetAlertView : UIView
@property(strong,nonatomic) YWRoomModel * roomModel;
+(instancetype)loadNameSBRoomGusetAlertViewXib ;
@property(nonatomic,strong)void(^sbGusetUpDataPlayGameRecord)(void);
@end
