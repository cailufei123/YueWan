//
//  YWGuestEnterGameAlertView.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/24.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWGuestEnterGameAlertView.h"
@interface YWGuestEnterGameAlertView()






@property (weak, nonatomic) IBOutlet UIButton *closeBt;
@property (weak, nonatomic) IBOutlet UILabel *countDownLb;

@property(nonatomic,strong)NSTimer * timer;
@property(nonatomic,assign)NSInteger  count;
@end
@implementation YWGuestEnterGameAlertView


-(void)awakeFromNib{
    [super awakeFromNib];
    WeakSelf(weakSelf)
    self.count=4;
    self.timer = [NSTimer wh_scheduledTimerWithTimeInterval:1 repeats:YES callback:^(NSTimer *timer) {
        [weakSelf timerFireMethod];
    }];
//    [self.timer pauseTimer];
    [self.closeBt addTarget:self action:@selector(closeBtClick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)closeBtClick{
    [GKCover hideCover];
}
+(instancetype)loadNameuestEnterGameAlertViewXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
-(void)timerFireMethod{
[self.knowBt setTitle:[NSString stringWithFormat:@"还有 %ldS 进入游戏", self.count-- ] forState:UIControlStateNormal];
    if ( self.count<0) {
        [self.knowBt setTitle:@"进入游戏" forState:UIControlStateNormal];
          [self.timer hyb_invalidate];
    }
   
}
-(void)dealloc{
    [self.timer hyb_invalidate];
}
@end
