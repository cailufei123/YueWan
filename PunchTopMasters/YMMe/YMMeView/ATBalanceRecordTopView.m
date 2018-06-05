//
//  ATBalanceRecordTopView.m
//  Auction
//
//  Created by 蔡路飞 on 2017/11/1.
//  Copyright © 2017年 Cailufei. All rights reserved.
//

#import "ATBalanceRecordTopView.h"

@implementation ATBalanceRecordTopView


-(void)awakeFromNib {
    [super awakeFromNib];
    //如果发现控件的位置和尺寸不是自己设置的，那么有可能是自动伸缩属性导致
    self.autoresizingMask = UIViewAutoresizingNone;
    
}
+(instancetype)balanceRecordTopView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
@end
