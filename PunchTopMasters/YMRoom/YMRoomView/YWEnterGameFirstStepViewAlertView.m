//
//  YWEnterGameFirstStepViewAlertView.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/23.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWEnterGameFirstStepViewAlertView.h"
#import "YWShareFriendAlertView.h"
@implementation YWEnterGameFirstStepViewAlertView
-(void)awakeFromNib{
    [super awakeFromNib];
//    [SVGloble gradientLayer:self.nextStepBt];
//    [self.nextStepBt addTarget:self action:@selector(followBtClick:) forControlEvents:UIControlEventTouchUpInside];
     [self.closeBt addTarget:self action:@selector(closeBtClick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)closeBtClick{
    [GKCover hideCover];
}
+(instancetype)loadNameEnterGameFirstStepViewAlertViewXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

@end
