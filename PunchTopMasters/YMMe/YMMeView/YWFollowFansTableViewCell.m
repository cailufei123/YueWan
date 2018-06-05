//
//  YWFollowFansTableViewCell.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/5/11.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWFollowFansTableViewCell.h"
@interface YWFollowFansTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UILabel *userNameLb;
@property (weak, nonatomic) IBOutlet UILabel *sagmentLb;

@end
@implementation YWFollowFansTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)setFanModel:(YWFanModel *)fanModel{
    
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:fanModel.icon]];
    self.userNameLb.text = fanModel.name;
    self.sagmentLb.text = [NSString stringWithFormat:@"开黑：%@ 点赞：%@",fanModel.gameCount,fanModel.commentScore];
}
@end
