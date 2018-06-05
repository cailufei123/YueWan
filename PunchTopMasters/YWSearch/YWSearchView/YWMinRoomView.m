//
//  YWMinRoomView.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/10.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWMinRoomView.h"
#import "YMMeModel.h"
#import "EaseSDKHelper.h"
@interface YWMinRoomView()
@property (weak, nonatomic) IBOutlet UILabel *roomLagoLb;
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UIButton *gameArebt;
@property (weak, nonatomic) IBOutlet UIButton *numberbt;
@property (weak, nonatomic) IBOutlet UIButton *closeBt;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIView *bigView;
@end
@implementation YWMinRoomView
-(void)awakeFromNib{
    [super awakeFromNib];
    self.bgView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.bgView.layer.borderWidth = 1;
}


+(instancetype)loadNameMinRoomViewXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
-(void)setMyRoomModel:(YWMyRoomModel *)myRoomModel{
    _myRoomModel = myRoomModel;
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:myRoomModel.userLogo] placeholderImage:nil];
    self.roomLagoLb.text = myRoomModel.roomSlogan;
    if ([myRoomModel.gameArea isEqualToString:@"1"]) {
        self.gameArebt.selected = NO;
    }else if([myRoomModel.gameArea isEqualToString:@"2"]) {
        self.gameArebt.selected = YES;
    }
    [self.numberbt setTitle:[NSString stringWithFormat:@"人员:%@/%@",myRoomModel.currentQueueCount,myRoomModel.requireQueueCount] forState:UIControlStateNormal];
    [self.closeBt addTarget:self action:@selector(closeBtClick:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)closeBtClick:(UIButton * )bt{
    
     NSMutableDictionary * dic = diction;dic[@"token"] =  loginToken;
    
    [YWRequestData myRoomDict:dic success:^(id responseObj) {
       YWMyRoomModel * myRoomModel = [YWMyRoomModel mj_objectWithKeyValues:responseObj[@"data"]];
        if ([myRoomModel.isInQueue isEqualToString:@"1"]) {
           
           
            NSMutableDictionary *  getRoomDic = diction;getRoomDic[@"id"] = myRoomModel.roomId;
            [YWRequestData getRoomDetailsDict:getRoomDic success:^(id responseObj) {
                YWRoomModel * roomModel = [YWRoomModel mj_objectWithKeyValues:responseObj[@"data"]];
                if ([roomModel.roomInfo.gameStatus isEqualToString:@"1"]) {
                    [MBManager showBriefAlert:@"游戏启动中不能解散房间"];
                    return ;
                    
                }else  if ([roomModel.roomInfo.gameStatus isEqualToString:@"2"]) {
                    [MBManager showBriefAlert:@"游戏中不能解散房间"];
                    return ;
                }
                
                
                if ([myRoomModel.userId isEqualToString:loginUid]) {//我自己创建的房间
                    NSMutableDictionary * deledict = diction;
                    deledict[@"roomId"] = myRoomModel.roomId;
                    [YWRequestData deleRoomDict:deledict success:^(id responseObj) {//删除房间
                        self.hidden = YES;
                           EMError *error = [[EMClient sharedClient].roomManager destroyChatroom:myRoomModel.roomId];
                        self. masterDissolutionRoom();
                    }];
                }else{
                    NSMutableDictionary * quitdic = diction;quitdic[@"token"] =  loginToken;quitdic[@"gameId"] =  _myRoomModel.gameId;quitdic[@"roomId"] =  _myRoomModel.roomId;
                    [YWRequestData quitQueueeDict:quitdic success:^(id responseObj) {
                        [self leaveRoom];
                    }];
                }
           
            }];
            
            
            
            
            
            
               
           
        }else{
            [self leaveRoom];
        }
    }];
  
    
    
   
    
}
-(void)leaveRoom{
    NSMutableDictionary * di = diction;
    di[@"roomId"] =  _myRoomModel.roomId;
    di[@"userId"] =loginUid;
    [YWRequestData leaveRoomDict:di success:^(id responseObj) {//离开房间
        self.hidden = YES;
        [self enterSendMessage:@"退出房间"];
        [[EMClient sharedClient].roomManager leaveChatroom:_myRoomModel.roomId completion:^(EMError *aError) {
            if (!aError) {
                
            }
        }];
    }];
    
}
#pragma mark --------发送消息------------------
- (void)enterSendMessage:(NSString * )messageText{
    NSMutableDictionary * dict = diction;
    dict[@"userId"] = loginUid;
    dict[@"isStat"] = @"0";
    [YWRequestData userHomePageDict:dict success:^(id responseObj) {
        YMMeModel * meModel = [YMMeModel mj_objectWithKeyValues:responseObj[@"data"]];
         [USER_DEFAULT setObject:meModel.user.icon forKey:loginToken];
        NSMutableDictionary *  messageExt = diction;
        messageExt[@"userName"] = meModel.user.name;
        messageExt[@"userIcon"] = meModel.user.icon;
        messageExt[@"userId"] = meModel.user.userId;
       
        EMMessage *mess = [EaseSDKHelper getTextMessage:messageText to:self.myRoomModel.huanChatId  messageType:EMChatTypeChatRoom messageExt:messageExt];
        //注册消息回调
        [[EMClient sharedClient].chatManager sendMessage:mess progress:nil completion:^(EMMessage *message, EMError *error) {
            
            if (!error) {
             
            }
        }];
        
    }];
    
}
@end
