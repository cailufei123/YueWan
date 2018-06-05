//
//  YWAARoomGuestAlertView.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/25.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YWAARoomGuestAlertView : UIView
@property(strong,nonatomic) YWRoomModel * roomModel;
+(instancetype)loadNameAARoomGuestAlertViewXib ;
@property(nonatomic,strong)void(^aaGusetUpDataPlayGameRecord)(void);
@end
