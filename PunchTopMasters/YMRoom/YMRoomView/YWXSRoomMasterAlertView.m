//
//  YWXSRoomMasterAlertView.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/25.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWXSRoomMasterAlertView.h"
#import "YWAARoomMasterAlertView.h"
@interface YWXSRoomMasterAlertView()
@property (weak, nonatomic) IBOutlet UIButton *closeBt;
@end
@implementation YWXSRoomMasterAlertView
-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self.closeBt addTarget:self action:@selector(closeBtClick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)closeBtClick{
    [GKCover hideCover];
}
+(instancetype)loadNameXSRoomMasterAlertViewXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
//胜利
- (IBAction)winGameBtClick:(id)sender {
    [self isWineGame:@"1"];
}
- (IBAction)faileGameBtClick:(id)sender {
    [self isWineGame:@"0"];
    
}
-(void)isWineGame:(NSString * )win{
    NSMutableDictionary * playGameRecordDit = diction;
    playGameRecordDit[@"token"] = loginToken;
    playGameRecordDit[@"gameId"] = self.roomModel.roomInfo.gameId;
    playGameRecordDit[@"roomId"] = self.roomModel.roomInfo.roomId;
    [YWRequestData playGameRecordDict:playGameRecordDit success:^(YWPlayGameRecordModel *playGameRecordModel) {
        NSMutableDictionary * winDit = diction;
        winDit[@"token"] = loginToken;
        winDit[@"userGameFlowId"] = playGameRecordModel.ID;
        winDit[@"isWin"] = win;
        [YWRequestData winInningsDict:winDit success:^(id responseObj) {
            [GKCover hideCover];
           [self ismvp];
        }];
    }];
    
}
-(void)ismvp{
    YWAARoomMasterAlertView * aaRoomMasterAlertView  = [YWAARoomMasterAlertView loadNameAARoomMasterAlertViewXib];
    aaRoomMasterAlertView.roomModel = self.roomModel;
    aaRoomMasterAlertView.clf_size = CGSizeMake(LFscreenW-40, 260);
    [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:aaRoomMasterAlertView style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleCenter showAnimStyle:GKCoverShowAnimStyleNone hideAnimStyle:GKCoverHideAnimStyleNone notClick:YES showBlock:nil hideBlock:nil];
}

@end
