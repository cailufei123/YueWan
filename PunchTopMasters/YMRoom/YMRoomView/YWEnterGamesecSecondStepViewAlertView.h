//
//  YWEnterGamesecSecondStepViewAlertView.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/23.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YWEnterGamesecSecondStepViewAlertView : UIView
@property (weak, nonatomic) IBOutlet UIButton *closeBt;

@property (weak, nonatomic) IBOutlet UIButton *nextStepBt;
+(instancetype)loadNameEnterGamesecSecondStepViewAlertViewXib ;
@end
