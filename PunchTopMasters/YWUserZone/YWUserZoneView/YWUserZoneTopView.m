//
//  YWUserZoneTopView.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/5/8.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWUserZoneTopView.h"
@interface YWUserZoneTopView()
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UILabel *userNameLb;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLb;

@property (weak, nonatomic) IBOutlet UILabel *playRecordLb;
@property (weak, nonatomic) IBOutlet UILabel *kaiheiLb;
@property (weak, nonatomic) IBOutlet UILabel *mvpLb;
@property (weak, nonatomic) IBOutlet UILabel *zanLb;
@end
@implementation YWUserZoneTopView

-(void)awakeFromNib {
    [super awakeFromNib];
    
    self.autoresizesSubviews = NO;
    self.autoresizingMask = NO;
 
}

+(instancetype)loadNameUserZoneTopView{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
-(void)setMeModel:(YMMeModel *)meModel{
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:meModel.user.icon]];
    self.userNameLb.text = meModel.user.name;
    self.subTitleLb.text = [NSString stringWithFormat:@"关注 %@ 粉丝 %@",meModel.userStat.followCount,meModel.userStat.fanCount] ;
     self.playRecordLb.text = [NSString stringWithFormat:@"我在约玩APP开黑%@局，拿过%@个MVP",meModel.gameCount,meModel.mvpCount] ;
    self.kaiheiLb.text = meModel.gameCount;
     self.mvpLb.text = meModel.mvpCount;
}
@end
