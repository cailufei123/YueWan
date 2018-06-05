//
//  YWZoneFootView.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/5/8.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWZoneFootView.h"

@implementation YWZoneFootView
-(void)awakeFromNib {
    [super awakeFromNib];
    
    self.autoresizesSubviews = NO;
    
}

+(instancetype)zoneFootView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}


@end
