//
//  YMRoomViewController.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/3/26.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YMRoomViewController.h"
#import "YWCreteBtView.h"
#define room @"44457543139329"
#import "YWRoomModel.h"
#import "YWRoomDeatilsLeftView.h"
#import "YWRoomChatTableViewCell.h"
#import "YWRoomChatTableTopView.h"
#import "YMMeModel.h"
#import "EaseSDKHelper.h"
#import "EaseMessageModel.h"
#import "YWRoomMeCheckMeView.h"
#import "YWGusetCheckGusetView.h"

#import "YWChatViewController.h"

#import "YWEnterGameFirstStepViewAlertView.h"
#import "YWEnterGamesecSecondStepViewAlertView.h"
#import "YWShareFriendAlertView.h"
#import "YWEnterGameThirdStepAlertView.h"
#import "YWGusetRoomStartGameAlertVIew.h"
#import "YWGuestEnterGameAlertView.h"

#import "YWAARoomMasterAlertView.h"
#import "YWSBRoomMasterAlertView.h"
#import "YWXSRoomMasterAlertView.h"
#import "YWAARoomGuestAlertView.h"
#import "YWSBRoomGusetAlertView.h"
#import "YWXSRoomGusetAlertVIew.h"
#import "YWRoomCountViewController.h"
@interface YMRoomViewController ()<UITextFieldDelegate,  EMChatManagerDelegate, EMChatroomManagerDelegate,UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *iocnBgView;
@property (weak, nonatomic) IBOutlet UIButton *roomMasterIcon;
@property (weak, nonatomic) IBOutlet UILabel *masterName;

@property (weak, nonatomic) IBOutlet UILabel *masterDanlb;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITableView *chatTableView;
@property (weak, nonatomic) IBOutlet UIButton *cahtBt;
@property (weak, nonatomic) IBOutlet UILabel *priceLb;
@property (weak, nonatomic) IBOutlet UIButton *playGameBt;
@property(assign,nonatomic)NSInteger  count;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttomLyoutH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewLyout;
@property (weak, nonatomic) IBOutlet UIImageView *roomTypeImage;
@property (weak, nonatomic) IBOutlet UIView *roomNumberView;
@property (weak, nonatomic) IBOutlet UILabel *roomNumberLb;

@property(strong,nonatomic) UIView * bottom;
@property(strong,nonatomic) UITextField * chatTf;
@property(strong,nonatomic) YWRoomModel * roomModel;

@property(strong,nonatomic) NSMutableArray * creteBtViews;
@property(strong,nonatomic) NSMutableArray * gameQueueModels;
@property(strong,nonatomic) YWRoomDeatilsLeftView * rightDrawerView;
@property (nonatomic,assign) CGPoint                initialPosition;     //初始位置
@property (nonatomic,strong) UIView                 *shawdowView;
@property (nonatomic,assign) int lasti;
@property (nonatomic,assign)  NSInteger maxCols ;



@property(strong,nonatomic) NSString * startGameLink;
@property (weak, nonatomic) IBOutlet UIButton *gameStatusBt;

/*!
 @property
 @brief 显示的EMMessage类型的消息列表
 */
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSMutableArray *messsagesSource;
@end
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height
#define ScreenWidth   [UIScreen mainScreen].bounds.size.width
#define SHAWDOW_ALPHA 0.5
#define MENU_DURATION 0.3
#define RIGHT_VIEW_WIDTH (ScreenWidth/2) - 50 + (ScreenWidth/2)
#define RIGHT_VIEW_WIDTH 70
static NSString * const cellidenfder = @"YWRoomChatTableViewCell";
@implementation YMRoomViewController
-(NSMutableArray *)gameQueueModels{
    if (!_gameQueueModels) {
        _gameQueueModels = [NSMutableArray array];
    }
    return _gameQueueModels;
}
-(NSMutableArray *)creteBtViews{
    if (!_creteBtViews) {
        _creteBtViews = [NSMutableArray array];
    }
    return _creteBtViews;
}
//-(NSMutableArray *)messsagesSource{
//    if (!_messsagesSource) {
//        _messsagesSource = [NSMutableArray array];
//    }
//    return _messsagesSource;
//}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.rightDrawerView removeFromSuperview];
     [IQKeyboardManager sharedManager].enable = YES;
    [LFNSNOTI removeObserver:self];
    
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = NO;
    [LFNSNOTI addObserver:self selector:@selector(enterQueue:) name:enterQueueRefresh object:nil];
    [LFNSNOTI addObserver:self selector:@selector(enterChatVc:) name:enterChatPage object:nil];
    [LFNSNOTI addObserver:self selector:@selector(enterForegroundRoom) name:enterForegroundRoom object:nil];
    [LFNSNOTI addObserver:self selector:@selector(masterReportPlayG) name:masterReportPlayGame object:nil];
    
    [self addNoticeForKeyboard];
     [self roomDatelis];
}
-(void)masterReportPlayG{
    
    [self roomDatelis];
}

-(void)enterForegroundRoom{//从后台到前台
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[EMClient sharedClient].roomManager joinChatroom:self.roomModel.roomInfo.huanChatId completion:^(EMChatroom *aChatroom, EMError *aError) {

        }];
    });
    [[EMClient sharedClient].roomManager joinChatroom:self.roomModel.roomInfo.huanChatId completion:^(EMChatroom *aChatroom, EMError *aError) {
        
                }];
      [self roomDatelis];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.chatTableView.delegate = self;
    self.chatTableView.dataSource = self;
  self.navigationItem.rightBarButtonItem =  [UIBarButtonItem itemWithImage:@"room_rightVIew_skip" selectImage:@"room_rightVIew_skip" target:self action:@selector(skipRightView) ];
      [self setUI];

    self.gameStatusBt.hidden = YES;
    [self maskToCorner:self.roomNumberView RoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRedius:CGSizeMake(15.0f,15.0f)];
       [self maskToCorner:self.gameStatusBt RoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRedius:CGSizeMake(15.0f,15.0f)];
      UITapGestureRecognizer * roomNumbertap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(roomNumbertap)];
    [self.roomNumberView addGestureRecognizer:roomNumbertap];
    
    UITapGestureRecognizer * danTftap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(danTftap)];
    
    [self.view addGestureRecognizer:danTftap];
//    [EMCDDeviceManager sharedInstance].delegate = self;
   
    [[EMClient sharedClient].roomManager addDelegate:self delegateQueue:nil];
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
   
    [self createLeftRoom];
    [self.chatTableView registerNib:[UINib nibWithNibName:cellidenfder bundle:nil] forCellReuseIdentifier:cellidenfder];
   
    NSMutableDictionary * dic = diction;dic[@"id"] =self.roomId;

     [self enterRooomDatelis];
    [self.roomMasterIcon addTarget:self action:@selector(roomMasterIconClick) forControlEvents:UIControlEventTouchUpInside];
    [self.playGameBt addTarget:self action:@selector(playGameBtClick) forControlEvents:UIControlEventTouchUpInside];
    [self.gameStatusBt addTarget:self action:@selector(gameStatusBtClick) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)roomNumbertap{
    YWRoomCountViewController * roomCountVc = [[YWRoomCountViewController alloc] init];
    roomCountVc.roomId = self.roomId;
    [self.navigationController pushViewController:roomCountVc animated:YES];
}
#pragma mark   开始游戏，启动中，游戏中 点击游戏状态按钮
-(void)gameStatusBtClick{
    if ([self.roomModel.roomInfo.userId isEqualToString:loginUid]) {
         [self roomDatelis];
    }else{
        [self roomDatelis];
    }
   
    
}
#pragma mark --------点击开始游戏----------------

-(void)playGameBtClick{

//      [self openApp:@"tencentlaunch1104466820://"];
    
//  [self enterSendMessage:@"被踢除房间" messageExt:ni];
//    return;
//  r  NSString *qqStr=[NSString stringWithFormat:@"tencentlaunch1104466820://",  self.QQbotInfoModel.botId];
   
    
    if ( [self.roomModel.roomInfo.roomMode isEqualToString:@"1"]) {
        if ([self.roomModel.currentQueueCount integerValue]>=4) {
            [MBManager showBriefAlert:@"多人对战模式最多三个人"];
        }
    }else if([self.roomModel.roomInfo.roomMode isEqualToString:@"2"]){
        if ([self.roomModel.currentQueueCount integerValue]!= 5) {
            [MBManager showBriefAlert:@"五人排位模式只能五人"];
            return;
        }
        
    }
    
    
    
    //获得数据后跟新UI
    

        if ([self.roomModel.roomInfo.gameStatus isEqualToString:@"0"]) {////0：未开始；1、启动中(房主点击唤起游戏) 2、游戏中(客服收到链接已开始游戏) 3、结算中，(房主手动点击结束游戏) 4、游戏结束；
        
            
            if ([self.roomModel.roomInfo.userId isEqualToString:loginUid]) {
                [self enterGameBtClick ];
            }else{
               
            }
        
        }
        else if ([self.roomModel.roomInfo.gameStatus isEqualToString:@"1"])
        {
            if ([self.roomModel.roomInfo.userId isEqualToString:loginUid]) {
                [self enterGameBtClick ];
            }else{
                
            }
            
            
        }else if ([self.roomModel.roomInfo.gameStatus isEqualToString:@"2"])
        {
          
            [self endGameBtClick ];
           
            
        }
        else if ([self.roomModel.roomInfo.gameStatus isEqualToString:@"3"])
        {
            
          
            
            
        }
        else if ([self.roomModel.roomInfo.gameStatus isEqualToString:@"4"])
        {
            
         
            
        }
    
    
    
    
    
    
    
    
    
    
    
    
    
//
//    if ([self.roomModel.roomInfo.gameStatus isEqualToString:@"0"]) {////0：未开始；1、启动中(房主点击唤起游戏) 2、游戏中(客服收到链接已开始游戏) 3、结算中，(房主手动点击
//
//
//    }else{
//          [self roomDatelis];
//    }
//
    

    
}
//-(void)nextShareFriendAlertView{
//
//    [GKCover hide];
//   [USER_DEFAULT setObject:enterGameHint forKey:[NSString stringWithFormat:@"enterGameHint%@",loginUid]];
//    YWShareFriendAlertView * shareFriendAlertView =  [YWShareFriendAlertView loadNameShareFriendAlertViewXib];
//    shareFriendAlertView.clf_size = CGSizeMake(LFscreenW-40, 375);
//     [shareFriendAlertView.nextStepBt addTarget:self action:@selector(enterGameThirdStepAlertView) forControlEvents:UIControlEventTouchUpInside];
//    [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:shareFriendAlertView style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleCenter showAnimStyle:GKCoverShowAnimStyleNone hideAnimStyle:GKCoverHideAnimStyleNone notClick:YES showBlock:nil hideBlock:nil];
//
//
//
//
//
//}
//
//-(void)enterGameThirdStepAlertView{
//
//
//    NSString * first = [USER_DEFAULT objectForKey:[NSString stringWithFormat:@"enterGameHint%@",loginUid]];
//    if (!first.length) {
//        [GKCover hideCover];
//    }
//    [GKCover hide];
//    YWEnterGameThirdStepAlertView * enterGameThirdStepAlertView =  [YWEnterGameThirdStepAlertView loadNameEnterGameThirdStepAlertViewXib];
//    enterGameThirdStepAlertView.clf_size = CGSizeMake(LFscreenW-40, 290);
//    [enterGameThirdStepAlertView.enterGameBt addTarget:self action:@selector(enterGameBtClick) forControlEvents:UIControlEventTouchUpInside];
//    [enterGameThirdStepAlertView.endGameBt addTarget:self action:@selector(endGameBtClick) forControlEvents:UIControlEventTouchUpInside];
//      [enterGameThirdStepAlertView.wentiBt addTarget:self action:@selector(wentiBtClick) forControlEvents:UIControlEventTouchUpInside];
//    [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:enterGameThirdStepAlertView style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleCenter showAnimStyle:GKCoverShowAnimStyleNone hideAnimStyle:GKCoverHideAnimStyleNone notClick:YES showBlock:nil hideBlock:nil];
//
//
//}
//-(void)wentiBtClick{
//    [GKCover hide];
//    ATServiceAgreementController * serviceAgreementVc = [[ATServiceAgreementController alloc] init];
//    serviceAgreementVc.htmlurl = CANNOT_ENTER;
//    serviceAgreementVc.htmltitle = @"进入不去游戏说明";
//    [self.navigationController pushViewController:serviceAgreementVc animated:YES];
//}
-(void)enterGameBtClick{
    
    [[EMClient sharedClient].roomManager joinChatroom:self.roomModel.roomInfo.huanChatId completion:^(EMChatroom *aChatroom, EMError *aError) {

    }];
    NSMutableDictionary * startGameDict  =diction;
    startGameDict[@"token"] = loginToken;
    startGameDict[@"gameId"] = self.roomModel.roomInfo.gameId;
    startGameDict[@"roomId"] = self.roomModel.roomInfo.roomId;
    LFLog(@"%@",startGameDict);
     LFLog(@"%@",self.roomModel.roomInfo.gameStatus);
    if ([self.roomModel.roomInfo.gameStatus isEqualToString:@"0"]||[self.roomModel.roomInfo.gameStatus isEqualToString:@"1"]) {
        [YWRequestData startGameDict:startGameDict success:^(id responseObj) {
            NSMutableDictionary * kaishiyouxiDict = diction;
            kaishiyouxiDict[@"gameId"] = self.roomModel.roomInfo.gameId;
            kaishiyouxiDict[@"roomId"] = self.roomModel.roomInfo.roomId;
            kaishiyouxiDict[@"token"] = loginToken;
            [YWRequestData kaishiyouxiDict:kaishiyouxiDict success:^(id responseObj) {
                NSMutableDictionary * messageExt = diction;
                messageExt[infotype] = launch;
//                [self enterSendMessage:@"房主启动了游戏" messageExt:messageExt];
//                [self roomDatelis];

                LFLog(@"%@  %@",kaishiyouxiDict,KAISHIYOUXI);
                  [self openApp:@"tencentlaunch1104466820://"];
            }];


        }];
    }else if ([self.roomModel.roomInfo.gameStatus isEqualToString:@"1"]){
          [self openApp:@"tencentlaunch1104466820://"];

    }
    
    
}
#pragma mark ----------结束游戏---------
-(void)endGameBtClick{
    if ([self.roomModel.roomInfo.gameStatus isEqualToString:@"1"]) {
        [MBManager  showBriefAlert:@"启动中不能结束游戏"];
        return;
    }
    if ([self.roomModel.roomInfo.gameStatus isEqualToString:@"0"]) {
        [MBManager  showBriefAlert:@"游戏未开始不能结束"];
        return;
    }
      [GKCover hideCover];
    NSMutableDictionary * endGame  =diction;
    endGame[@"token"] = loginToken;
    endGame[@"gameId"] = self.roomModel.roomInfo.gameId;
    endGame[@"roomId"] = self.roomModel.roomInfo.roomId;
   LFLog(@"%@",endGame);
    [YWRequestData roomMasterEndGameDict:endGame success:^(id responseObj) {
        NSMutableDictionary * messageExt = diction;
        messageExt[infotype] = end;
        [self enterSendMessage:@"游戏结束" messageExt:messageExt];
        [self roomDatelis];
    }];
}




-(void)openApp:(NSString * )Str{
    NSURL *url = [NSURL URLWithString:Str];

    [[UIApplication sharedApplication]openURL:url options:@{}completionHandler:^(BOOL  success) {
    }];
//    if( [[UIApplication sharedApplication]canOpenURL:url] ) {
//        [[UIApplication sharedApplication]openURL:url options:@{}completionHandler:^(BOOL     success) {
//        }];
//    }
}
-(void)roomMasterIconClick{
     NSMutableDictionary * userHomeDict = diction;
    if([self.roomModel.roomInfo.userId isEqualToString:loginUid]){//自己
        
        userHomeDict[@"userId"] = loginUid;
        userHomeDict[@"isStat"] = @"1";
        
        [YWRequestData userHomePageDict:userHomeDict success:^(id responseObj) {
            YMMeModel * meModel = [YMMeModel mj_objectWithKeyValues:responseObj[@"data"]];
             [USER_DEFAULT setObject:meModel.user.icon forKey:loginToken];
            
            YWRoomMeCheckMeView * roomMeCheckMeView  = [YWRoomMeCheckMeView loadNameRoomMeCheckMeViewXib];
            roomMeCheckMeView.isPointMaster = YES;
            [roomMeCheckMeView.followBt setTitle:@"解散房间" forState:UIControlStateNormal];
            roomMeCheckMeView.kickRoom = ^{
                NSMutableDictionary *  getRoomDic = diction;getRoomDic[@"id"] = self.roomModel.roomInfo.roomId;
                [YWRequestData getRoomDetailsDict:getRoomDic success:^(id responseObj) {
                    YWRoomModel * roomModel = [YWRoomModel mj_objectWithKeyValues:responseObj[@"data"]];
                    if ([roomModel.roomInfo.gameStatus isEqualToString:@"1"]) {
                        [MBManager showBriefAlert:@"游戏启动中不能解散房间"];
                        return ;
                        
                    }else  if ([roomModel.roomInfo.gameStatus isEqualToString:@"2"]) {
                        [MBManager showBriefAlert:@"游戏中不能解散房间"];
                        return ;
                    }
                    
                    
                    
                     [GKCover hideCover];
                    NSMutableDictionary * dict = diction;
                    dict[@"roomId"] =  self.roomModel.roomInfo.roomId;
                    [YWRequestData deleRoomDict:dict success:^(id responseObj) {
                      
                        EMError *error = [[EMClient sharedClient].roomManager destroyChatroom:_roomModel.roomInfo.roomId];
                       
                    }];
                }];
            };
            
            roomMeCheckMeView.userHomePageModel =  meModel;
            roomMeCheckMeView.userSegmetLb.text = self.masterDanlb.text;
            roomMeCheckMeView.roomModel = self.roomModel;
            roomMeCheckMeView.gk_size = CGSizeMake(LFscreenW, 280);
            [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:roomMeCheckMeView style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleBottom showAnimStyle:GKCoverShowAnimStyleBottom hideAnimStyle:GKCoverHideAnimStyleNone notClick:NO showBlock:^{
            } hideBlock:^{
                
            }];
            
        }];


    }else{
        
        userHomeDict[@"userId"] = self.roomModel.roomInfo.userId;
        userHomeDict[@"isStat"] = @"1";
        [YWRequestData userHomePageDict:userHomeDict success:^(id responseObj) {
            YMMeModel * meModel = [YMMeModel mj_objectWithKeyValues:responseObj[@"data"]];
           
            YWGusetCheckGusetView * gusetCheckGusetView = [YWGusetCheckGusetView loadNameGusetCheckGusetViewXib];
            gusetCheckGusetView.userHomePageModel =  meModel;
            gusetCheckGusetView.userSegmetLb.text = self.masterDanlb.text;
            gusetCheckGusetView.roomModel = self.roomModel;
            gusetCheckGusetView.gk_size = CGSizeMake(LFscreenW, 280);
            [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:gusetCheckGusetView style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleBottom showAnimStyle:GKCoverShowAnimStyleBottom hideAnimStyle:GKCoverHideAnimStyleNone notClick:NO showBlock:^{
            } hideBlock:^{
                
            }];
            
        }];
    }
}
-(void)enterChatVc:(NSNotification * )noti{
    NSString * hunid = [noti object];
    NSDictionary * notidic = noti.userInfo;
        YWChatViewController *chatController = [[YWChatViewController alloc] initWithConversationChatter:hunid conversationType:EMConversationTypeChat];
    chatController.name = notidic[@"name"];
      chatController.icon = notidic[@"icon"];
        [self.navigationController pushViewController:chatController animated:YES];
}


-(void)enterQueue:(NSNotification * )noti{
    NSString *info = [noti object];
     
    NSLog(@"接收 object传递的消息：%@ %@",noti.name,info);
    NSMutableDictionary * dic = diction;dic[@"id"] =self.roomId;
    [YWRequestData getRoomDetailsDict:dic success:^(id responseObj) {
        self.roomModel = [YWRoomModel mj_objectWithKeyValues:responseObj[@"data"]];

         NSMutableDictionary *  messageExt = diction;
        if ([info isEqualToString:enterQueueRefresh]) {
            messageExt[infotype] = join_queue;
        [self enterSendMessage:@"加入队列" messageExt:messageExt];
            return ;
        }else if ([info isEqualToString:subQueueRefresh]){/**关闭位置*/
            messageExt[infotype] = close_queue;
            [self enterSendMessage:@"" messageExt:messageExt];
             return ;
        }else if ([info isEqualToString:addQueueRefresh]){/**打开位置*/
             messageExt[infotype] = open_queue;
             [self enterSendMessage:@"" messageExt:messageExt];
            return ;
        }else if ([info isEqualToString:leaveRoomRefresh]){//离开房间普通消息
          [self enterSendMessage:@"离开房间" messageExt:messageExt];
        }else if ([info isEqualToString:deleRoomRefresh]){//房主解散了房间
            [self enterSendMessage:@"离开房间" messageExt:messageExt];
        }else if ([info isEqualToString:removeQueue]){//剔除队列
             messageExt[infotype] = kick_queue;
             messageExt[@"userId"] = noti.userInfo[@"userId"];
            [self enterSendMessage:@"被踢除队列" messageExt:messageExt];
        }else if ([info isEqualToString:kickRoom]){//剔除房间
               messageExt[@"userId"] = noti.userInfo[@"userId"];
              messageExt[infotype] = kick_room;
            [self enterSendMessage:@"被踢除房间" messageExt:messageExt];
        }else if ([info isEqualToString:quitQueue]){//退出队列
             messageExt[infotype] = leave_queue;

            [self enterSendMessage:@"退出队列" messageExt:messageExt];
        }
         [self updataUI];

    }];

}


#pragma mark --------发送消息------------------
- (void)enterSendMessage:(NSString * )messageText messageExt:(NSMutableDictionary *)messageExt{
   
    LFLog(@"%@",messageExt[@"userId"]);
    NSMutableDictionary * dict = diction;
    dict[@"userId"] = loginUid;
    if ([messageExt[@"userId"] length]) {
      dict[@"userId"] = messageExt[@"userId"];
    }else{
         dict[@"userId"] = loginUid;
    }dict[@"isStat"] = @"0";
    [YWRequestData userHomePageDict:dict success:^(id responseObj) {
        YMMeModel * meModel = [YMMeModel mj_objectWithKeyValues:responseObj[@"data"]];
        messageExt[@"userName"] = meModel.user.name;
        messageExt[@"userIcon"] = meModel.user.icon;
        messageExt[@"userId"] = meModel.user.userId;
         [USER_DEFAULT setObject:meModel.user.icon forKey:loginToken];
//        EMMessage *mess = [EaseSDKHelper getTextMessage:messageText to:self.roomModel.roomInfo.huanChatId  messageType:EMChatTypeChatRoom messageExt:messageExt];
        EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithText:messageText];
        NSString *from = [[EMClient sharedClient] currentUsername];
        EMMessage *message = [[EMMessage alloc] initWithConversationID:self.roomModel.roomInfo.huanChatId from:from to:self.roomModel.roomInfo.huanChatId body:body ext:messageExt];
        message.chatType = EMChatTypeChatRoom;// 设置为单聊消息
        //注册消息回调
        [[EMClient sharedClient].chatManager sendMessage:message progress:nil completion:^(EMMessage *message, EMError *error) {
            LFLog(@"%d",error.code);
            if (!error) { 
                if ([message.ext[infotype]  isEqualToString:launch] ) {/**启动*/
                    [self addMessageToDataSource:message];
                }else if([message.ext[infotype]  isEqualToString:end]){/**结束*/
                     [self addMessageToDataSource:message];
                }else if([message.ext[infotype]  isEqualToString:join_queue]){/**加入队列*/
                     [self addMessageToDataSource:message];
                }else if([message.ext[infotype]  isEqualToString:leave_queue]){/**离开队列*/
                     [self addMessageToDataSource:message];
                }else if([message.ext[infotype]  isEqualToString:kick_queue]){/**踢出队列*/
                     [self addMessageToDataSource:message];
                }else if([message.ext[infotype]  isEqualToString:kick_room]){/**踢出房间*/
                     [self addMessageToDataSource:message];
                }else if([message.ext[infotype]  isEqualToString:open_queue]){/**打开位置*/
                    
                }else if([message.ext[infotype]  isEqualToString:close_queue]){/**关闭位置*/
                    
                }else if([message.ext[infotype]  isEqualToString:startgame]){/**的环信消息，是启动链接*/
                    
                }else{
                    [self addMessageToDataSource:message];
                }
               
            }
        }];
        
    }];
    
}

#pragma mark -----进房间
-(void)enterRooomDatelis{
    WeakSelf(weakSelf)
    NSMutableDictionary * dic = diction;dic[@"id"] =self.roomId;
    [YWRequestData getRoomDetailsDict:dic success:^(id responseObj) {
        self.roomModel = [YWRoomModel mj_objectWithKeyValues:responseObj[@"data"]];
        
        //        NSMutableDictionary * quitdic = diction;quitdic[@"token"] =  loginToken;quitdic[@"gameId"] =   self.roomModel.roomInfo.gameId;quitdic[@"roomId"] =  self.roomModel.roomInfo.roomId;
        //        [YWRequestData quitQueueeDict:quitdic success:^(id responseObj) {
        //
        //        }];
        [self updataUI];
        //注册聊天室回调
#pragma mark ----------加入房间--------------
        NSMutableDictionary * dict = diction;dict[@"token"] =  loginToken;
        [YWRequestData myRoomDict:dict success:^(id responseObj) {
            weakSelf.chatTableView.tableHeaderView = [YWRoomChatTableTopView loadNameRoomChatTableTopViewXib];
            weakSelf.chatTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            weakSelf.rightDrawerView.roomModel = self.roomModel;
            YWMyRoomModel * myRoomModel = [YWMyRoomModel mj_objectWithKeyValues:responseObj[@"data"]];
            if (![myRoomModel.roomId isEqualToString:self.roomId]||!myRoomModel.roomId.length) {//不在同一个房间或者没有在房间
                NSMutableDictionary * d = diction;
                d[@"userId"] = loginUid;
                d[@"roomId"] = self.roomId;
                [YWRequestData enterRoomDict:d success:^(id responseObj) {
                    [self joinRoom];
                }];
            }
            [[EMClient sharedClient].roomManager joinChatroom:self.roomModel.roomInfo.huanChatId completion:^(EMChatroom *aChatroom, EMError *aError) {
                LFLog(@"%d",aError.code);
                if (!aError) {
                    
                    
                }
            }];
            
            
        }];
        
    }];
    
}
#pragma mark -----房间详情
-(void)roomDatelis{
  
    NSMutableDictionary * dic = diction;dic[@"id"] =self.roomId;
    [YWRequestData getRoomDetailsDict:dic success:^(id responseObj) {
        self.roomModel = [YWRoomModel mj_objectWithKeyValues:responseObj[@"data"]];
       
         [self updataUI];
    }];

}
-(void)joinRoom{
    [[EMClient sharedClient].roomManager joinChatroom:self.roomModel.roomInfo.huanChatId completion:^(EMChatroom *aChatroom, EMError *aError) {
         NSMutableDictionary * messageExt = diction;
       [self enterSendMessage:@"加入了房间" messageExt:messageExt];
    }];
}






#pragma mark--------获得数据后跟新UI------
-(void)updataUI{//获得数据后跟新UI
    
    NSString * gameAreaStr = nil;
    NSString * roomModeStr = nil;
    if ([self.roomModel.roomInfo.gameArea isEqualToString:@"1"]) {
        gameAreaStr = @"QQ区";
    }else if ([self.roomModel.roomInfo.gameArea isEqualToString:@"2"]) {
        gameAreaStr = @"微信区";
    }
    
    if ([self.roomModel.roomInfo.roomMode isEqualToString:@"1"]) {
        roomModeStr = @"多人排位";
    }else if ([self.roomModel.roomInfo.roomMode isEqualToString:@"2"]) {
        roomModeStr = @"五人排位";
    }else if ([self.roomModel.roomInfo.roomMode isEqualToString:@"3"]) {
        roomModeStr = @"多人对战";
    }
    self.navigationItem.title = [NSString stringWithFormat:@"%@ %@",gameAreaStr,roomModeStr];
    [GKCover hide];
    self.count = [self.roomModel.roomInfo.requireQueueNum integerValue]-1;
    [self.gameQueueModels removeAllObjects];
//    if (![self.roomModel.roomInfo.userId isEqualToString:loginUid]) {
//        self.playGameBt.hidden = YES;
//    }else{
//         self.playGameBt.hidden = NO;
//    }
    self.gameStatusBt.hidden = NO;
    [self.gameStatusBt setBackgroundColor:yellowBoderColor];
      [self.playGameBt setBackgroundColor:yellowBoderColor];
      self.gameStatusBt.userInteractionEnabled = self.playGameBt.userInteractionEnabled = YES;
    if ([self.roomModel.roomInfo.gameStatus isEqualToString:@"0"]) {////0：未开始；1、启动中(房主点击唤起游戏) 2、游戏中(客服收到链接已开始游戏) 3、结算中，(房主手动点击结束游戏) 4、游戏结束；
//        [self.playGameBt setTitle:@"开始游戏" forState:UIControlStateNormal];
       
        if ([self.roomModel.roomInfo.userId isEqualToString:loginUid]) {
            [self.gameStatusBt setTitle:@"开始游戏" forState:UIControlStateNormal];
            [self.playGameBt setTitle:@"开始游戏" forState:UIControlStateNormal];
            self.playGameBt.userInteractionEnabled = self.gameStatusBt.userInteractionEnabled = YES;;
        }else{
            [self.playGameBt setTitle:@"等待游戏开始" forState:UIControlStateNormal];
            [self.gameStatusBt setTitle:@"等待游戏开始" forState:UIControlStateNormal];
            self.playGameBt.userInteractionEnabled = NO;
            self.gameStatusBt.userInteractionEnabled = self.playGameBt.userInteractionEnabled = NO;
            [self.gameStatusBt setBackgroundColor:[SVGloble colorWithHexString:@"#8a8a8a"]];
            [self.playGameBt setBackgroundColor:[SVGloble colorWithHexString:@"#8a8a8a"]];
        }
          self.gameStatusBt.hidden = YES;
        
        
    }
    else if ([self.roomModel.roomInfo.gameStatus isEqualToString:@"1"])
    {
         [self.gameStatusBt setTitle:@"启动中" forState:UIControlStateNormal];
         [self.playGameBt setTitle:@"启动中" forState:UIControlStateNormal];
        
//        if ([self.roomModel.roomInfo.userId isEqualToString:loginUid]) {
//              [self enterGameThirdStepAlertView];//房主--启动游戏的弹框
//        }else{
//            for (YWGameQueueModel * gameQueueModel in self.roomModel.gameQueue) {
//                if ([loginUid isEqualToString:gameQueueModel.userId]) {
//                      [self guset_RoomStartGameAlertVIew ];// 房客---房主启动游戏弹框
//                }
//            }
//
//
//        }

    }else if ([self.roomModel.roomInfo.gameStatus isEqualToString:@"2"])
    {
        [self.gameStatusBt setTitle:@"游戏中" forState:UIControlStateNormal];
        [self.playGameBt setTitle:@"结束游戏" forState:UIControlStateNormal];
        self.playGameBt.userInteractionEnabled = self.gameStatusBt.userInteractionEnabled = YES;;
       
//        if ([self.roomModel.roomInfo.userId isEqualToString:loginUid]) {
//              [self.gameStatusBt setTitle:@"" forState:UIControlStateNormal];
//              [self.playGameBt setTitle:@"游戏中" forState:UIControlStateNormal];
//           self.playGameBt.userInteractionEnabled = self.gameStatusBt.userInteractionEnabled = YES;;
//        }else{
//             [self.playGameBt setTitle:@"等待游戏开始" forState:UIControlStateNormal];
//              [self.gameStatusBt setTitle:@"等待游戏开始" forState:UIControlStateNormal];
//            self.playGameBt.userInteractionEnabled = NO;
//             self.gameStatusBt.userInteractionEnabled = self.playGameBt.userInteractionEnabled = NO;
//        }
    }
    else if ([self.roomModel.roomInfo.gameStatus isEqualToString:@"3"])
    {
        
         [self.gameStatusBt setTitle:@"结算中" forState:UIControlStateNormal];
         [self.playGameBt setTitle:@"结算中" forState:UIControlStateNormal];
        [self.gameStatusBt setBackgroundColor:[SVGloble colorWithHexString:@"#8a8a8a"]];
        [self.playGameBt setBackgroundColor:[SVGloble colorWithHexString:@"#8a8a8a"]];
        self.gameStatusBt.userInteractionEnabled = self.playGameBt.userInteractionEnabled = NO;
        [self playGameRecord];
        
        
    }
    else if ([self.roomModel.roomInfo.gameStatus isEqualToString:@"4"])
    {
        
         [self.gameStatusBt setTitle:@"游戏结束" forState:UIControlStateNormal];
         [self.playGameBt setTitle:@"游戏结束" forState:UIControlStateNormal];
        [self.gameStatusBt setBackgroundColor:[SVGloble colorWithHexString:@"#8a8a8a"]];
        [self.playGameBt setBackgroundColor:[SVGloble colorWithHexString:@"#8a8a8a"]];
          self.gameStatusBt.userInteractionEnabled = self.playGameBt.userInteractionEnabled = NO;
        
    }
    [self cretejionUser ];
    
    if ( [self.roomModel.roomInfo.roomType isEqualToString:@"1"])
    {
        [self.roomTypeImage setImage:[UIImage imageNamed:@"roomdateils_aa"]];
    }else if ([self.roomModel.roomInfo.roomType isEqualToString:@"2"]){
          [self.roomTypeImage setImage:[UIImage imageNamed:@"roomdateils_sb"]];
    }else if ([self.roomModel.roomInfo.roomType isEqualToString:@"3"]){
          [self.roomTypeImage setImage:[UIImage imageNamed:@"roomdateils_xs"]];
    }
    self.roomNumberLb.text =[NSString stringWithFormat:@"%@人房间",self.roomModel.roomInfo.num];
    for (int i = 0; i <self.roomModel.gameQueue.count; i++){
        YWGameQueueModel *gameQueueModel  =  self.roomModel.gameQueue[i];
        if ([gameQueueModel.isMgt isEqualToString:@"1"]) {//房主
        [self.roomMasterIcon sd_setImageWithURL:[NSURL URLWithString:gameQueueModel.userLogo] forState:UIControlStateNormal];
        self.masterName.text =  gameQueueModel.userName;
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"searchDatas" ofType:@"plist"];
        NSMutableDictionary *datas = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        NSArray * array = datas[@"createSegMatchs"];
            LFLog(@"%@",gameQueueModel.userGrade);
        NSDictionary * dict = array[[gameQueueModel.userGrade integerValue]-1];
        self.masterDanlb.text = dict[@"name"];
        }else{
                [self.gameQueueModels addObject:gameQueueModel];
            }
        
    }
    
    
    for (NSInteger i = 0; i<self.maxCols; i++)
    {
        YWCreteBtView * creteBtView =  self.creteBtViews[i];
        creteBtView.roomModel =  self.roomModel;
         [creteBtView.iocnBt setTitle:@"已开启" forState:UIControlStateNormal];
          creteBtView.iocnBt.userInteractionEnabled = YES;
           creteBtView.nameLb.hidden =   creteBtView.danLb.hidden = YES;
        [creteBtView.iocnBt setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    
    
      for (int i = 0; i <self.gameQueueModels.count; i++){
           YWGameQueueModel * gameQueueModel  =  self.gameQueueModels[i];
          YWCreteBtView * creteBtView =  self.creteBtViews[i];
          creteBtView.roomModel =  self.roomModel;
          creteBtView.gameQueueModel = gameQueueModel;
          
           self.lasti = i;
      }
    for (NSInteger j = [self.roomModel.requireQueueCount integerValue]; j <self.maxCols ; j++) {
        YWCreteBtView * creteBtView =  self.creteBtViews[j];
        [creteBtView.iocnBt setTitle:@"已关闭" forState:UIControlStateNormal];
      
       
    }
    
    
    
    
    
    if ([self.roomModel.roomInfo.roomType isEqualToString:@"1"]) { // 房间类型 1、AA制 2、撒币 3、 悬赏
        // 房间费用 当AA制此值为房间费 撒币和悬赏为房主出价金额
        self.priceLb.text = [NSString stringWithFormat:@"房间费%@元",self.roomModel.roomInfo.roomMoney];
    }else if ([self.roomModel.roomInfo.roomType isEqualToString:@"2"]){
        if ([self.roomModel.roomInfo.roomType isEqualToString:@"1"]) {
            self.priceLb.text = [NSString stringWithFormat:@"平分%@元",self.roomModel.roomInfo.roomMoney];
        }else if ([self.roomModel.roomInfo.roomType isEqualToString:@"2"]){
            self.priceLb.text = [NSString stringWithFormat:@"拼手气%@元",self.roomModel.roomInfo.roomMoney];
        }
        
    }else if ([self.roomModel.roomInfo.roomType isEqualToString:@"3"] ){
        self.priceLb.text = [NSString stringWithFormat:@"MVP得%@元",self.roomModel.roomInfo.roomMoney];
    }
self.gameStatusBt.userInteractionEnabled = NO;;
}
#pragma mark----查询开黑记录----------------
-(void)playGameRecord{
    NSMutableDictionary * playGameRecordDit = diction;
    playGameRecordDit[@"token"] = loginToken;
    playGameRecordDit[@"gameId"] = self.roomModel.roomInfo.gameId;
    playGameRecordDit[@"roomId"] = self.roomModel.roomInfo.roomId;
    LFLog(@"%@",playGameRecordDit);
    [YWRequestData playGameRecordDict:playGameRecordDit success:^(YWPlayGameRecordModel *playGameRecordModel) {
        if ([self.roomModel.roomInfo.userId isEqualToString:loginUid]) {
            if (![playGameRecordModel.gameId length]) {
                return ;
            }
            if ([playGameRecordModel.status isEqualToString:@"2"]) {//战绩待汇报  // 游戏中1,战绩待汇报2，战绩审核中4，战绩待确认5，战绩已超时201，已确认101，被驳回102，已完成103，战绩已失效202 ,
                [self.gameStatusBt setBackgroundColor:yellowBoderColor];
                [self.playGameBt setBackgroundColor:yellowBoderColor];
                self.playGameBt.userInteractionEnabled =self.gameStatusBt .userInteractionEnabled = YES;
                if ([self.roomModel.roomInfo.roomType isEqualToString:@"1"]) {
                    [self master_AARoomAlertView];
                }else if ([self.roomModel.roomInfo.roomType isEqualToString:@"2"]){
                    [self master_SBRoomAlertView];
                }else if ([self.roomModel.roomInfo.roomType isEqualToString:@"3"]){
                    [self master_XSRoomAlertView];
                }
            }else if ([playGameRecordModel.status isEqualToString:@"4"]){
//                [MBManager showBriefAlert:@"战绩审核中"];
            }else if ([playGameRecordModel.status isEqualToString:@"5"]){
                [self.gameStatusBt setBackgroundColor:yellowBoderColor];
                [self.playGameBt setBackgroundColor:yellowBoderColor];
                  self.playGameBt.userInteractionEnabled =self.gameStatusBt .userInteractionEnabled = YES;
                if ([self.roomModel.roomInfo.roomType isEqualToString:@"1"]) {
                    [self master_AARoomAlertView];
                }else if ([self.roomModel.roomInfo.roomType isEqualToString:@"2"]){
                    [self master_SBRoomAlertView];
                }else if ([self.roomModel.roomInfo.roomType isEqualToString:@"3"]){
                    [self master_XSRoomAlertView];
                }
                
            }else if ([playGameRecordModel.status isEqualToString:@"201"]){
//                [MBManager showBriefAlert:@"战绩已超时"];
            }else if ([playGameRecordModel.status isEqualToString:@"101"]){
//                [MBManager showBriefAlert:@"已确认"];
            }else if ([playGameRecordModel.status isEqualToString:@"102"]){
//                [MBManager showBriefAlert:@"被驳回"];
            }else if ([playGameRecordModel.status isEqualToString:@"103"]){
//                [MBManager showBriefAlert:@"已完成"];
            }else if ([playGameRecordModel.status isEqualToString:@"202"]){
//                [MBManager showBriefAlert:@"战绩已失效"];
            }
            
        }else{
            if ([playGameRecordModel.status isEqualToString:@"2"]) {//战绩待汇报  // 游戏中1,战绩待汇报2，战绩审核中4，战绩待确认5，战绩已超时201，已确认101，被驳回102，已完成103，战绩已失效202 ,
                [self.gameStatusBt setBackgroundColor:yellowBoderColor];
                [self.playGameBt setBackgroundColor:yellowBoderColor];
                self.playGameBt.userInteractionEnabled =self.gameStatusBt .userInteractionEnabled = YES;
                if ([self.roomModel.roomInfo.roomType isEqualToString:@"1"]) {
                    [self guset_AARoomAlertView];
                }else if ([self.roomModel.roomInfo.roomType isEqualToString:@"2"]){
                    [self guset_SBRoomAlertView];
                }else if ([self.roomModel.roomInfo.roomType isEqualToString:@"3"]){
                    [self guset_XSRoomAlertView];
                }
            }else if ([playGameRecordModel.status isEqualToString:@"4"]){
//                [MBManager showBriefAlert:@"战绩审核中"];
            }else if ([playGameRecordModel.status isEqualToString:@"5"]){
                [self.gameStatusBt setBackgroundColor:yellowBoderColor];
                [self.playGameBt setBackgroundColor:yellowBoderColor];
                self.playGameBt.userInteractionEnabled =self.gameStatusBt .userInteractionEnabled = YES;
                if ([self.roomModel.roomInfo.roomType isEqualToString:@"1"]) {
                    [self guset_AARoomAlertView];
                }else if ([self.roomModel.roomInfo.roomType isEqualToString:@"2"]){
                    [self guset_SBRoomAlertView];
                }else if ([self.roomModel.roomInfo.roomType isEqualToString:@"3"]){
                    [self guset_XSRoomAlertView];
                }
                
            }else if ([playGameRecordModel.status isEqualToString:@"201"]){
                //                [MBManager showBriefAlert:@"战绩已超时"];
            }else if ([playGameRecordModel.status isEqualToString:@"101"]){
                //                [MBManager showBriefAlert:@"已确认"];
            }else if ([playGameRecordModel.status isEqualToString:@"102"]){
                //                [MBManager showBriefAlert:@"被驳回"];
            }else if ([playGameRecordModel.status isEqualToString:@"103"]){
                //                [MBManager showBriefAlert:@"已完成"];
            }else if ([playGameRecordModel.status isEqualToString:@"202"]){
                //                [MBManager showBriefAlert:@"战绩已失效"];
            }
            
        }
    }];
    
}
-(void)cretejionUser{///创建参与的用户

     [self.bgView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
     [self.creteBtViews removeAllObjects];
    //中间3个按钮
    NSInteger maxCols = 4;
   
    if ( [self.roomModel.roomInfo.roomMode isEqualToString:@"1"]) {
    maxCols = 2;
    }else{
         maxCols = 4;
    }
    CGFloat buttonStartX = 0;
    CGFloat butttonStartY =0;
    CGFloat xMargin = 0;
    CGFloat yMargin = 0;
    CGFloat buttonH = 110;
    CGFloat buttonW = (LFscreenW-(maxCols - 1) * xMargin - 2*buttonStartX)/maxCols;
    for (NSInteger i = 0; i<maxCols; i++)
    {
        YWCreteBtView * creteBtView = [YWCreteBtView loadNameCreteBtViewXib];
//          creteBtView.roomModel =  self.roomModel;
        [self.bgView addSubview:creteBtView];
        //计算X、Y
        NSInteger row = i / maxCols;
        NSInteger col = i % maxCols;
        CGFloat buttonX = buttonStartX + col * (xMargin + buttonW);
        CGFloat buttonEndY = butttonStartY + row * (buttonH+yMargin);
        creteBtView.frame = CGRectMake(buttonX, buttonEndY, buttonW, buttonH);
        [self.creteBtViews addObject:creteBtView];
    }
     self.maxCols  = maxCols;
}


//
//-(void)guset_RoomStartGameAlertVIew{// 房客---房主启动游戏
//
//    [GKCover hide];
//    YWGusetRoomStartGameAlertVIew * gusetRoomStartGameAlertVIew =  [YWGusetRoomStartGameAlertVIew loadNameGusetRoomStartGameAlertVIewXib];
//
//    gusetRoomStartGameAlertVIew.clf_size = CGSizeMake(LFscreenW-40, 245);
//    //    [gusetRoomStartGameAlertVIew.nextStepBt addTarget:self action:@selector(nextShareFriendAlertView) forControlEvents:UIControlEventTouchUpInside];
//    [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:gusetRoomStartGameAlertVIew style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleCenter showAnimStyle:GKCoverShowAnimStyleNone hideAnimStyle:GKCoverHideAnimStyleNone notClick:YES showBlock:nil hideBlock:nil];
//}
//
//-(void)guest_EnterGameAlertView{// 房客---房主发送链接后游戏
//    [GKCover hide];
//    YWGuestEnterGameAlertView * gusetEnterGameAlertView =  [YWGuestEnterGameAlertView loadNameuestEnterGameAlertViewXib];
//    gusetEnterGameAlertView.clf_size = CGSizeMake(LFscreenW-40, 245);
//       [gusetEnterGameAlertView.knowBt addTarget:self action:@selector(entergam) forControlEvents:UIControlEventTouchUpInside];
//    [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:gusetEnterGameAlertView style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleCenter showAnimStyle:GKCoverShowAnimStyleNone hideAnimStyle:GKCoverHideAnimStyleNone notClick:YES showBlock:nil hideBlock:nil];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//        // 3.GCD
//        dispatch_async(dispatch_get_main_queue(), ^{
//            // UI更新代码
//            if (self.startGameLink.length) {
//                  [self openApp:self.startGameLink];
//            }
//
//        });
//
//    });
//
//}
//
//-(void)entergam{
//      [self openApp:self.startGameLink];
//
//}


-(void)master_AARoomAlertView{//房主---AA房结算的
//    [GKCover hideCover];
    WeakSelf(weakSelf)
    YWAARoomMasterAlertView * aaRoomMasterAlertView = [YWAARoomMasterAlertView loadNameAARoomMasterAlertViewXib];
    aaRoomMasterAlertView.upDataPlayGameRecord = ^{
        [weakSelf roomDatelis];
    };
    aaRoomMasterAlertView.roomModel = self.roomModel;
    aaRoomMasterAlertView.clf_size = CGSizeMake(LFscreenW-40, 260);
    [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:aaRoomMasterAlertView style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleCenter showAnimStyle:GKCoverShowAnimStyleNone hideAnimStyle:GKCoverHideAnimStyleNone notClick:YES showBlock:nil hideBlock:nil];
}

-(void)master_SBRoomAlertView{//房主---SB房结算的
//    [GKCover hi];
     WeakSelf(weakSelf)
    YWSBRoomMasterAlertView * sbRoomMasterAlertView = [YWSBRoomMasterAlertView loadNameSBRoomMasterAlertViewXib];
    sbRoomMasterAlertView.sbMasterUpDataPlayGameRecord  = ^{
        [weakSelf roomDatelis];
    };
    sbRoomMasterAlertView.roomModel = self.roomModel;
    sbRoomMasterAlertView.clf_size = CGSizeMake(LFscreenW-40, 260);
    [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:sbRoomMasterAlertView style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleCenter showAnimStyle:GKCoverShowAnimStyleNone hideAnimStyle:GKCoverHideAnimStyleNone notClick:YES showBlock:nil hideBlock:nil];
}
-(void)master_XSRoomAlertView{//房主---XS房结算的
//    [GKCover hideCover];
     WeakSelf(weakSelf)
    YWXSRoomMasterAlertView * xsRoomMasterAlertView = [YWXSRoomMasterAlertView loadNameXSRoomMasterAlertViewXib];
    xsRoomMasterAlertView.xsMasterUpDataPlayGameRecord   = ^{
        [weakSelf roomDatelis];
    };
    xsRoomMasterAlertView.roomModel = self.roomModel;
    xsRoomMasterAlertView.clf_size = CGSizeMake(LFscreenW-40, 260);
    [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:xsRoomMasterAlertView style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleCenter showAnimStyle:GKCoverShowAnimStyleNone hideAnimStyle:GKCoverHideAnimStyleNone notClick:YES showBlock:nil hideBlock:nil];
}

-(void)guset_AARoomAlertView{//房客---AA房结算的
    [GKCover hide];
     WeakSelf(weakSelf)
    YWAARoomGuestAlertView * aaRoomGuestAlertView = [YWAARoomGuestAlertView loadNameAARoomGuestAlertViewXib];
    aaRoomGuestAlertView.aaGusetUpDataPlayGameRecord    = ^{
        [weakSelf roomDatelis];
    };
    aaRoomGuestAlertView.roomModel = self.roomModel;
    aaRoomGuestAlertView.clf_size = CGSizeMake(LFscreenW-40, 260);
    [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:aaRoomGuestAlertView style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleCenter showAnimStyle:GKCoverShowAnimStyleNone hideAnimStyle:GKCoverHideAnimStyleNone notClick:YES showBlock:nil hideBlock:nil];
}
-(void)guset_SBRoomAlertView{//房客---SB房结算的
//    [GKCover hideCover];
     WeakSelf(weakSelf)
    YWSBRoomGusetAlertView * sbRoomGuestAlertView = [YWSBRoomGusetAlertView loadNameSBRoomGusetAlertViewXib];
    sbRoomGuestAlertView.sbGusetUpDataPlayGameRecord    = ^{
        [weakSelf roomDatelis];
    };
    sbRoomGuestAlertView.roomModel = self.roomModel;
    sbRoomGuestAlertView.clf_size = CGSizeMake(LFscreenW-40, 260);
    [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:sbRoomGuestAlertView style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleCenter showAnimStyle:GKCoverShowAnimStyleNone hideAnimStyle:GKCoverHideAnimStyleNone notClick:YES showBlock:nil hideBlock:nil];
}
-(void)guset_XSRoomAlertView{//房客---AA房结算的
//    [GKCover hideCover];
     WeakSelf(weakSelf)
    YWXSRoomGusetAlertVIew * xsRoomGuestAlertView = [YWXSRoomGusetAlertVIew loadNameXSRoomGusetAlertVIewXib];
    xsRoomGuestAlertView.xsGusetUpDataPlayGameRecord    = ^{
        [weakSelf roomDatelis];
    };
    xsRoomGuestAlertView.roomModel = self.roomModel;
    xsRoomGuestAlertView.clf_size = CGSizeMake(LFscreenW-40, 260);
    [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:xsRoomGuestAlertView style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleCenter showAnimStyle:GKCoverShowAnimStyleNone hideAnimStyle:GKCoverHideAnimStyleNone notClick:YES showBlock:nil hideBlock:nil];
}








-(void)danTftap{
    [self.view endEditing:YES];
}
-(void)setUI{//设置UI
  
   
    [self wr_setNavBarBackgroundAlpha:0];
    self.iocnBgView.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3].CGColor;
    self.iocnBgView.layer.borderWidth =3;
    [self.iocnBgView layercornerRadius:32];
    if (kDevice_Is_iPhoneX) {
        self.tableViewLyout.constant=self.buttomLyoutH.constant = 83;
    }
    
    
    [self createBottomTf];
    
     [self.cahtBt addTarget:self action:@selector(cahtBtClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)createBottomTf{
    self.bottom = [[UIView alloc] initWithFrame:CGRectMake(0, LFscreenH, LFscreenW, 50)];
    self.bottom.backgroundColor = [SVGloble colorWithHexString:@"#667189"];
    
    [self.view addSubview: self.bottom];
    self.chatTf = [[UITextField alloc] initWithFrame:CGRectMake(20, 5, LFscreenW-40, 40)];
    [self.chatTf layercornerRadius:5];
    self.chatTf.delegate = self;
    self.chatTf.returnKeyType = UIReturnKeySend;//变为搜索按钮
    self.chatTf.backgroundColor = [UIColor whiteColor];
//    self.chatTf.centerY =  self.bottom.centerY;
    [ self.bottom addSubview: self.chatTf];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
      [self.chatTf resignFirstResponder];
    NSMutableDictionary * messageExt = diction;
    [self enterSendMessage:textField.text messageExt:messageExt];
    
    return YES;
}


#pragma mark -------接受消息------------------
- (void)messagesDidReceive:(NSArray *)aMessages {
    for (EMMessage *message in aMessages) {
        if ([self.roomModel.roomInfo.huanChatId isEqualToString:message.conversationId])
        {
            LFLog(@"%@",message.from);
          

            if ([message.from isEqualToString:@"startgame" ] ) {
                
                
                self.startGameLink =@"http://imgcache.qq.com/gc/gamecenterV2/dist/index/detail/detail.html?from=iphoneqq&plat=qq&originuin=0E54D055975082AC1960E27469E8F9DC&pf=invite&ADTAG=gameobj.msg_invite&appid=1104466820&gamedata=ShareTeam_1114634839_14044_4204215263_436994368_5755685674709709_0_1_1_3_20011_2_8_2_3_0_17_15_0_0_25&timestamp=1524622693095";
                 [self roomDatelis];
                return;
            }
            if ([message.ext[infotype]  isEqualToString:launch] ) {/**启动*/
                [self roomDatelis];
                 [self addMessageToDataSource:message];
            }else if([message.ext[infotype]  isEqualToString:end]){/**结束*/
                 [self roomDatelis];
                 [self addMessageToDataSource:message];
            }else if([message.ext[infotype]  isEqualToString:join_queue]){/**加入队列*/
                [self roomDatelis];
                 [self addMessageToDataSource:message];
            }else if([message.ext[infotype]  isEqualToString:leave_queue]){/**离开队列*/
                [self roomDatelis];
                 [self addMessageToDataSource:message];
            }else if([message.ext[infotype]  isEqualToString:kick_queue]){/**踢出队列*/
                [self roomDatelis];
                 [self addMessageToDataSource:message];
            }else if([message.ext[infotype]  isEqualToString:kick_room]){/**踢出房间*/
               [self roomDatelis];
                 [self addMessageToDataSource:message];
            }else if([message.ext[infotype]  isEqualToString:open_queue]){/**打开位置*/
                  [self roomDatelis];
            }else if([message.ext[infotype]  isEqualToString:close_queue]){/**关闭位置*/
                  [self roomDatelis];
            }else{
                [self addMessageToDataSource:message];
            }
            
            
           
        }
    }
    
  
}

-(void)addMessageToDataSource:(EMMessage *)message{
     WeakSelf(weakSelf)
   
      NSArray *messages = [weakSelf formatMessages:@[message]];
    [weakSelf.dataArray addObjectsFromArray:messages];
    [weakSelf.chatTableView reloadData];
   [weakSelf.chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[weakSelf.dataArray count] - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}
#pragma mark - public

- (NSArray *)formatMessages:(NSArray *)messages
{
    NSMutableArray *formattedArray = [[NSMutableArray alloc] init];
    if ([messages count] == 0) {
        return formattedArray;
    }

    for (EMMessage *message in messages) {
  

        //Construct message model
        id<IMessageModel> model = nil;
            model = [[EaseMessageModel alloc] initWithMessage:message];
            model.avatarImage = message.ext[@"userIcon"];
            model.nickname =  message.ext[@"userName"];

        if (model) {
            [formattedArray addObject:model];
        }
    }

    return formattedArray;
}

- (void)cmdMessagesDidReceive:(NSArray *)aCmdMessages{
    
    
}
-(void)cahtBtClick{//点击
    [self.chatTf becomeFirstResponder];
    
}

#pragma mark - 键盘通知
- (void)addNoticeForKeyboard {
    
    //注册键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object: nil];
    //注册键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object: nil];
}

///键盘显示事件
- (void) keyboardWillShow:(NSNotification *)notification {
//     LFLog(@"%d", [self.chatTf becomeFirstResponder] );
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    //计算出键盘顶端到inputTextView panel底端的距离(加上自定义的缓冲距离INTERVAL_KEYBOARD)
    CGFloat offset = self.bottom.clf_bottom  - (self.view.frame.size.height - kbHeight);
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //将视图上移计算好的偏移
    if(offset > 0) {
        [UIView animateWithDuration:duration animations:^{
          
            if ( [self.chatTf isFirstResponder]) {
                 self.bottom.clf_bottom = self.view.frame.size.height - kbHeight;
            }
          
        }];
    }
}

///键盘消失事件
- (void) keyboardWillHide:(NSNotification *)notify {
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
  
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        self.bottom.clf_y = LFscreenH;
        
    }];
}





-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return  0 ;
    }else{
        return 0.01f;
    }

}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;


}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  self.dataArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
      id object = [self.dataArray objectAtIndex:indexPath.row];
    id<IMessageModel> model = object;
      return [YWRoomChatTableViewCell cellHeightWithModel:model];
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     id object = [self.dataArray objectAtIndex:indexPath.row];
    
    id<IMessageModel> model = object;
     YWRoomChatTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellidenfder];
    cell.model = model;
    return cell;
}

#pragma mark - EMChatManagerChatroomDelegate
/*!
 *  \~chinese
 *  有用户加入聊天室
 *
 *  @param aChatroom    加入的聊天室
 *  @param aUsername    加入者
 *
 *  \~english
 *  Delegate method will be invoked when a user joins a chat room
 *
 *  @param aChatroom    Joined chatroom
 *  @param aUsername    The user who joined chatroom
 */
- (void)didReceiveUserJoinedChatroom:(EMChatroom *)aChatroom
                            username:(NSString *)aUsername
{
//[self roomDatelis];
}

- (void)didReceiveUserLeavedChatroom:(EMChatroom *)aChatroom
                            username:(NSString *)aUsername
{
[self roomDatelis];
}

- (void)didReceiveKickedFromChatroom:(EMChatroom *)aChatroom
                              reason:(EMChatroomBeKickedReason)aReason
{
//    if ([_conversation.conversationId isEqualToString:aChatroom.chatroomId])
//    {
//
//    }
    if (aReason == EMChatroomBeKickedReasonDestroyed ) {
         [MBManager showBriefAlert:@"房间解散"];
    }else  if (aReason == EMChatroomBeKickedReasonBeRemoved  ) {
          [MBManager showBriefAlert:[NSString stringWithFormat:@"%@被踢出房间",@"您"]];
        
    }
    [GKCover hideCover];
    [self.navigationController popViewControllerAnimated:YES];
   
}
-(void)dealloc{
    [self.rightDrawerView removeFromSuperview];
    [[EMClient sharedClient].roomManager leaveChatroom:self.roomModel.roomInfo.huanChatId completion:^(EMError *aError) {
        if (!aError) {
            
        }
    }];
    [LFNSNOTI removeObserver:self];
}



























-(void)skipRightView{
    
    [self openRightDrawer];
}
-(void)createLeftRoom{//左边滑动的View
    WeakSelf(weakSelf)
    UIPanGestureRecognizer * panRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    panRecognizer.delegate = self;
    [self.view addGestureRecognizer:panRecognizer];
    [self.view  addSubview:self.shawdowView];
    self.rightDrawerView = [YWRoomDeatilsLeftView loadNameRoomDeatilsLeftViewXib];
    //    weakSelf.rightDrawerView.roomViewController = self;
    
    self.rightDrawerView.hideRightView = ^{
        [weakSelf.rightDrawerView removeFromSuperview];
        [GKCover hide];
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    self.rightDrawerView.frame = CGRectMake(LFscreenW, 0, LFscreenW-70, LFscreenH);
    [[UIApplication sharedApplication].keyWindow  addSubview:self.rightDrawerView];
    
}
- (UIView *)shawdowView
{
    if (!_shawdowView) {
        _shawdowView =  [[UIView alloc] initWithFrame:self.view.frame];
        
        _shawdowView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
        _shawdowView.hidden = YES;
        UITapGestureRecognizer *tapIt = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(tapOnShawdow:)];
        [_shawdowView addGestureRecognizer:tapIt];
        _shawdowView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _shawdowView;
}
- (void)tapOnShawdow:(UITapGestureRecognizer *)recognizer {
    [self closeRightDrawer];
}
- (void) handlePan:(UIPanGestureRecognizer*) recognizer
{
    
    CGPoint translation = [recognizer translationInView:self.view];
    NSLog(@"translation.x == %f", translation.x);
    if ([(UIPanGestureRecognizer*)recognizer state] == UIGestureRecognizerStateBegan) {
        //获取rightView初始位置
        //        _initialPosition.x = self.rightDrawerView.center.x;
        
        _initialPosition.x = self.rightDrawerView.clf_x;
        NSLog(@"movingOffset=---:%f",_initialPosition.x);
    }
    
    
    
    
    
    
    
    
    if([(UIPanGestureRecognizer*)recognizer state] == UIGestureRecognizerStateChanged) {
        float movingOffset = _initialPosition.x + translation.x;
        
        NSLog(@"movingOffset:%f",movingOffset);
        if (movingOffset >= RIGHT_VIEW_WIDTH) {
            //            self.rightDrawerView.center = CGPointMake(movingOffset, self.rightDrawerView.center.y);
            self.rightDrawerView.clf_x = movingOffset;
        }
        
        float changingAlpha = ScreenWidth - self.rightDrawerView.frame.origin.x;
        
        float alpha =  MAX((changingAlpha/ (ScreenWidth*2 + 50)) - 0.5,0);
        
        self.shawdowView.hidden = NO;
        
        self.shawdowView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha: alpha];
        if (self.rightDrawerView.clf_x>=LFscreenW&&translation.x>20) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }
    
    if([(UIPanGestureRecognizer*)recognizer state] == UIGestureRecognizerStateEnded) {
        
        if (translation.x<0) { //左
            
            if (self.rightDrawerView.frame.origin.x < ScreenWidth/2){
                [self openRightDrawer];
            }else{
                [self closeRightDrawer];
            }
        }else{
            
            if (self.rightDrawerView.frame.origin.x > ScreenWidth/2){
                [self closeRightDrawer];
            }else{
                [self openRightDrawer];
            }
        }
        
    }
    
    
    
    
    
    
    
    
}

#pragma mark --
- (void)openRightDrawer
{
    float duration = 0.2;
    
    self.shawdowView.hidden = NO;
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.shawdowView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:SHAWDOW_ALPHA];
                     }
                     completion:nil];
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.rightDrawerView.frame = CGRectMake( RIGHT_VIEW_WIDTH, 0, LFscreenW-70, LFscreenH);
                     }
                     completion:nil];
    
    //    self.isOpen= YES;
    
}

- (void)closeRightDrawer
{
    float duration = 0.2;
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.shawdowView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0f];
                     }
                     completion:^(BOOL finished){
                         self.shawdowView.hidden = YES;
                     }];
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.rightDrawerView.frame = CGRectMake(LFscreenW, 0, LFscreenW-70, LFscreenH);
                     }
                     completion:nil];
    //    self.isOpen= NO;
}

- (void)maskToCorner:(UIView *)view RoundingCorners:(UIRectCorner)corner cornerRedius:(CGSize)size {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                                   byRoundingCorners:corner
                                                         cornerRadii:size];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}
@end
