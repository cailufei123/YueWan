//
//  YWMeTopView.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/27.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YWMeTopButton.h"
#import "YMMeModel.h"
@interface YWMeTopView : UIView
+(instancetype)loadNameMeTopViewXib;
@property (weak, nonatomic) IBOutlet YWMeTopButton *pocketMoneyBt;
@property (weak, nonatomic) IBOutlet YWMeTopButton *poconBt;
@property(nonatomic,strong)  YMMeModel * meModel  ;
@property (weak, nonatomic) IBOutlet UILabel *makeMoneyLb;
@property (weak, nonatomic) IBOutlet UIButton *userIcon;
@property (weak, nonatomic) IBOutlet UILabel *userNameLb;
@property(copy ,nonatomic)void (^couponClick)(void);
@property(copy ,nonatomic)void (^followClick)(void);
@property (weak, nonatomic) IBOutlet UIButton *modifyBt;
@property (weak, nonatomic) IBOutlet UIButton *followbt;
@property (weak, nonatomic) IBOutlet UIButton *fanctBt;
@property (weak, nonatomic) IBOutlet UIButton *goToXy;
@property (weak, nonatomic) IBOutlet UIButton *goToPresonCnter;
@end
