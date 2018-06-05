//
//  YWXSPlayUsersView.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/5/8.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWXSPlayUsersView.h"
#import "YWAARoomGuestAlertView.h"
#import "YWXSRoomGusetAlertVIew.h"

@interface YWXSPlayUsersView()
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UILabel *userNameLb;

@property (weak, nonatomic) IBOutlet UILabel *userStatusLb;
@property (weak, nonatomic) IBOutlet UIButton *zanBt;
@property (weak, nonatomic) IBOutlet UILabel *mvpLb;
@property (weak, nonatomic) IBOutlet UILabel *statusLb;
@property(weak,nonatomic) YWAARoomGuestAlertView * aaRoomGuestAlertView;
@property (weak, nonatomic) IBOutlet UILabel *masterLb;

@end
@implementation YWXSPlayUsersView
-(void)awakeFromNib {
    [super awakeFromNib];
    
    self.autoresizesSubviews = NO;
    self.autoresizingMask = NO;
    [self.zanBt addTarget:self action:@selector(zanBtClick:) forControlEvents:UIControlEventTouchUpInside];
}

+(instancetype)loadNameXSPlayUsersView{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
-(void)setOtherModel:(YWPvosModel *)otherModel{
    _otherModel = otherModel;
    _otherModel1 = otherModel;
   
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:otherModel.userIcon]];
    self.userNameLb.text = otherModel.userName;
    
   
    if ([otherModel.isComment isEqualToString:@"0"]){
        self.zanBt.selected = NO;
    }else{
        self.zanBt.selected = YES;
    }
    
    if ([otherModel.userType isEqualToString:@"1"]) {
        self.masterLb.hidden = NO;
    }else{
        self.masterLb.hidden = YES;
    }
    
    if ([otherModel.status isEqualToString:@"1"]){
        
        self.statusLb.text = @"游戏中";
        self.mvpLb.hidden = YES;
       
        
      
    }else if([otherModel.status isEqualToString:@"2"]){
        if ([otherModel.isWin isEqualToString:@"0"]) {
            self.mvpLb.text = @"失败局";
        }else if([otherModel.isWin isEqualToString:@"1"]){
             self.mvpLb.text = @"胜利局";
        }
        

          self.statusLb.text = @"战绩待汇报";
          self.mvpLb.hidden = NO;
        if ([otherModel.roomType isEqualToString:@"1"]) {

              self.mvpLb.hidden = YES;
        }
        
    }else if([otherModel.status isEqualToString:@"4"]){
        LFLog(@"%@",otherModel.isMvp  );
        if ([otherModel.isMvp isEqualToString:@"0"]) {
            self.mvpLb.text = @"不是MVP";
        }else if([otherModel.isMvp isEqualToString:@"1"]){
            self.mvpLb.text = @"MVP";
        }
        self.statusLb.text = @"审核中";
        self.mvpLb.hidden = NO;
       
    }else if([otherModel.status isEqualToString:@"5"]){
        if ([otherModel.isMvp isEqualToString:@"0"]) {
            self.mvpLb.text = @"不是MVP";
        }else if([otherModel.isMvp isEqualToString:@"1"]){
            self.mvpLb.text = @"MVP";
        }
        self.statusLb.text = @"战绩待确认";
        self.mvpLb.hidden = YES;
        
    }else if([otherModel.status isEqualToString:@"201"]){
       
        self.statusLb.text = @"战绩超时";
        self.mvpLb.hidden = YES;
        
    }else if([otherModel.status isEqualToString:@"102"]){
        if ([otherModel.isMvp isEqualToString:@"0"]) {
            self.mvpLb.text = @"不是MVP";
        }else if([otherModel.isMvp isEqualToString:@"1"]){
            self.mvpLb.text = @"MVP";
        }
        self.statusLb.text = @"被驳回";
          self.mvpLb.hidden = NO;
    }else if([otherModel.status isEqualToString:@"103"]){
        if ([otherModel.isMvp isEqualToString:@"0"]) {
            self.mvpLb.text = @"不是MVP";
        }else if([otherModel.isMvp isEqualToString:@"1"]){
            self.mvpLb.text = @"MVP";
        }
        self.statusLb.text = @"已完成";
        self.mvpLb.hidden = NO;
    }else if([otherModel.status isEqualToString:@"202"]){
        self.statusLb.text = @"战绩已失效";
        self.mvpLb.hidden = YES;
        
    }else if([otherModel.status isEqualToString:@"101"]){
        if ([otherModel.isMvp isEqualToString:@"0"]) {
            self.mvpLb.text = @"不是MVP";
        }else if([otherModel.isMvp isEqualToString:@"1"]){
            self.mvpLb.text = @"MVP";
        }
        self.statusLb.text = @"已确认";
        self.mvpLb.hidden = NO;
        
    }
    
    if ([otherModel.userId isEqualToString:loginUid]&&[otherModel.status isEqualToString:@"2"]){
        [self.zanBt setImage:nil forState:UIControlStateNormal];
        [self.zanBt setImage:nil forState:UIControlStateSelected];
        [self.zanBt setTitle:@"汇报战绩" forState:UIControlStateSelected];
        // underline Terms and condidtions
        NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:@"汇报战绩"];
        self.zanBt .titleLabel.font = [UIFont systemFontOfSize:12];
        //设置下划线...
        /*
         NSUnderlineStyleNone                                    = 0x00, 无下划线
         NSUnderlineStyleSingle                                  = 0x01, 单行下划线
         NSUnderlineStyleThick NS_ENUM_AVAILABLE(10_0, 7_0)      = 0x02, 粗的下划线
         NSUnderlineStyleDouble NS_ENUM_AVAILABLE(10_0, 7_0)     = 0x09, 双下划线
         */
        [tncString addAttribute:NSUnderlineStyleAttributeName
                          value:@(NSUnderlineStyleSingle)
                          range:(NSRange){0,[tncString length]}];
        //此时如果设置字体颜色要这样
        [tncString addAttribute:NSForegroundColorAttributeName value:[SVGloble colorWithHexString:@"#6FA4FF"]  range:NSMakeRange(0,[tncString length])];
        
        //设置下划线颜色...
        [tncString addAttribute:NSUnderlineColorAttributeName value:[SVGloble colorWithHexString:@"#6FA4FF"] range:(NSRange){0,[tncString length]}];
        [self.zanBt setAttributedTitle:tncString forState:UIControlStateNormal];
    
    }
    
    
    
    if ([otherModel.userId isEqualToString:loginUid]){
      
        self.zanBt.hidden = YES;
    }else{
       self.zanBt.hidden = NO;
    }
    
    
 
}



-(void)zanBtClick:(UIButton * )bt{
    
    if (bt.titleLabel.text.length) {
        if ( [_otherModel.roomType isEqualToString:@"1"]) {
            [GKCover hide];
            WeakSelf(weakSelf)
            YWAARoomGuestAlertView * aaRoomGuestAlertView = [YWAARoomGuestAlertView loadNameAARoomGuestAlertViewXib];
            aaRoomGuestAlertView.aaGusetUpDataPlayGameRecord    = ^{
//                [weakSelf roomDatelis];
            };
            YWRoomModel * roomModel = [[YWRoomModel alloc] init];
            roomModel.roomInfo.gameId = _otherModel.gameId;
              roomModel.roomInfo.roomId = _otherModel.roomId;
            aaRoomGuestAlertView.roomModel =roomModel;
            aaRoomGuestAlertView.clf_size = CGSizeMake(LFscreenW-40, 260);
            [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:aaRoomGuestAlertView style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleCenter showAnimStyle:GKCoverShowAnimStyleNone hideAnimStyle:GKCoverHideAnimStyleNone notClick:YES showBlock:nil hideBlock:nil];
        }else if ( [_otherModel.roomType isEqualToString:@"3"]){
            WeakSelf(weakSelf)
            YWXSRoomGusetAlertVIew * xsRoomGuestAlertView = [YWXSRoomGusetAlertVIew loadNameXSRoomGusetAlertVIewXib];
//            xsRoomGuestAlertView.xsGusetUpDataPlayGameRecord    = ^{
//                [weakSelf roomDatelis];
//            };
            YWRoomModel * roomModel = [[YWRoomModel alloc] init];
            roomModel.roomInfo.gameId = _otherModel.gameId;
            roomModel.roomInfo.roomId = _otherModel.roomId;
            xsRoomGuestAlertView.roomModel =roomModel;
          
            xsRoomGuestAlertView.clf_size = CGSizeMake(LFscreenW-40, 260);
            [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:xsRoomGuestAlertView style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleCenter showAnimStyle:GKCoverShowAnimStyleNone hideAnimStyle:GKCoverHideAnimStyleNone notClick:YES showBlock:nil hideBlock:nil];
        }
        return;
    }
    NSMutableDictionary * praiseDict = diction;
    praiseDict[@"token"] = loginToken;
    praiseDict[@"userGameFlowId"] = _otherModel.userGameFlowId;
    praiseDict[@"userId"] =  _otherModel.userId;
    if (bt.selected == YES) {
        praiseDict[@"c"] = @"0";
    }else{
        praiseDict[@"c"] = @"1";
    }
    [YWRequestData praiseDict:praiseDict success:^(id responseObj) {
        if (bt.selected == YES) {
            bt.selected = NO;
        }else{
            bt.selected = YES;
        }
    }];
    
}

@end
