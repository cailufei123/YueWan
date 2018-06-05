//
//  YWCouponTableViewCell.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/5/2.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWCouponTableViewCell.h"
@interface YWCouponTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *moneyLB;
@property (weak, nonatomic) IBOutlet UILabel *manLb;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLb;
//@property (weak, nonatomic) IBOutlet UIImageView *vourcherBg;
@property (weak, nonatomic) IBOutlet UIImageView *useStatusImageView;
@end

@implementation YWCouponTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)setVourcherModel:(SAVourcherModel *)vourcherModel{
    _vourcherModel = vourcherModel;
    self.moneyLB.text = vourcherModel.price;
    self.manLb.text = [vourcherModel.man integerValue]>0?[NSString stringWithFormat:@"满%@可用",vourcherModel.man]:@"无门槛红包";
    NSString * lastTime = [USER_DEFAULT objectForKey:cheackVourcherLastTime];
    _selectVourcherModel = vourcherModel;
    self.moneyLB.text = vourcherModel.price;
    self.manLb.text = [vourcherModel.man integerValue]>0?[NSString stringWithFormat:@"满%@可用",vourcherModel.man]:@"无门槛红包";
    self.endTimeLb.text =  [self getCurrentTime ];
    if ([vourcherModel.status isEqualToString:@"0"]) {//;0：未使用；
//        self.vourcherBg.image = [UIImage imageNamed:@""];
        self.useStatusImageView.hidden = YES;//状态
    }else if ([vourcherModel.status isEqualToString:@"1"]) {//1:已经使
//        self.vourcherBg.image = [UIImage imageNamed:@"used_top_bg"];//背景图片
        self.useStatusImageView.hidden = NO;//状态
        self.useStatusImageView.image = [UIImage imageNamed:@"coupon_alreadyuse"];//状态图片
        
    }else{//2：过期；
//        self.vourcherBg.image = [UIImage imageNamed:@"used_top_bg"];//背景图片
        self.useStatusImageView.hidden = NO;//状态
        self.useStatusImageView.image = [UIImage imageNamed:@"coupon_overdue"];//状态图片
        
    }
    self.endTimeLb.text =  [self getCurrentTimestamp ];
}
//获取当前时间的时间戳
-(NSString*)getCurrentTimestamp{
    
    NSDate* dat = [NSDate date];
    NSTimeInterval a =[dat timeIntervalSince1970];
    NSString * timeString =nil;
    if ([_vourcherModel.startDate doubleValue]>a) {
        timeString = [NSString stringWithFormat:@"%@-%@",_vourcherModel.startDate,_vourcherModel.endDate];
    }else{
        timeString = [NSString stringWithFormat:@"有效期至：%@",_vourcherModel.endDate];
    }
    
    return timeString;
}

-(void)setSelectVourcherModel:(SAVourcherModel *)selectVourcherModel{
    _selectVourcherModel = selectVourcherModel;
    self.moneyLB.text = selectVourcherModel.price;
    self.manLb.text = [selectVourcherModel.man integerValue]>0?[NSString stringWithFormat:@"满%@可用",selectVourcherModel.man]:@"无门槛红包";
    self.endTimeLb.text =  [self getCurrentTime ];
    if ([selectVourcherModel.status isEqualToString:@"0"]) {//;0：未使用；
 
     
        self.useStatusImageView.hidden = YES;//状态
    }else if ([selectVourcherModel.status isEqualToString:@"1"]) {//1:已经使
    
        self.useStatusImageView.hidden = NO;//状态
        self.useStatusImageView.image = [UIImage imageNamed:@"coupon_alreadyuse"];//状态图片
        
    }else{//2：过期；
      
        self.useStatusImageView.hidden = NO;//状态
        self.useStatusImageView.image = [UIImage imageNamed:@"coupon_overdue"];//状态图片
        
    }
    
    
}
//获取当前时间的时间戳
-(NSString*)getCurrentTime{
    
    NSDate* dat = [NSDate date];
    NSTimeInterval a =[dat timeIntervalSince1970];
    NSString * timeString =nil;
    if ([_selectVourcherModel.startDate doubleValue]>a) {
        timeString = [NSString stringWithFormat:@"%@-%@",_selectVourcherModel.startDate,_selectVourcherModel.endDate];
    }else{
        timeString = [NSString stringWithFormat:@"有效期至：%@",_selectVourcherModel.endDate];
    }
    timeString = [NSString stringWithFormat:@"有效期至：%@",_selectVourcherModel.endDate];
    return timeString;
}

@end
