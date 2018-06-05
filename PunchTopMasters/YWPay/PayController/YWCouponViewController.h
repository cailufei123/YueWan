//
//  YWCouponViewController.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/5/2.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SAVourcherModel.h"
@interface YWCouponViewController : UIViewController
@property(nonatomic,strong)NSString * totalPric;
@property(nonatomic,copy)void(^vourcherPice)(SAVourcherModel * vourcherModel);
@property(nonatomic,copy)void(^nousedVourcherPice)();
@end
