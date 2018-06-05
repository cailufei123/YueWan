//
//  YWMasterCheakGusetMessageAlertView.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/17.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWMasterCheakGusetMessageAlertView.h"
#import "YWUpDownButton.h"
@interface YWMasterCheakGusetMessageAlertView()
@property (weak, nonatomic) IBOutlet UIButton *userImgIcon;

@property (weak, nonatomic) IBOutlet UILabel *userNameLb;
@property (weak, nonatomic) IBOutlet UILabel *openNumberLb;
@property (weak, nonatomic) IBOutlet UILabel *winNumberLb;
@property (weak, nonatomic) IBOutlet UILabel *MVPnumber;
@property (weak, nonatomic) IBOutlet UIView *kickRoomView;
@property (weak, nonatomic) IBOutlet UIButton *followBt;

@property (weak, nonatomic) IBOutlet UIView *removeQueueVIew;
@property (weak, nonatomic) IBOutlet UIButton *privateChatBt;
@end
@implementation YWMasterCheakGusetMessageAlertView

-(void)awakeFromNib{
    [super awakeFromNib];
    [SVGloble gradientLayer:self.followBt];
     [SVGloble gradientLayer:self.privateChatBt];
    [self.followBt addTarget:self action:@selector(followBtClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.privateChatBt addTarget:self action:@selector(privateChatBtClick) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer * kickRoomtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(kickRoom)];
      UITapGestureRecognizer * removeQueuetap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeQueue)];
    [self.kickRoomView addGestureRecognizer:kickRoomtap];
      [self.removeQueueVIew addGestureRecognizer:removeQueuetap];
    
}
-(void)kickRoom{
   
    NSMutableDictionary *delPersonDict = diction;
    delPersonDict[@"roomId"] =  self.roomModel.roomInfo.roomId;
    delPersonDict[@"userId"] =  _userHomePageModel.user.userId;
    
    NSMutableDictionary *kickQueueDict = diction;
    kickQueueDict[@"roomId"] = self.roomModel.roomInfo.roomId;
    kickQueueDict[@"userId"] =  _userHomePageModel.user.userId;
    kickQueueDict[@"gameId"] = self.roomModel.roomInfo.gameId;
    kickQueueDict[@"token"] = loginToken;
    [YWRequestData kickQueueDict:kickQueueDict success:^(id responseObj) {
        
        [YWRequestData delPersonRoomDict:delPersonDict success:^(id responseObj) {
            [[EMClient sharedClient].roomManager removeMembers:@[ _userHomePageModel.user.huanId] fromChatroom:self.roomModel.roomInfo.huanChatId completion:^(EMChatroom *aChatroom, EMError *aError) {
                 NSMutableDictionary *userInfo = diction;
                userInfo[@"userId"] =  _userHomePageModel.user.userId;
                [LFNSNOTI postNotificationName:enterQueueRefresh object:kickRoom userInfo:userInfo];
                [GKCover hideCover];
            }];
            
        }];
    }];
    
}
-(void)removeQueue{
    
    NSMutableDictionary *kickQueueDict = diction;
    kickQueueDict[@"roomId"] = self.roomModel.roomInfo.roomId;
    kickQueueDict[@"userId"] =  _userHomePageModel.user.userId;
    kickQueueDict[@"gameId"] = self.roomModel.roomInfo.gameId;
    kickQueueDict[@"token"] = loginToken;
    [YWRequestData kickQueueDict:kickQueueDict success:^(id responseObj) {
        NSMutableDictionary *userInfo = diction;
        userInfo[@"userId"] =  _userHomePageModel.user.userId;
          [LFNSNOTI postNotificationName:enterQueueRefresh object:removeQueue userInfo:userInfo];
         [GKCover hideCover];
    }];
}
//#pragma mark --------发送消息------------------
//- (void)enterSendMessage:(NSString * )messageText{
//    NSMutableDictionary * dict = diction;
//    dict[@"userId"] = loginUid;
//    dict[@"isStat"] = @"0";
//    WeakSelf(weakSelf)
//    [YWRequestData userHomePageDict:dict success:^(id responseObj) {
//        YMMeModel * meModel = [YMMeModel mj_objectWithKeyValues:responseObj[@"data"]];
//        
//        NSMutableDictionary *  messageExt = diction;
//        messageExt[@"userName"] = meModel.user.name;
//        messageExt[@"userIcon"] = meModel.user.icon;
//        messageExt[@"userId"] = meModel.user.userId;
//        messageExt[@"enterQueue"] = @"enterQueue";
//        EMMessage *mess = [EaseSDKHelper getTextMessage:messageText to:weakSelf.roomModel.roomInfo.huanChatId  messageType:EMChatTypeChatRoom messageExt:messageExt];
//        //注册消息回调
//        [[EMClient sharedClient].chatManager sendMessage:mess progress:nil completion:^(EMMessage *message, EMError *error) {
//            
//            if (!error) {
//              
//            }
//        }];
//        
//    }];
//    
//}
+(instancetype)loadNameMasterCheakGusetMessageAlertViewXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
-(void)setUserHomePageModel:(YMMeModel *)userHomePageModel{
    _userHomePageModel = userHomePageModel;
    [self.userImgIcon sd_setImageWithURL:[NSURL URLWithString:userHomePageModel.user.icon] forState:UIControlStateNormal];
    self.openNumberLb.text =[NSString stringWithFormat:@"开黑数： %@",userHomePageModel.gameCount];
    self.winNumberLb.text =[NSString stringWithFormat:@"获赞数： %@",userHomePageModel.userStat.commentScore];
     self.MVPnumber.text =[NSString stringWithFormat:@"MVP： %@",userHomePageModel.mvpCount];
    self.userNameLb.text = userHomePageModel.user.name;
    NSMutableDictionary * followExtDit = diction;
    followExtDit[@"token"] = loginToken;
    followExtDit[@"followUserId"] = userHomePageModel.user.userId;
    [YWRequestData followExitDict:followExtDit success:^(id responseObj) {
        if ([responseObj[@"data"] isEqual:@(0)]) {
              [self.followBt setTitle:@"加关注" forState:UIControlStateNormal];
        }else{
             [self.followBt setTitle:@"已关注" forState:UIControlStateNormal];
        }
    }];
    
}
-(void)followBtClick:(UIButton *)bt{
    if ([bt.titleLabel.text isEqualToString:@"已关注"]) {
        [MBManager showBriefAlert:@"已经关注"];
        return;
    }
    
      NSMutableDictionary * followDit = diction;
    followDit[@"token"] = loginToken;
    followDit[@"followUserId"] = _userHomePageModel.user.userId;
    [YWRequestData followUserDict:followDit success:^(id responseObj) {
        [MBManager showBriefAlert:@"关注成功"];
        [bt setTitle:@"已关注" forState:UIControlStateNormal];
    }];
}
-(void)privateChatBtClick{
    [GKCover hideCover];
       NSMutableDictionary * nterChatDit = diction;
     nterChatDit[@"name"] =  _userHomePageModel.user.name;
     nterChatDit[@"huanId"] =  _userHomePageModel.user.huanId;
     nterChatDit[@"icon"] =  _userHomePageModel.user.icon;
     [LFNSNOTI postNotificationName:enterChatPage object:_userHomePageModel.user.huanId userInfo:nterChatDit];
 
   
}
@end
