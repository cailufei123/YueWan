//
//  YWCouponTopView.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/5/3.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWCouponTopView.h"

@implementation YWCouponTopView


-(void)awakeFromNib{
    [super awakeFromNib];
  
      self.autoresizesSubviews = NO;
}


+(instancetype)loadNameCouponTopViewXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}


@end
