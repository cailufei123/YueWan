//
//  YWMeTopView.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/27.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWMeTopView.h"
@interface YWMeTopView()


@property (weak, nonatomic) IBOutlet UILabel *followCountLb;
@property (weak, nonatomic) IBOutlet UILabel *coponCountLb;


@end
@implementation YWMeTopView
-(void)awakeFromNib{
    [super awakeFromNib];
    [self.pocketMoneyBt addTarget:self action:@selector(pocketMoneyBtClick) forControlEvents:UIControlEventTouchUpInside];
      [self.poconBt addTarget:self action:@selector(couponBtClick) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)couponBtClick{
    
  if (self.couponClick) {
    self.couponClick();
  }
}

-(void)pocketMoneyBtClick{
    if (self.followClick) {
        self.followClick();
    }
}

-(void)setMeModel:(YMMeModel *)meModel{
    LFLog(@"%@",meModel.user.icon);
    [self.userIcon sd_setBackgroundImageWithURL:[NSURL URLWithString:meModel.user.icon] forState:UIControlStateNormal];
    self.userNameLb.text = meModel.user.name;
     self.followCountLb.text=  meModel.userStat.followCount;
      self.coponCountLb.text=   meModel.userStat.fanCount;
}

+(instancetype)loadNameMeTopViewXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

@end
