//
//  ATPresentCionViewCell.m
//  Auction
//
//  Created by 蔡路飞 on 2017/10/31.
//  Copyright © 2017年 Cailufei. All rights reserved.
//

#import "ATPresentCionViewCell.h"
@interface ATPresentCionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLb;

@property (weak, nonatomic) IBOutlet UILabel *cionLb;

@property (weak, nonatomic) IBOutlet UILabel *timeLb;
@end
@implementation ATPresentCionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setBalanceModel:(ATBalanceModel *)balanceModel{
    self.nameLb.text = balanceModel.typeV;
    self.timeLb.text = balanceModel.createTime;
      self.cionLb.text = [NSString stringWithFormat:@"%@%@",balanceModel.op, balanceModel.coin];
    if ([balanceModel.op isEqualToString:@"-"]) {
        self.cionLb.textColor = blackTextColor;
      
    }else{
        self.cionLb.textColor = [SVGloble colorWithHexString:@"#CD5643"];
         self.cionLb.text = [NSString stringWithFormat:@"%@%0.2lf",balanceModel.op,  [balanceModel.coin doubleValue]];

    }
   
   
}
-(void)setRecordListModel:(BalanceModel *)recordListModel{
    self.nameLb.text = [NSString stringWithFormat:@"%@(%@)",recordListModel.remark,recordListModel.statusName];
    self.timeLb.text = recordListModel.createTime;
    self.cionLb.text = [NSString stringWithFormat:@"%0.2lf",  [recordListModel.totalFee doubleValue]];
}
@end
