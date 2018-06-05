//
//  YWVoucherAlertViewCell.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/5/16.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWVoucherAlertViewCell.h"
@interface YWVoucherAlertViewCell()
@property (weak, nonatomic) IBOutlet UILabel *moneyNumberLb;
@property (weak, nonatomic) IBOutlet UILabel *limitUseLb;
@property (weak, nonatomic) IBOutlet UILabel *effectiveDateLB;


@property (strong, nonatomic) SAVourcherModel * firstVourcherModel;

@property (strong, nonatomic)NSString * status;

@end
@implementation YWVoucherAlertViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setVourcherModel:(SAVourcherModel *)vourcherModel{
    
    LFLog(@"%@",vourcherModel.title);
    
    NSString * priceStr = [NSString stringWithFormat:@"￥%@",vourcherModel.price];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:priceStr];
    [attrString addAttribute:NSFontAttributeName
                       value:[UIFont systemFontOfSize:13.0f]
                       range:NSMakeRange(0, 1)];
    
    self.moneyNumberLb.attributedText = attrString;
    if ([vourcherModel.man doubleValue]>0) {
        self.limitUseLb.text = [NSString stringWithFormat:@"满%@元可用",vourcherModel.man];
    }else{
        
        self.limitUseLb.text =@"无门槛红包";
    }
    self.effectiveDateLB.text =[NSString stringWithFormat:@"有效期至：%@",vourcherModel.endDate];
}

@end
