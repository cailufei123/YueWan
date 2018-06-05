//
//  YWShareFriendAlertView.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/24.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YWShareFriendAlertView : UIView
@property (weak, nonatomic) IBOutlet UIButton *closeBt;

@property (weak, nonatomic) IBOutlet UIButton *nextStepBt;
+(instancetype)loadNameShareFriendAlertViewXib ;
@end
