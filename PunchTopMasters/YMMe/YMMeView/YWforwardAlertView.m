//
//  YWforwardAlertView.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/5/9.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWforwardAlertView.h"

@implementation YWforwardAlertView
-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self.closeBt addTarget:self action:@selector(closeBtClick) forControlEvents:UIControlEventTouchUpInside];
      [self.sureBt addTarget:self action:@selector(sureBtClick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)closeBtClick{
    [GKCover hideCover];
}
-(void)sureBtClick{
    self.upDatamessage();
}
+(instancetype)loadNameForwardAlertViewXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

@end
