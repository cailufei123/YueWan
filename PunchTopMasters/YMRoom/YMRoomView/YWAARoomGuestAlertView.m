//
//  YWAARoomGuestAlertView.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/25.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWAARoomGuestAlertView.h"
@interface YWAARoomGuestAlertView()
@property (weak, nonatomic) IBOutlet UIButton *closeBt;
@end
@implementation YWAARoomGuestAlertView
-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self.closeBt addTarget:self action:@selector(closeBtClick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)closeBtClick{
    [GKCover hideCover];
}
+(instancetype)loadNameAARoomGuestAlertViewXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

- (IBAction)mvpBtClick:(id)sender {//mvp
    [self isMvp:@"1"];
}

- (IBAction)nomvpBtClick:(id)sender {//不是mvp
    [self isMvp:@"0"];
}
-(void)isMvp:(NSString * )mvp{
    
    NSMutableDictionary * playGameRecordDit = diction;
    playGameRecordDit[@"token"] = loginToken;
    playGameRecordDit[@"gameId"] = self.roomModel.roomInfo.gameId;
    playGameRecordDit[@"roomId"] = self.roomModel.roomInfo.roomId;
    [YWRequestData playGameRecordDict:playGameRecordDit success:^(YWPlayGameRecordModel *playGameRecordModel) {
        NSMutableDictionary * mvpDit = diction;
        mvpDit[@"token"] = loginToken;
        mvpDit[@"userGameFlowId"] = playGameRecordModel.ID;
        mvpDit[@"isMvp"] = mvp;
        [YWRequestData saveMVPDict:mvpDit success:^(id responseObj) {
            [GKCover hideCover];
            if (self.aaGusetUpDataPlayGameRecord) {
                 self.aaGusetUpDataPlayGameRecord();
            }else{
                [LFNSNOTI postNotificationName:masterReportPlayGame object:nil];
            }
           
        }];
    }];
    
    
    
    
}
@end
