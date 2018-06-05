//
//  YWGusetRoomStartGameAlertVIew.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/24.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWGusetRoomStartGameAlertVIew.h"
@interface YWGusetRoomStartGameAlertVIew()
@property (weak, nonatomic) IBOutlet UIButton *closeBt;
@property (weak, nonatomic) IBOutlet UILabel *countDownLb;
@property (weak, nonatomic) IBOutlet UIButton *knowBt;
@property(nonatomic,strong)NSTimer * timer;
@property(nonatomic,assign)NSInteger  count;
@end
@implementation YWGusetRoomStartGameAlertVIew

-(void)awakeFromNib{
    [super awakeFromNib];
    self.count = 0;
    WeakSelf(weakSelf)
    self.timer = [NSTimer wh_scheduledTimerWithTimeInterval:1 repeats:YES callback:^(NSTimer *timer) {
        [weakSelf timerFireMethod];
    }];
//    [self.timer pauseTimer];

    [self.closeBt addTarget:self action:@selector(closeBtClick) forControlEvents:UIControlEventTouchUpInside];
      [self.knowBt addTarget:self action:@selector(closeBtClick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)closeBtClick{
    [GKCover hideCover];
}
+(instancetype)loadNameGusetRoomStartGameAlertVIewXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
-(void)timerFireMethod{
    if ( self.count>30) {
        [self.timer hyb_invalidate];
    }
    self.countDownLb.text =[NSString stringWithFormat:@"房主正在启动游戏，%02ld秒", self.count++ ];
}
-(void)dealloc{
     [self.timer hyb_invalidate];
}
@end
