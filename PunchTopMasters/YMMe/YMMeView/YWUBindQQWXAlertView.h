//
//  YWUBindQQWXAlertView.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/23.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YWUBindQQWXAlertView : UIView
+(instancetype)loadNameUBindQQWXAlertViewXib;
@property(nonatomic,strong)void (^bindqqWx)();
@end
