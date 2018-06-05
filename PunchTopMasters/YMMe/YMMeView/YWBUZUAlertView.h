//
//  YWBUZUAlertView.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/5/9.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YWBUZUAlertView : UIView
+(instancetype)loadNameBUZUAlertViewXib ;
@property (weak, nonatomic) IBOutlet UILabel *messageLb;
@property (weak, nonatomic) IBOutlet UIButton *sureBt;
@property (weak, nonatomic) IBOutlet UIButton *closeBt;
@property(nonatomic,strong)void(^upDatamessage)(void);
@end
