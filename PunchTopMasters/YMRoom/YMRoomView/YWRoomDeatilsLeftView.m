//
//  YWRoomDeatilsLeftView.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/11.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWRoomDeatilsLeftView.h"
@interface YWRoomDeatilsLeftView()
@property (weak, nonatomic) IBOutlet UILabel *roomNumberLb;
@property (weak, nonatomic) IBOutlet UILabel *gameAreLb;
@property (weak, nonatomic) IBOutlet UILabel *roomMode;
@property (weak, nonatomic) IBOutlet UILabel *roomSloganLb;
@property (weak, nonatomic) IBOutlet UILabel *segmentMatchLb;
@property (weak, nonatomic) IBOutlet UIButton *editRoomSloganBt;
@property (weak, nonatomic) IBOutlet UIButton *dismissRoomBt;
@property (strong, nonatomic)  NSMutableArray *strs;
@end
@implementation YWRoomDeatilsLeftView


-(void)awakeFromNib{
    
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    [self.editRoomSloganBt addTarget:self action:@selector(editRoomSloganBtClick) forControlEvents:UIControlEventTouchUpInside];
    [self.dismissRoomBt addTarget:self action:@selector(dismissRoomBtClick) forControlEvents:UIControlEventTouchUpInside];
    
    [SVGloble gradientLayer:self.dismissRoomBt];
    
}
-(void)editRoomSloganBtClick{//编辑房房间的口号
    
}
-(void)dismissRoomBtClick{//解散房间
    if ( self.dismissRoomBt.selected == YES) {//
        [self closeRoom];
    }else{//自己
       
        NSMutableDictionary *  getRoomDic = diction;getRoomDic[@"id"] = _roomModel.roomInfo.roomId;
        [YWRequestData getRoomDetailsDict:getRoomDic success:^(id responseObj) {
           YWRoomModel * roomModel = [YWRoomModel mj_objectWithKeyValues:responseObj[@"data"]];
            if ([roomModel.roomInfo.gameStatus isEqualToString:@"1"]) {
                [MBManager showBriefAlert:@"游戏启动中不能解散房间"];
                return ;
                
            }else  if ([roomModel.roomInfo.gameStatus isEqualToString:@"2"]) {
                  [MBManager showBriefAlert:@"游戏中不能解散房间"];
                 return ;
            }
            
            
            
            
            NSMutableDictionary * dict = diction;
            dict[@"roomId"] = _roomModel.roomInfo.roomId;
            [YWRequestData deleRoomDict:dict success:^(id responseObj) {
                self.hideRightView();
                //            [self.roomViewController.navigationController popViewControllerAnimated:YES];
                
                //               [LFNSNOTI postNotificationName:enterQueueRefresh object:deleRoomRefresh];
                EMError *error = [[EMClient sharedClient].roomManager destroyChatroom:_roomModel.roomInfo.roomId];
            }];
        }];
       
    }
    
   
}


-(void)closeRoom{
    
    NSMutableDictionary * dic = diction;dic[@"token"] =  loginToken;
    
    [YWRequestData myRoomDict:dic success:^(id responseObj) {
        YWMyRoomModel * myRoomModel = [YWMyRoomModel mj_objectWithKeyValues:responseObj[@"data"]];
        if ([myRoomModel.isInQueue isEqualToString:@"1"]) {
            NSMutableDictionary * quitdic = diction;quitdic[@"token"] =  loginToken;quitdic[@"gameId"] =  _roomModel.roomInfo.gameId;quitdic[@"roomId"] =  _roomModel.roomInfo.roomId;
            [YWRequestData quitQueueeDict:quitdic success:^(id responseObj) {
                [self leaveRoom];
            }];
        }else{
            [self leaveRoom];
        }
    }];
   
    
    
    
    
    
}
-(void)leaveRoom{
    NSMutableDictionary * di = diction;
    di[@"roomId"] =  _roomModel.roomInfo.roomId;
    di[@"userId"] =loginUid;
    [YWRequestData leaveRoomDict:di success:^(id responseObj) {//离开房间
        self.hidden = YES;
         self.hideRightView();
        
          [LFNSNOTI postNotificationName:enterQueueRefresh object:leaveRoomRefresh];
        
    }];
    
    
}




-(NSMutableArray *)strs{
    if (!_strs) {
        _strs = [NSMutableArray array];
    }
    return _strs;
}
-(void)setRoomModel:(YWRoomModel *)roomModel{
    _roomModel = roomModel;
    self.roomNumberLb.text = roomModel.roomInfo.roomId;
    if ([roomModel.roomInfo.gameArea isEqualToString:@"1"]) {
         self.gameAreLb.text = @"QQ区";
    }else{
         self.gameAreLb.text = @"微信区";
    }
      self.roomSloganLb.text = roomModel.roomInfo.roomSlogan;
    if ([roomModel.roomInfo.roomMode isEqualToString:@"1"]) {// 1、多人排位 2、五人排位 3、多人对战',
        self.roomMode.text = @"多人排位";
    }else if ([roomModel.roomInfo.roomMode isEqualToString:@"2"]){
        self.roomMode.text = @"五人排位";
    }else if ([roomModel.roomInfo.roomMode isEqualToString:@"3"]){
        self.roomMode.text = @"对战";
    }

    [self.strs removeAllObjects];

   NSMutableDictionary *datas = [[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"searchDatas" ofType:@"plist"]];
    NSArray * segMatchsLists = datas[@"segMatchsLists"];
    
    NSArray *array = [roomModel.roomInfo.segMatch componentsSeparatedByString:@","];//#为分隔符
   
    for (NSString * st  in array) {
        if (st.length) {
            NSDictionary * dc = segMatchsLists[[st integerValue]];
            [self.strs addObject:dc[@"name"]];
        }
        
    }
    NSString *laststr = [self.strs componentsJoinedByString:@" "];//#为分隔符
    self.segmentMatchLb.text =[NSString stringWithFormat:@"%@",laststr];
    if ([roomModel.roomInfo.userId isEqualToString:loginUid]) {//房主
        self.dismissRoomBt.selected = NO;
    }else{
        self.dismissRoomBt.selected = YES;
    }
}
+(instancetype)loadNameRoomDeatilsLeftViewXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
@end
