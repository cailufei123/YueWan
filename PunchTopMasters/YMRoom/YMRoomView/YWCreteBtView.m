//
//  YWCreteBtView.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/3/27.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWCreteBtView.h"
#import "YMMeModel.h"
#import "YWMasterCheakGusetMessageAlertView.h"
#import "YWGusetCheckGusetView.h"
#import "YWRoomMeCheckMeView.h"
#import "YWCreatePayViewController.h"

@interface YWCreteBtView()
@property(strong,nonatomic) YWMasterCheakGusetMessageAlertView * masterCheakGusetMessageAlertView;
@property(strong,nonatomic) YWEnterQueueAlertView * enterQueueAlertView;
@property(copy,nonatomic) NSString * meUid;
@end
@implementation YWCreteBtView

-(void)awakeFromNib{
   
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    self.iocnBgView.layer.borderWidth =3;
    [self.iocnBgView layercornerRadius:32];
   
     self.iocnBgView.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0].CGColor;
    self.iocnBgView.backgroundColor = [[SVGloble colorWithHexString:@"#10121E"] colorWithAlphaComponent:0.8];
    [self iocnBtStatus];
    self.iocnBt.selected = NO;
//    [self.iocnBt setBadgeBGColor:];
    [self hideLb];//文字状态
    [self.iocnBt addTarget:self action:@selector(iocnBtClick:) forControlEvents:UIControlEventTouchUpInside];
//      [LFNSNOTI addObserver:self selector:@selector(paySucessClick) name:paySucess object:nil];
}
//-(void)dealloc{
//    [LFNSNOTI removeObserver:self];
//
//}
//-()
-(void)iocnBtStatus{
    [self.iocnBt setTitle:@"已开启" forState:UIControlStateNormal];
    self.iocnBt.titleLabel.font = [UIFont systemFontOfSize:14];
    self.iocnBt.titleLabel.textColor =[UIColor redColor];
    
    [self.iocnBt setBackgroundImage:nil forState:UIControlStateNormal];
    [self.iocnBt setBackgroundImage:[UIImage imageNamed:@"localImg10"] forState:UIControlStateSelected];
}
-(void)iocnBtClick:(UIButton *)bt{
 UIViewController * skipVc =   [self viewController];
   
    if ([self.roomModel.roomInfo.userId isEqualToString:loginUid]) {//操控的是房主
        if ([self.roomModel.roomInfo.gameStatus isEqualToString:@"1"]) {////0：未开始；1、启动中(房主点击唤起游戏) 2、游戏中(客服收到链接已开始游戏) 3、结算中，(房主手动点击结束游戏) 4、游戏结束；
            [MBManager showBriefAlert:@"启动中不能操控队列"];
            return ;
        }
        
        if ([self.roomModel.roomInfo.gameStatus isEqualToString:@"2"]) {////0：未开始；1、启动中(房主点击唤起游戏) 2、游戏中(客服收到链接已开始游戏) 3、结算中，(房主手动点击结束游戏) 4、游戏结束；
            [MBManager showBriefAlert:@"游戏中不能操控队列"];
            return ;
        }
        if ([self.roomModel.roomInfo.gameStatus isEqualToString:@"3"]) {////0：未开始；1、启动中(房主点击唤起游戏) 2、游戏中(客服收到链接已开始游戏) 3、结算中，(房主手动点击结束游戏) 4、游戏结束；
            [MBManager showBriefAlert:@"结算中不能操控队列"];
            return ;
        }
        if ([self.roomModel.roomInfo.gameStatus isEqualToString:@"4"]) {////0：未开始；1、启动中(房主点击唤起游戏) 2、游戏中(客服收到链接已开始游戏) 3、结算中，(房主手动点击结束游戏) 4、游戏结束；
            [MBManager showBriefAlert:@"游戏结束不能操控队列"];
            return ;
        }
        
        if (_gameQueueModel) {
             NSMutableDictionary * userHomeDict = diction;
            userHomeDict[@"userId"] = self.gameQueueModel.userId;
            userHomeDict[@"isStat"] = @"1";
            [YWRequestData userHomePageDict:userHomeDict success:^(id responseObj) {
                  YMMeModel * meModel = [YMMeModel mj_objectWithKeyValues:responseObj[@"data"]];
                
                
                self.masterCheakGusetMessageAlertView = [YWMasterCheakGusetMessageAlertView loadNameMasterCheakGusetMessageAlertViewXib];
                self.masterCheakGusetMessageAlertView.userHomePageModel =  meModel;
                 self.masterCheakGusetMessageAlertView.userSegmetLb.text = self.danLb.text;
                self.masterCheakGusetMessageAlertView.roomModel = self.roomModel;
                
                
                self.masterCheakGusetMessageAlertView.gk_size = CGSizeMake(LFscreenW, 320);
//                self.enterQueueAlertView.joinQueue = ^(NSString *userGrade) {
//
//                };
                [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:self.masterCheakGusetMessageAlertView style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleBottom showAnimStyle:GKCoverShowAnimStyleBottom hideAnimStyle:GKCoverHideAnimStyleNone notClick:NO showBlock:^{
                } hideBlock:^{
                    
                }];
                
            }];
            
        }else{
           
            
            if ([bt.titleLabel.text isEqualToString: @"已关闭"]) {
                NSMutableDictionary * addDict = diction;
                addDict[@"token"] = loginToken;
                addDict[@"gameId"] = _roomModel.roomInfo.gameId;
                bt.userInteractionEnabled = NO;
                [YWRequestData quitAddOneQueueDict:addDict success:^(id responseObj) {
                     [LFNSNOTI postNotificationName:enterQueueRefresh object:addQueueRefresh];
                       [self.iocnBt setTitle:@"已开启" forState:UIControlStateNormal];
                     bt.userInteractionEnabled = YES;
                }];
            }else{
                
                NSMutableDictionary * dic = diction;dic[@"id"] =_roomModel.roomInfo.roomId;
                [YWRequestData getRoomDetailsDict:dic success:^(id responseObj) {
                    YWRoomModel * roomModel = [YWRoomModel mj_objectWithKeyValues:responseObj[@"data"]];
                    if ([roomModel.roomInfo.gameStatus isEqualToString:@"1"]) {////0：未开始；1、启动中(房主点击唤起游戏) 2、游戏中(客服收到链接已开始游戏) 3、结算中，(房主手动点击结束游戏) 4、游戏结束；
                        [MBManager showBriefAlert:@"启动中不能操控队列"];
                        return ;
                    }
                    
                    if ([roomModel.roomInfo.gameStatus isEqualToString:@"2"]) {////0：未开始；1、启动中(房主点击唤起游戏) 2、游戏中(客服收到链接已开始游戏) 3、结算中，(房主手动点击结束游戏) 4、游戏结束；
                        [MBManager showBriefAlert:@"游戏中不能操控队列"];
                        return ;
                    }
                    if ([roomModel.roomInfo.gameStatus isEqualToString:@"3"]) {////0：未开始；1、启动中(房主点击唤起游戏) 2、游戏中(客服收到链接已开始游戏) 3、结算中，(房主手动点击结束游戏) 4、游戏结束；
                        [MBManager showBriefAlert:@"结算中不能操控队列"];
                        return ;
                    }
                    if ([roomModel.roomInfo.gameStatus isEqualToString:@"4"]) {////0：未开始；1、启动中(房主点击唤起游戏) 2、游戏中(客服收到链接已开始游戏) 3、结算中，(房主手动点击结束游戏) 4、游戏结束；
                        [MBManager showBriefAlert:@"游戏结束不能操控队列"];
                        return ;
                    }
                   
                    
                    
                    
                    if ([roomModel.roomInfo.roomMode isEqualToString:@"1"]&&[roomModel.requireQueueCount integerValue] <=2) {
                        [MBManager showBriefAlert:@"当前队列不能关闭"];
                        return ;
                    }
                    if ([roomModel.roomInfo.roomMode isEqualToString:@"2"]) {
                        [MBManager showBriefAlert:@"当前队列不能关闭"];
                        return ;
                    }
                    if ([roomModel.requireQueueCount integerValue] <=2) {
                        [MBManager showBriefAlert:@"当前队列不能关闭"];
                        return ;
                    }
                    bt.userInteractionEnabled = NO;
                    NSMutableDictionary * subDict = diction;
                    subDict[@"token"] = loginToken;
                    subDict[@"gameId"] = roomModel.roomInfo.gameId;
                    LFLog(@"%@",subDict);
                    [YWRequestData quitSubOneQueueDict:subDict success:^(id responseObj) {
                        [LFNSNOTI postNotificationName:enterQueueRefresh object:subQueueRefresh];
                        [self.iocnBt setTitle:@"已关闭" forState:UIControlStateNormal];
                        bt.userInteractionEnabled = YES;
                    }];
                    
                }];
                
         
            }
            
        }
        
    }else{
        
        
        if ([self.roomModel.roomInfo.gameStatus isEqualToString:@"1"]) {////0：未开始；1、启动中(房主点击唤起游戏) 2、游戏中(客服收到链接已开始游戏) 3、结算中，(房主手动点击结束游戏) 4、游戏结束；
            [MBManager showBriefAlert:@"启动中不能加入队列"];
            return ;
        }
        
        if ([self.roomModel.roomInfo.gameStatus isEqualToString:@"2"]) {////0：未开始；1、启动中(房主点击唤起游戏) 2、游戏中(客服收到链接已开始游戏) 3、结算中，(房主手动点击结束游戏) 4、游戏结束；
            [MBManager showBriefAlert:@"游戏中不能加入队列"];
            return ;
        }
        if ([self.roomModel.roomInfo.gameStatus isEqualToString:@"3"]) {////0：未开始；1、启动中(房主点击唤起游戏) 2、游戏中(客服收到链接已开始游戏) 3、结算中，(房主手动点击结束游戏) 4、游戏结束；
            [MBManager showBriefAlert:@"结算中不能加入队列"];
            return ;
        }
        if ([self.roomModel.roomInfo.gameStatus isEqualToString:@"4"]) {////0：未开始；1、启动中(房主点击唤起游戏) 2、游戏中(客服收到链接已开始游戏) 3、结算中，(房主手动点击结束游戏) 4、游戏结束；
            [MBManager showBriefAlert:@"游戏结束不能加入队列"];
            return ;
        }
        
        
        if (_gameQueueModel||self.meUid.length) {//点击的有图片的
              NSMutableDictionary * userHomeDict = diction;
            WeakSelf(weakSelf)
            if (self.meUid.length ||[_gameQueueModel.userId isEqualToString:loginUid]) {
               
                userHomeDict[@"userId"] = loginUid;
                 userHomeDict[@"isStat"] = @"1";

                [YWRequestData userHomePageDict:userHomeDict success:^(id responseObj) {
                    YMMeModel * meModel = [YMMeModel mj_objectWithKeyValues:responseObj[@"data"]];


                    YWRoomMeCheckMeView * roomMeCheckMeView  = [YWRoomMeCheckMeView loadNameRoomMeCheckMeViewXib];
                    roomMeCheckMeView.userQuitQueue = ^{
                        [weakSelf hideLb];
                         [self.iocnBt setTitle:@"已开启" forState:UIControlStateNormal];
                    };
                    roomMeCheckMeView.userHomePageModel =  meModel;
                    roomMeCheckMeView.userSegmetLb.text = self.danLb.text;
                    roomMeCheckMeView.roomModel = self.roomModel;
                    roomMeCheckMeView.gk_size = CGSizeMake(LFscreenW, 280);
                    //                self.enterQueueAlertView.joinQueue = ^(NSString *userGrade) {
                    //
                    //                };
                    [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:roomMeCheckMeView style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleBottom showAnimStyle:GKCoverShowAnimStyleBottom hideAnimStyle:GKCoverHideAnimStyleNone notClick:NO showBlock:^{
                    } hideBlock:^{

                    }];

                }];

            }else{
                
                userHomeDict[@"userId"] = _gameQueueModel.userId;
                 userHomeDict[@"isStat"] = @"1";
                [YWRequestData userHomePageDict:userHomeDict success:^(id responseObj) {
                    YMMeModel * meModel = [YMMeModel mj_objectWithKeyValues:responseObj[@"data"]];
                    
                    
                    YWGusetCheckGusetView * gusetCheckGusetView = [YWGusetCheckGusetView loadNameGusetCheckGusetViewXib];
                    gusetCheckGusetView.userHomePageModel =  meModel;
                    gusetCheckGusetView.userSegmetLb.text = self.danLb.text;
                    gusetCheckGusetView.roomModel = self.roomModel;
                    
                    
                    gusetCheckGusetView.gk_size = CGSizeMake(LFscreenW, 280);
                    //                self.enterQueueAlertView.joinQueue = ^(NSString *userGrade) {
                    //
                    //                };
                    [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:gusetCheckGusetView style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleBottom showAnimStyle:GKCoverShowAnimStyleBottom hideAnimStyle:GKCoverHideAnimStyleNone notClick:NO showBlock:^{
                    } hideBlock:^{
                        
                    }];
                    
                }];
                
            }
            
        
          
           
            
            
        }else{//点击的没有图片的
            
              if ([bt.titleLabel.text isEqualToString: @"已关闭"]) {
                  return;
              }
            
            
            
            
            
            
            NSMutableDictionary * myRoomDict = diction;myRoomDict[@"token"] =  loginToken;
            [YWRequestData myRoomDict:myRoomDict success:^(id responseObj) {
                YWMyRoomModel * myRoomModel = [YWMyRoomModel mj_objectWithKeyValues:responseObj[@"data"]];
                if ([myRoomModel.isInQueue isEqualToString: @"1"]) {
                    
                }else{
                    WeakSelf(weakSelf)
                    
                    
                    self.enterQueueAlertView = [YWEnterQueueAlertView loadNameEnterQueueAlertViewXib];
                    self.enterQueueAlertView.roomModel =self.roomModel;
                    self.enterQueueAlertView.gk_size = CGSizeMake(LFscreenW-40, 310);
                    
                    self.enterQueueAlertView.joinEnterQueue = ^(NSString *userGrade) {
                     
                        if ([self.roomModel.roomInfo.roomType isEqualToString:@"1"]||[self.roomModel.roomInfo.roomType isEqualToString:@"3"]) {
                            if ([self.roomModel.roomInfo.roomMoney doubleValue]>0) {
                                YWCreatePayViewController * orderVc = [[YWCreatePayViewController alloc] init];
                                 orderVc.callbackType = @"2";
                                orderVc.createModel = weakSelf.roomModel;
                                orderVc.payVerificationS = ^{
                                   
                                    NSMutableDictionary * userHomeDict = diction;
                                    userHomeDict[@"userId"] = loginUid;
                                    userHomeDict[@"isStat"] = @"0";
                                    [YWRequestData userHomePageDict:userHomeDict success:^(id responseObj) {
                                        YMMeModel * meModel = [YMMeModel mj_objectWithKeyValues:responseObj[@"data"]];
                                        weakSelf.meUid = meModel.user.userId;
                                        weakSelf.danLb.text = userGrade;
                                        [weakSelf.iocnBt sd_setImageWithURL:[NSURL URLWithString:meModel.user.icon] forState:UIControlStateNormal];
                                        weakSelf.nameLb.text =  meModel.user.name;
                                        
                                        [weakSelf showLb ];
                                           [LFNSNOTI postNotificationName:enterQueueRefresh object:enterQueueRefresh];
                                    }];
                                };
                                [skipVc.navigationController pushViewController:orderVc withTransition:YES];
                                return ;
                                
                            }
                        }
                        
                        
                    };
                    self.enterQueueAlertView.joinQueue = ^(NSString *userGrade) {
                     
                        
                            NSMutableDictionary * userHomeDict = diction;
                            userHomeDict[@"userId"] = loginUid;
                            userHomeDict[@"isStat"] = @"0";
                            [YWRequestData userHomePageDict:userHomeDict success:^(id responseObj) {
                                YMMeModel * meModel = [YMMeModel mj_objectWithKeyValues:responseObj[@"data"]];
                                weakSelf.meUid = meModel.user.userId;
                                  weakSelf.danLb.text = userGrade;
                                [weakSelf.iocnBt sd_setImageWithURL:[NSURL URLWithString:meModel.user.icon] forState:UIControlStateNormal];
                                weakSelf.nameLb.text =  meModel.user.name;
                              
                                [weakSelf showLb ];
                            }];
                            
                        
                    };
                    [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:self.enterQueueAlertView style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleCenter showAnimStyle:GKCoverShowAnimStyleCenter hideAnimStyle:GKCoverHideAnimStyleCenter notClick:NO showBlock:^{
                    } hideBlock:^{
                        
                    }];
                    
                    [GKCover layoutSubViews];
                }
            }];
            
            
            
            
            
            
            
         
               
        }
    }

}

    
    
    
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
    
    
    
    
    
    


-(void)setGameQueueModel:(YWGameQueueModel *)gameQueueModel{
    
    _gameQueueModel = gameQueueModel;
    [self.iocnBt sd_setImageWithURL:[NSURL URLWithString:gameQueueModel.userLogo] forState:UIControlStateNormal];
    self.nameLb.text =  gameQueueModel.userName;
    NSMutableDictionary *datas = [[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"searchDatas" ofType:@"plist"]];
    NSArray * array = datas[@"createSegMatchs"];
    NSDictionary * dict = array[[gameQueueModel.userGrade integerValue]-1];
    self.danLb.text = dict[@"name"];
    [self.iocnBt setTitle:@"已开启" forState:UIControlStateNormal];
    [self showLb ];
}







-(void)hideLb{
    self.nameLb.hidden = self.danLb.hidden = YES;
    
}
-(void)showLb{
     self.nameLb.hidden = self.danLb.hidden = NO;
}
+(instancetype)loadNameCreteBtViewXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
@end
