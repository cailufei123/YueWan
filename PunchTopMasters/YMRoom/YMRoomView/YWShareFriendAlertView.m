//
//  YWShareFriendAlertView.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/24.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWShareFriendAlertView.h"

@implementation YWShareFriendAlertView


-(void)awakeFromNib{
    [super awakeFromNib];
//    [SVGloble gradientLayer:self.nextStepBt];
    //    [self.nextStepBt addTarget:self action:@selector(followBtClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.closeBt addTarget:self action:@selector(closeBtClick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)closeBtClick{
    [GKCover hideCover];
}
+(instancetype)loadNameShareFriendAlertViewXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

@end
