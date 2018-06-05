//
//  YWEnterGameThirdStepAlertView.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/23.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YWEnterGameThirdStepAlertView : UIView
+(instancetype)loadNameEnterGameThirdStepAlertViewXib ;
@property (weak, nonatomic) IBOutlet UIButton *endGameBt;
@property (weak, nonatomic) IBOutlet UIButton *enterGameBt;
@property (weak, nonatomic) IBOutlet UIButton *wentiBt;
@end
