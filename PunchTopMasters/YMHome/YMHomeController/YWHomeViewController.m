//
//  YWHomeViewController.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/3/26.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWHomeViewController.h"
#import "YWHomeModel.h"
#import "YMRoomViewController.h"
#import "SDCycleScrollView.h"
#import "ATHomeFavButton.h"
#import "YWScreenAletView.h"
#import "YWFastEnterAlertView.h"
#import "YWSelectModel.h"
#import "YWSearchViewController.h"
#import "YWRoomModel.h"
#import "SAVourcherModel.h"
#import "SAVoucherAlertView.h"
#import "YWSearchModel.h"
#import "YWCreatePrasswordAlertView.h"
#import "YWDeleRoomAlertView.h"
#import "YMRoomViewController.h"
#import "YWRoomModel.h"
#import "SAMessageViewController.h"


@interface YWHomeViewController ()<SDCycleScrollViewDelegate,UIScrollViewDelegate>
@property(nonatomic,strong) YWHomeModel * homeModel ;
@property(nonatomic,strong) SDCycleScrollView *cycleScrollView;
@property (weak, nonatomic) IBOutlet UIView *carouselView;
@property (weak, nonatomic) IBOutlet UIView *selectView;
@property (weak, nonatomic) IBOutlet UIView *oneView;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UIView *thirdView;
@property (weak, nonatomic) IBOutlet UILabel *firstTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *secondTitleLB;
@property (weak, nonatomic) IBOutlet UILabel *thirdTitleLb;
@property (weak, nonatomic) IBOutlet UIImageView *firstImageView;
@property (weak, nonatomic) IBOutlet UIImageView *secondImageView;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImageView;
@property (weak, nonatomic) IBOutlet ATHomeFavButton *gameHomeBt;

@property (weak, nonatomic) IBOutlet ATHomeFavButton *roomTypeBt;

@property (weak, nonatomic) IBOutlet ATHomeFavButton *danBt;
@property (weak, nonatomic) IBOutlet UITextField *selectTf;
@property(nonatomic,strong)YWScreenAletView * screenAletView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollVIew;
@property (nonatomic, strong)SAVoucherAlertView * voAlertView;
@property(nonatomic,strong)NSMutableArray * games;
@property(nonatomic,strong)NSMutableArray * rooms;
@property(nonatomic,strong)NSMutableArray * dans;
@property(nonatomic,strong)ATHomeFavButton * seleBt;

@property(nonatomic,strong)YWFastEnterAlertView * fastEnterAlertView;
@property(nonatomic,strong)YWDeleRoomAlertView * deleRoomAlertView;

@property(nonatomic,strong)NSMutableDictionary * gameAreadict;

@property(nonatomic,strong)NSMutableDictionary * roomTypedict;
@property(nonatomic,strong)NSMutableDictionary * segMatchdict;
@property (weak, nonatomic) IBOutlet UIButton *searchRoomBt;
@property(nonatomic,strong)YWRoomModel * roomModel;
@property(nonatomic,strong)YWMyRoomModel * myRoomModel;
@property(nonatomic,strong) YWMyRoomModel * meRoomModel;
@property(nonatomic,strong)NSMutableArray * vourcherModels;

@end

@implementation YWHomeViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [self chackVouc];
    [LFNSNOTI addObserver:self selector:@selector(createentreroom:) name:@"createentreroom" object:nil];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillAppear:animated];
    [LFNSNOTI removeObserver:self];
    
}
-(void)createentreroom:(NSNotification * )info{
   NSString * roomid = info.object;
    YMRoomViewController * roomViewC = [[YMRoomViewController alloc] init];
    roomViewC.roomId = roomid;
    [self.navigationController pushViewController:roomViewC animated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
      self.navigationItem.title = @"约玩";
    self.selectTf.borderStyle = UITextBorderStyleNone;
     self.selectTf.keyboardType = UIKeyboardTypeNumberPad;
//       self.gameHomeBt.buttonStyle =self.roomTypeBt.buttonStyle = self.danBt.buttonStyle = imageRight;
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"通知-灰2" highImage:@"通知-灰2" target:self action:@selector(skipMessage)];
     self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"通知-灰2" selectImage:@"通知-灰2" target:self action:@selector(skipMessage)];
    [YWRequestData getHomeListWithDict:nil success:^(id responseObject) {
        LFLog(@"%@",responseObject);
        self.homeModel = [YWHomeModel mj_objectWithKeyValues:responseObject[@"data"]];
        [self assignmentData:self.homeModel ];
    }];
    
    [self.gameHomeBt addTarget:self action:@selector(gameHomeBtClick:) forControlEvents:UIControlEventTouchUpInside];
      [self.roomTypeBt addTarget:self action:@selector(roomTypeBtClick:) forControlEvents:UIControlEventTouchUpInside];
    
 NSString *filePath = [[NSBundle mainBundle] pathForResource:@"searchDatas" ofType:@"plist"];
   
    NSMutableDictionary *datas = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    [self.danBt addTarget:self action:@selector(danBtClick:) forControlEvents:UIControlEventTouchUpInside];
    self.dans = datas[@"segMatchs"];
    self.rooms = datas[@"roomTypes"];
    self.games =  datas[@"gameAreas"];
    
    self.scrollVIew.delegate = self;
    UITapGestureRecognizer * tap1= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapl)];
//    [self.view addGestureRecognizer:tap1];
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 200, LFscreenW-30,  12)];
    [self setLyerView:self.selectView];
    self.selectView.layer.shadowPath = shadowPath.CGPath;
    
    
    
       UITapGestureRecognizer * firstViewTop= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(firstViewTopClick)];
     UITapGestureRecognizer * secondViewTop= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(secondViewTopClick)];
     UITapGestureRecognizer * thirdViewTop= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(thirdViewTopClick)];
     [self.oneView addGestureRecognizer:firstViewTop];
     [self.secondView addGestureRecognizer:secondViewTop];
     [self.thirdView addGestureRecognizer:thirdViewTop];
     self.screenAletView = [YWScreenAletView loadNameYWScreenAletViewXib];
    [self.searchRoomBt addTarget:self action:@selector(searchRoomBtClick) forControlEvents:UIControlEventTouchUpInside];
    [self chackVouc];
    [self setbannerImagView];
}
-(void)searchRoomBtClick{
    if (!loginTokenlength) {
        [ATSKIPTOOl loginAction:self];return;
    }
    WeakSelf(weakSelf)
    if (self.selectTf.text.length) {
        NSMutableDictionary * dict = diction;dict[@"id"] =self.selectTf.text;
        [YWRequestData getRoomDetailsDict:dict success:^(id responseObj) {
            LFLog(@"%@",responseObj);
            self.roomModel = [YWRoomModel mj_objectWithKeyValues:responseObj[@"data"]];
         
            if ( self.roomModel.roomInfo.roomId.length) {
                
                if ( self.roomModel.roomInfo.roomPass.length) {
                    
                    YWCreatePrasswordAlertView * createPrasswordView = [YWCreatePrasswordAlertView loadNameCreatePrasswordAlertViewXib];
                    createPrasswordView.surepassword = ^(NSString *password) {
                        if ([password isEqualToString: self.roomModel.roomInfo.roomPass]) {
                            YMRoomViewController * roomViewC = [[YMRoomViewController alloc] init];
                            roomViewC.roomId =   self.roomModel.roomInfo.roomId;
                            [weakSelf.navigationController pushViewController:roomViewC animated:YES];
                        }else{
                            [MBManager showBriefAlert:@"密码不正确"];
                        }
                    };
                    [GKCover hide];
                    createPrasswordView.clf_size = CGSizeMake(LFscreenW-40, 250);
                    [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:createPrasswordView style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleCenter showAnimStyle:GKCoverShowAnimStyleBottom hideAnimStyle:GKCoverHideAnimStyleNone notClick:NO];
                    
                    return ;
                }
                
                YMRoomViewController * roomViewC = [[YMRoomViewController alloc] init];
                roomViewC.roomId = self.roomModel.roomInfo.roomId;
                [self.navigationController pushViewController:roomViewC animated:YES];
            }else{
                [MBManager showBriefAlert:@"没有此房间"];
            }
        }];
        return;
    }

    YWSearchViewController * searchVc = [[YWSearchViewController alloc] init];
    searchVc.gameAreadict = self.gameAreadict;
     searchVc.roomTypedict = self.roomTypedict;
     searchVc.segMatchdict = self.segMatchdict;
    
     LFLog(@"%@,%@,%@",self.gameAreadict,self.roomTypedict,self.segMatchdict);
    [self.navigationController pushViewController:searchVc animated:YES];
    
}
-(void)skipMessage{
    SAMessageViewController * MessageViewController = [[SAMessageViewController alloc] init];
    [self.navigationController pushViewController:MessageViewController animated:YES];
    
}
-(void)firstViewTopClick{
    if (!loginTokenlength) {
        [ATSKIPTOOl loginAction:self];return;
    }
    WeakSelf(weakSelf)
      self.fastEnterAlertView = [YWFastEnterAlertView loadNameFastEnterAlertViewXib];
    NSMutableDictionary *  roomsDit =    self.rooms[1];
    self.fastEnterAlertView.sureClickScreen = ^(NSMutableDictionary *dict, NSMutableDictionary *dict1) {
       
         [weakSelf entersureroom:dict withdict:dict1 andDict:roomsDit];
    };
      self.fastEnterAlertView.gk_size = CGSizeMake(LFscreenW-56, 380);
    [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:self.fastEnterAlertView style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleCenter showAnimStyle:GKCoverShowAnimStyleBottom hideAnimStyle:GKCoverHideAnimStyleBottom notClick:NO showBlock:^{
    } hideBlock:^{
    }];
    
    
}
-(void)secondViewTopClick{
    if (!loginTokenlength) {
        [ATSKIPTOOl loginAction:self];return;
    }
   WeakSelf(weakSelf)
    self.fastEnterAlertView = [YWFastEnterAlertView loadNameFastEnterAlertViewXib];
    NSMutableDictionary *  roomsDit =    self.rooms[3];
    self.fastEnterAlertView.sureClickScreen = ^(NSMutableDictionary *dict, NSMutableDictionary *dict1) {
       
   [weakSelf entersureroom:dict withdict:dict1 andDict:roomsDit];
      
        
        
        
        
        
        
    };
    self.fastEnterAlertView.gk_size = CGSizeMake(LFscreenW-56, 380);
    [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:self.fastEnterAlertView style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleCenter showAnimStyle:GKCoverShowAnimStyleBottom hideAnimStyle:GKCoverHideAnimStyleBottom notClick:NO showBlock:^{
    } hideBlock:^{
    }];
    
}

-(void)entersureroom:(NSMutableDictionary * )dict withdict:(NSMutableDictionary *)dict1 andDict:(NSMutableDictionary *)roomsDit{
     WeakSelf(weakSelf)
    NSMutableDictionary * fastEnterRoomDict = diction;
    fastEnterRoomDict[@"gameArea"] = dict[@"number"];
    fastEnterRoomDict[@"roomMode"] = @"0";
    fastEnterRoomDict[@"roomType"] = roomsDit[@"number"];
    fastEnterRoomDict[@"segMatch"] = dict1[@"number"];
    fastEnterRoomDict[@"page"] =@(1);
    fastEnterRoomDict[@"size"] =@"1";
    LFLog(@"%@",fastEnterRoomDict);
    [YWRequestData fastEnterRoomDict:fastEnterRoomDict success:^(id responseObject) {
        
        NSMutableArray * searchModels = [YWSearchModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        if ( searchModels.count<=0) {
            [MBManager showBriefAlert:@"暂时未找到匹配的房间，请稍后再试"];
        }else{
            YWSearchModel * searchModel =  [searchModels firstObject];
            
            NSMutableDictionary * dict = diction;dict[@"token"] =  loginToken;
            [YWRequestData isEnterRoomWhitUserId:searchModel.roomId enterSuccess:^(BOOL isEnter, BOOL isMe,YWMyRoomModel * myRoomModel) {
                weakSelf.myRoomModel = myRoomModel;
                if (![searchModel.roomId isEqualToString:myRoomModel.roomId]) {
                    
                    if (searchModel.roomPass.length) {
                        
                        YWCreatePrasswordAlertView * createPrasswordView = [YWCreatePrasswordAlertView loadNameCreatePrasswordAlertViewXib];
                        createPrasswordView.surepassword = ^(NSString *password) {
                            if ([password isEqualToString:searchModel.roomPass]) {
                                YMRoomViewController * roomViewC = [[YMRoomViewController alloc] init];
                                roomViewC.roomId =  searchModel.roomId;
                                [weakSelf.navigationController pushViewController:roomViewC animated:YES];
                            }else{
                                [MBManager showBriefAlert:@"密码不正确"];
                            }
                        };
                        [GKCover hide];
                        createPrasswordView.clf_size = CGSizeMake(LFscreenW-40, 250);
                        [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:createPrasswordView style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleCenter showAnimStyle:GKCoverShowAnimStyleBottom hideAnimStyle:GKCoverHideAnimStyleNone notClick:NO];
                        
                        return ;
                    }
                }
                
                
                if (isEnter) {
                    
                    
                    YMRoomViewController * roomViewC = [[YMRoomViewController alloc] init];
                    roomViewC.roomId =  searchModel.roomId;
                    [weakSelf.navigationController pushViewController:roomViewC animated:YES];
                    
                }
                
                if (isMe) {
                    weakSelf. meRoomModel = myRoomModel;
                    weakSelf.deleRoomAlertView = [YWDeleRoomAlertView loadNameDeleRoomAlertViewXib];
                    [weakSelf.deleRoomAlertView.alertImg setImage:[UIImage imageNamed:@"sure_alert_icon"]];
                    weakSelf.deleRoomAlertView.messageLb.text = @"您加入新房间，将会解散原来的房间";
                    [weakSelf.deleRoomAlertView.sureBt addTarget:weakSelf action:@selector(sureBtClick) forControlEvents:UIControlEventTouchUpInside];
                    weakSelf.deleRoomAlertView.gk_size = CGSizeMake(LFscreenW-40, 250);
                    [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:weakSelf.deleRoomAlertView style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleCenter showAnimStyle:GKCoverShowAnimStyleCenter hideAnimStyle:GKCoverHideAnimStyleCenter notClick:NO showBlock:^{
                    } hideBlock:^{
                        
                    }];
                    
                }
            }];
            
            
        }
        
    } failed:^(NSError *error) {
        
    }];
    
    
    
    
    
}

-(void)sureBtClick{
    
    
    
    NSMutableDictionary * deledict = diction;
    deledict[@"roomId"] =  self. meRoomModel.roomId;
    [YWRequestData deleRoomDict:deledict success:^(id responseObj) {
        [GKCover hideCover];
        NSMutableDictionary *  myRoomDict = diction;myRoomDict[@"token"] =  loginToken;
        [YWRequestData myRoomDict:myRoomDict success:^(id responseObj) {
            self.myRoomModel = [YWMyRoomModel mj_objectWithKeyValues:responseObj[@"data"]];
            if (self.myRoomModel.roomId.length) {
                YMRoomViewController * roomViewC = [[YMRoomViewController alloc] init];
                roomViewC.roomId =     self.myRoomModel.roomId;
                [self.navigationController pushViewController:roomViewC animated:YES];
            }else{
             
                YMRoomViewController * roomViewC = [[YMRoomViewController alloc] init];
                roomViewC.roomId =     self.myRoomModel.roomId;
                [self.navigationController pushViewController:roomViewC animated:YES];
            }
        }];
        
    }];
}








-(void)thirdViewTopClick{
    if (!loginTokenlength) {
        [ATSKIPTOOl loginAction:self];return;
    }
    WeakSelf(weakSelf)
    self.fastEnterAlertView = [YWFastEnterAlertView loadNameFastEnterAlertViewXib];
    NSMutableDictionary *  roomsDit =    self.rooms[2];
    self.fastEnterAlertView.sureClickScreen = ^(NSMutableDictionary *dict, NSMutableDictionary *dict1) {
       
       [weakSelf entersureroom:dict withdict:dict1 andDict:roomsDit];
    };
    self.fastEnterAlertView.gk_size = CGSizeMake(LFscreenW-56, 380);
    [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:self.fastEnterAlertView style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleCenter showAnimStyle:GKCoverShowAnimStyleBottom hideAnimStyle:GKCoverHideAnimStyleBottom notClick:NO showBlock:^{
    } hideBlock:^{
    }];
    
}

#pragma mark -------新人红包-------
-(void)chackVouc{
    
    if (!loginTokenlength) {
        [self chackVoucher];//弹出代金券
        
    }else{
        [self chackVoucherIfreceived];//弹出代金券
       
        
    }
    
    
}
#pragma mark-----没有登陆弹出代金券
-(void)chackVoucher{
    LFLog(@"%@",INFO_GIFTBAG_LIST);
    
    [LFHttpTool post:INFO_GIFTBAG_LIST params:nil progress:^(id downloadProgress) {
        LFLog(@"%@",INFO_GIFTBAG_LIST);
    } success:^(id responseObj) {
        LFLog(@"%@",responseObj);
        if ([responseObj[@"status"] isEqual:@(0)]){
            self.vourcherModels = [SAVourcherModel mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
            [self voucherAlertView: self.vourcherModels ];
        }
    } failure:^(NSError *error) {
        LFLog(@"%@",error);
    }];
    
}

#pragma mark-----登陆后代金券是否被领取
-(void)chackVoucherIfreceived{
    NSMutableDictionary * dict= [NSMutableDictionary dictionary];
    dict[@"token"] = loginToken;
    [LFHttpTool post:INFO_GIFTBAG params:dict progress:^(id downloadProgress) {
        
    } success:^(id responseObj) {
        LFLog(@"%@",responseObj);
        if ([responseObj[@"status"] isEqual:@(0)]) {
           self.vourcherModels = [SAVourcherModel mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
            if ([responseObj[@"status"] isEqual:@(1)]) {
                [LFHttpTool post:INFO_GIFTBAG_LIST params:nil progress:^(id downloadProgress) {
                    LFLog(@"%@",INFO_GIFTBAG_LIST);
                } success:^(id responseObj) {
                    LFLog(@"%@",responseObj);
                    if ([responseObj[@"status"] isEqual:@(0)]){
                        self.vourcherModels = [SAVourcherModel mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
                        [self voucherAlertView: self.vourcherModels ];
                    }
                } failure:^(NSError *error) {
                    LFLog(@"%@",error);
                }];
            }
           
            
        }
         LFLog(@"%@",self.vourcherModels);
    } failure:^(NSError *error) {
        LFLog(@"%@",error);
    }];
    
}
//申请成功的弹框
-(void)voucherAlertView:(NSMutableArray * )vourcherModels{
    
    UIView * bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor clearColor];
    CGFloat H = (LFscreenW-30)*368/343;
    bottomView.gk_size = CGSizeMake(KScreenW-30, H);
    self.voAlertView = [SAVoucherAlertView voucherAlertView];
    self.voAlertView.hLyout.constant = H * 26/368;
    self.voAlertView.moneyLeftLyout.constant = (KScreenW-30) * 17/343;
    self.voAlertView.dataLeftLyout.constant = (KScreenW-30) * 87/343;
    self.voAlertView.hidenCover = ^{
        [GKCover hideCover];
    };
    [self.voAlertView.immediatelyUseBt addTarget:self action:@selector(immediatelyUseClick) forControlEvents:UIControlEventTouchUpInside];
    self.voAlertView.vourcherModels = vourcherModels;
    self.voAlertView.frame = bottomView.bounds;
    [bottomView addSubview:self.voAlertView];
    [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:bottomView style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleCenter showAnimStyle:GKCoverShowAnimStyleBottom hideAnimStyle:GKCoverHideAnimStyleBottom notClick:NO];
    bottomView.clf_centerY = LFscreenH/2;
    
}
#pragma mark-----没有登陆 去登陆--------
-(void)immediatelyUseClick{
    
    if (!loginTokenlength) {
        [GKCover hideCover];
        [ATSKIPTOOl loginAction:self];return;
    }else{
        [GKCover hideCover];
    }
    
    return;
    
}




-(void)setLyerView:(UIView *)view{
    view.layer.masksToBounds = NO;
    view.layer.shadowColor = [UIColor grayColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(0, 0);
    view.layer.shadowOpacity = 0.3f;
    view.layer.shadowRadius=5;
    
}
-(void)tapl{
    [self.view endEditing:YES];
}
-(void)gameHomeBtClick:(ATHomeFavButton * )bt{

    self.seleBt.selected = NO;
    bt.selected = YES;
    self.seleBt = bt;
    [self screenClick:self.games clickBt:bt];
    
}

-(void)roomTypeBtClick:(ATHomeFavButton * )bt{
    self.seleBt.selected = NO;
    bt.selected = YES;
    self.seleBt = bt;
     [self screenClick:self.rooms clickBt:bt];
    
}
-(void)danBtClick:(ATHomeFavButton * )bt{
    self.seleBt.selected = NO;
    bt.selected = YES;
    self.seleBt = bt;
    [self screenClick:self.dans clickBt:bt];
    
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
-(void)screenClick:(NSMutableArray *)arry clickBt:(ATHomeFavButton * )bt{
    if (!loginTokenlength) {
        [ATSKIPTOOl loginAction:self];return;
    }
    [self.view endEditing:YES];
    WeakSelf(weakSelf)
    self.screenAletView.sureClickScreenAletView = ^(NSMutableDictionary *dict) {
        weakSelf.seleBt.selected = NO;
        [bt setTitle:dict[@"name"] forState:UIControlStateNormal];
        if (bt == self.gameHomeBt) {
            weakSelf.gameAreadict = dict;
        }else if (bt == self.danBt){
             weakSelf.segMatchdict = dict;
        }else if (bt == self.roomTypeBt){

             weakSelf.roomTypedict = dict;
        }
    };
    if (bt == self.gameHomeBt) {
      
        weakSelf.screenAletView.titleLb.text = @"选择游戏大区";
    }else if (bt == self.danBt){
        weakSelf.screenAletView.titleLb.text = @"选择段位";
      
    }else if (bt == self.roomTypeBt){
        weakSelf.screenAletView.titleLb.text = @"选择房间类型";
      
    }
    self.screenAletView.array = arry;
    self.screenAletView.gk_size = CGSizeMake(LFscreenW, 260);

    
    [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:self.screenAletView style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleBottom showAnimStyle:GKCoverShowAnimStyleBottom hideAnimStyle:GKCoverHideAnimStyleBottom notClick:NO showBlock:^{
        
    } hideBlock:^{
        self.seleBt.selected = NO;
    }];
    
    [GKCover layoutSubViews];
}
-(void)assignmentData:(YWHomeModel *)homeModel{
    NSMutableArray * array = [NSMutableArray array];
    for (RoomModel * homemde in  self.homeModel.headAds) {
        [array addObject:homemde.pic];
    }
   
    self.cycleScrollView.imageURLStringsGroup = array;
//    [self.firstImageView sd_setImageWithURL:[NSURL URLWithString:[[self.homeModel.roomTypeList firstObject] pic]] placeholderImage:nil];
//    [self.secondImageView sd_setImageWithURL:[NSURL URLWithString:[self.homeModel.roomTypeList[2] pic]] placeholderImage:nil];
//    [self.thirdImageView sd_setImageWithURL:[NSURL URLWithString:[[self.homeModel.roomTypeList lastObject] pic]] placeholderImage:nil];
    
   
     [self.firstImageView setImage:[UIImage imageNamed:@"AA"]];
      [self.self.secondImageView setImage:[UIImage imageNamed:@"悬赏"]];
      [self.thirdImageView setImage:[UIImage imageNamed:@"撒币"]];
    
    
}


-(void)setbannerImagView{
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, LFscreenW, 126) delegate:self placeholderImage:[UIImage imageNamed:@"banner默认"]];
    self.cycleScrollView = cycleScrollView;
    cycleScrollView.delegate = self;
    cycleScrollView. bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView.currentPageDotColor = assistColor; // 自定义分页控件小圆标颜色
    cycleScrollView.pageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    [self.carouselView addSubview:cycleScrollView];
}
//- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
//{
//
//}
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
  
    RoomModel *  roomModel  = self.homeModel.headAds[index];
    [ATSKIPTOOl ViewController:self message:roomModel];
    LFLog(@"%@---",roomModel.type);
}
//
///** 图片滚动回调 */
//- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
//     LFLog(@"11111111111111");
//}


@end
