//
//  YWFastEnterAlertView.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/3/29.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YWFastEnterAlertView : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgLyout;
@property (weak, nonatomic) IBOutlet UIView *bgView;
+(instancetype)loadNameFastEnterAlertViewXib ;
@property(nonatomic,copy) void (^sureClickScreen)(NSMutableDictionary * dict,NSMutableDictionary * dict1);
@end
