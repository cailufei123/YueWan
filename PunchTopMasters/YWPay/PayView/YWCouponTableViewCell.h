//
//  YWCouponTableViewCell.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/5/2.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SAVourcherModel.h"
@interface YWCouponTableViewCell : UITableViewCell
@property (strong, nonatomic)SAVourcherModel * vourcherModel;
@property (strong, nonatomic)SAVourcherModel * selectVourcherModel;
@end
