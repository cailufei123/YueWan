//
//  YWSearchScreenAlertView.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/3.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YWSearchScreenAlertView : UIView
+(instancetype)loadNameSearchScreenAlertViewXib;
@property(nonatomic,strong)NSString * str;
@property(nonatomic,copy) void (^sureClick)(NSMutableDictionary * dict, NSInteger index);
@end
