//
//  YWBindCustomerServiceAlertView.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/20.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YWSetModel.h"
@interface YWBindCustomerServiceAlertView : UIView
@property(nonatomic,strong) YWSetModel * setModel;
@property(nonatomic,copy) NSString * type;
+(instancetype)loadNameBindCustomerServiceAlertViewXib ;
@end
