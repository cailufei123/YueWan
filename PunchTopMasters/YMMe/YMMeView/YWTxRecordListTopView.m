//
//  YWTxRecordListTopView.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/5/10.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWTxRecordListTopView.h"

@implementation YWTxRecordListTopView


-(void)awakeFromNib {
    [super awakeFromNib];
    //如果发现控件的位置和尺寸不是自己设置的，那么有可能是自动伸缩属性导致
    self.autoresizingMask = UIViewAutoresizingNone;
    
}
+(instancetype)balanceTxRecordListTopView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
@end
