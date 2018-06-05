//
//  YWSBRoomMasterAlertView.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/25.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWSBRoomMasterAlertView.h"
#import "YWRoomMasterReportAlertView.h"
@interface YWSBRoomMasterAlertView()
@property (weak, nonatomic) IBOutlet UIButton *closeBt;
@end
@implementation YWSBRoomMasterAlertView
-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self.closeBt addTarget:self action:@selector(closeBtClick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)closeBtClick{
    [GKCover hideCover];
}
+(instancetype)loadNameSBRoomMasterAlertViewXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
- (IBAction)approveBtclick:(id)sender {
    [self approve];
}
- (IBAction)dontApproveBtClick:(id)sender {
     [self dontApprove];
}

-(void)approve{
    NSMutableDictionary * playGameRecordDit = diction;
    playGameRecordDit[@"token"] = loginToken;
    playGameRecordDit[@"gameId"] = self.roomModel.roomInfo.gameId;
    playGameRecordDit[@"roomId"] = self.roomModel.roomInfo.roomId;
    [YWRequestData playGameRecordDict:playGameRecordDit success:^(YWPlayGameRecordModel *playGameRecordModel) {
        
        NSMutableDictionary * approveDit = diction;
        approveDit[@"token"] = loginToken;
        approveDit[@"userGameFlowId"] = playGameRecordModel.ID;
        [YWRequestData confirmInningsDict:approveDit success:^(id responseObj) {
            [GKCover hideCover];
            self.sbMasterUpDataPlayGameRecord();
        }];
    }];
    
   
    
}
-(void)dontApprove{
//    NSMutableDictionary * playGameRecordDit = diction;
//    playGameRecordDit[@"token"] = loginToken;
//    playGameRecordDit[@"gameId"] = self.roomModel.roomInfo.gameId;
//    playGameRecordDit[@"roomId"] = self.roomModel.roomInfo.roomId;
//    [YWRequestData playGameRecordDict:playGameRecordDit success:^(id responseObj) {
//
//    }];
     [GKCover hideCover];
    WeakSelf(weakSelf)
    YWRoomMasterReportAlertView * masterReportAlertView  = [YWRoomMasterReportAlertView loadNameRoomMasterReportAlertViewXib];
  
    masterReportAlertView.roomModel = self.roomModel;
    masterReportAlertView.clf_size = CGSizeMake(LFscreenW-40, 260);
    [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:masterReportAlertView style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleCenter showAnimStyle:GKCoverShowAnimStyleNone hideAnimStyle:GKCoverHideAnimStyleNone notClick:YES showBlock:nil hideBlock:nil];
}

@end
