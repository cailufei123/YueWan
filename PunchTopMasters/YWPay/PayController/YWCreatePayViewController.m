//
//  YWCreatePayViewController.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/5/2.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWCreatePayViewController.h"
#import "YWSelectlevelAlertView.h"
#import "YWCouponViewController.h"
#import "SAPayModel.h"
#import "SAPayWebViewController.h"
#import "SAWetChatWebViewController.h"
@interface YWCreatePayViewController ()
@property (weak, nonatomic) IBOutlet UILabel *segmentLb;
@property (weak, nonatomic) IBOutlet UILabel *roomTypeLb;
@property (weak, nonatomic) IBOutlet UILabel *priceLb;
@property (weak, nonatomic) IBOutlet UILabel *couponLb;

@property (weak, nonatomic) IBOutlet UILabel *allPriceLb;

@property (weak, nonatomic) IBOutlet UIButton *aliPayBt;
@property (weak, nonatomic) IBOutlet UIButton *WeChatPyBt;
@property (weak, nonatomic) IBOutlet UIButton *cionPayBt;
@property (weak, nonatomic) IBOutlet UIButton *payBt;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLb;
@property (weak, nonatomic) IBOutlet UILabel *discountLb;

@property (weak, nonatomic) IBOutlet UILabel *pocketMoneyLb;
@property(nonatomic,strong) YWSelectlevelAlertView * selectlevelAlertView;
@property(nonatomic,copy)NSString * roomType;
@property(nonatomic,copy)NSString * gameArea;
@property(nonatomic,copy)NSString * roomMode;
@property(nonatomic,copy)NSString * selectDan;
@property(nonatomic,strong)NSDictionary * selectDict;

@property(nonatomic,assign)CGFloat allPrice;
@property(nonatomic,assign)CGFloat totalPric;
@property(nonatomic,assign)CGFloat coin;
@property(nonatomic,strong)SAVourcherModel *vourcherModel;
@property(nonatomic,strong)SAPayModel * wishPoolModel;
@property (strong, nonatomic) NSString * pay_trade_no;
@property (weak, nonatomic) IBOutlet UIView *selectSagmentView;
@property (weak, nonatomic) IBOutlet UIView *sagmentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sagmentLyout;
@end

@implementation YWCreatePayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      self.navigationItem.title = @"支付订单";
  
     [self updata];
      [self updataUI];
    NSMutableDictionary * getCoinDict1 = diction;
    getCoinDict1[@"token"] = loginToken;
    [YWRequestData getCoinDict:getCoinDict1 success:^(id responseObj) {
        self.pocketMoneyLb.text = [NSString stringWithFormat:@"零钱余额%0.2lf元",[responseObj[@"data"][@"mobileCoin"] doubleValue]];
        self.coin = [responseObj[@"data"][@"mobileCoin"] doubleValue];
    }];
    [self cahckCoupon];
    
    
   
    if ([self.callbackType isEqualToString:@"1"]) {
        self.selectSagmentView.hidden = YES;
        self.sagmentView.hidden = YES;
        self.sagmentLyout.constant = 0;
    }else  if ([self.callbackType isEqualToString:@"2"]){
        self.selectSagmentView.hidden = NO;
        self.sagmentView.hidden = NO;
        self.sagmentLyout.constant = 74;
    }
}

-(void)cahckCoupon{
  
  
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"token"] = loginToken;
 
    dict[@"orderPrice"] = _createModel.roomInfo.roomMoney;
    [LFHttpTool post:COUPON_GOOD params:dict progress:^(id downloadProgress) {
        
    } success:^(id responseObj) {
     
        if ([responseObj[@"status"]isEqual:@(0)]) {
          NSArray * arr =[SAVourcherModel mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
            self.couponLb.text = @"没有可用的代金券";
            if (arr>0) {
                for (SAVourcherModel * vourcherModel  in arr) {
                    if ([vourcherModel.status isEqualToString:@"0"]) {
                        self.couponLb.text =[NSString stringWithFormat:@"有%ld张代金券可用",arr.count];
                    }
                }
            }
           
        }
    
    } failure:^(NSError *error) {
       
    }];
}

- (IBAction)selectCoupon:(id)sender {
WeakSelf(weakSelf)
    YWCouponViewController *couponVieVc = [[YWCouponViewController alloc] init];
    couponVieVc.vourcherPice = ^(SAVourcherModel *vourcherModel) {
        weakSelf.vourcherModel = vourcherModel;
        
        weakSelf.couponLb.text = [NSString stringWithFormat:@"-%@",vourcherModel.price];
        weakSelf.totalPric = weakSelf.allPrice - [vourcherModel.price doubleValue];
    
        weakSelf.vourcherModel = vourcherModel;
        
          self.discountLb.text = [NSString stringWithFormat:@"已优惠￥%@元",vourcherModel.price];
        self.allPriceLb.text = [NSString stringWithFormat:@"小计：￥%@", [NSString stringWithFormat:@"￥%0.2lf",  weakSelf.totalPric]];
        self.totalPriceLb.text = [NSString stringWithFormat:@"合计：￥%@",[NSString stringWithFormat:@"￥%0.2lf",  weakSelf.totalPric]];
        
        NSMutableAttributedString *totalPricettributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"合计：￥%@",_createModel.roomInfo.roomMoney]];
        [totalPricettributedStr addAttribute:NSForegroundColorAttributeName value:blackBColor range:NSMakeRange(0,3)];
        NSMutableAttributedString *allPriceAttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"小计：￥%@",_createModel.roomInfo.roomMoney]];
        [totalPricettributedStr addAttribute:NSForegroundColorAttributeName value:blackBColor range:NSMakeRange(0,3)];
        self.allPriceLb.attributedText = allPriceAttributedStr;
        self.totalPriceLb.attributedText = totalPricettributedStr;
    };
    couponVieVc.totalPric = _createModel.roomInfo.roomMoney;
    [self.navigationController pushViewController:couponVieVc animated:YES];
}
- (IBAction)selectSegment:(id)sender {
   
    [self danTftap];
}
-(void)updataUI{
    self.segmentLb.text = @"请选择";
    self.roomTypeLb.text =[NSString stringWithFormat:@"%@|%@|%@",self.roomType,self.gameArea,self.roomMode];
    self.priceLb.text =[NSString stringWithFormat:@"￥%@",_createModel.roomInfo.roomMoney];
  
    self.discountLb.text = [NSString stringWithFormat:@"已优惠￥%@元",@"0"];
    [self.aliPayBt addTarget:self action:@selector(aliPayBtClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.WeChatPyBt addTarget:self action:@selector(WeChatPyBtClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.cionPayBt addTarget:self action:@selector(cionPayBtClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.payBt addTarget:self action:@selector(payBtClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self WeChatPyBtClick:self.WeChatPyBt];
    self.allPrice = [_createModel.roomInfo.roomMoney doubleValue];
    self.totalPric = [_createModel.roomInfo.roomMoney doubleValue];
    NSMutableAttributedString *totalPricettributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"合计：￥%@",_createModel.roomInfo.roomMoney]];
    [totalPricettributedStr addAttribute:NSForegroundColorAttributeName value:blackBColor range:NSMakeRange(0,3)];
    NSMutableAttributedString *allPriceAttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"小计：￥%@",_createModel.roomInfo.roomMoney]];
    [allPriceAttributedStr addAttribute:NSForegroundColorAttributeName value:blackBColor range:NSMakeRange(0,3)];
    self.allPriceLb.attributedText = allPriceAttributedStr;
    self.totalPriceLb.attributedText = totalPricettributedStr;
  
  
}
-(void)updata{
    LFLog(@"%@",self.createModel.roomInfo.gameArea );
    if ([self.createModel.roomInfo.gameArea isEqualToString:@"1"]) {
        self.gameArea = @"QQ区";
    }else{
        self.gameArea = @"微信区";
    }
    if ([self.createModel.roomInfo.roomMode isEqualToString:@"1"]) {// 1、多人排位 2、五人排位 3、多人对战',
        self.roomMode = @"多人排位";
    }else if ([self.createModel.roomInfo.roomMode isEqualToString:@"2"]){
        self.roomMode = @"五人排位";
    }else if ([self.createModel.roomInfo.roomMode isEqualToString:@"3"]){
        self.roomMode = @"对战";
    }
    if ([self.createModel.roomInfo.roomType isEqualToString:@"1"]) {// 1、多人排位 2、五人排位 3、多人对战',
        self.roomType = @"AA房间";
    }else if ([self.createModel.roomInfo.roomType isEqualToString:@"2"]){
        self.roomType = @"撒比房";
    }else if ([self.createModel.roomInfo.roomType isEqualToString:@"3"]){
        self.roomType = @"悬赏房";
    }
}
-(void)aliPayBtClick:(UIButton * )bt{
    bt.selected = YES;
  
    self.WeChatPyBt.selected = NO;
      self.cionPayBt.selected = NO;
}
-(void)WeChatPyBtClick:(UIButton * )bt{
      bt.selected = YES;
   self.cionPayBt.selected = NO;
    self.aliPayBt.selected = NO;
}
-(void)cionPayBtClick:(UIButton * )bt{
     bt.selected = YES;
    self.aliPayBt.selected = NO;
     self.WeChatPyBt.selected = NO;
}



-(void)danTftap{
    [self.view endEditing:YES];
    self.selectlevelAlertView = [YWSelectlevelAlertView loadNameSelectlevelXib];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"searchDatas" ofType:@"plist"];
    NSMutableDictionary *datas = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
      self.selectlevelAlertView.array = datas[@"createSegMatchs"];
    WeakSelf(weakSelf)
    self.selectlevelAlertView.sureClickSelectlevelAlertView = ^(NSMutableDictionary *dict) {
        weakSelf. selectDict = dict;
        weakSelf.segmentLb.text = dict[@"name"];
        
        weakSelf.segment = dict[@"number"];
    };
    
    self.selectlevelAlertView.gk_size = CGSizeMake(LFscreenW, 260);
    [GKCover hide];
    
    [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:self.selectlevelAlertView style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleBottom showAnimStyle:GKCoverShowAnimStyleBottom hideAnimStyle:GKCoverHideAnimStyleBottom notClick:NO];
    
    
    
   
}




-(void)payBtClick{//支付
   
    
   
    if ( ![self.segment length]) {
          [MBManager showBriefAlert:@"选择段位"];
    }
    if (self.aliPayBt.selected == NO&&self.WeChatPyBt.selected == NO&&self.cionPayBt.selected == NO) {
        [MBManager showBriefAlert:@"选择支付方式"];
        return;
    }
    if (self.cionPayBt.selected == YES) {
        if (  self.totalPric> self.coin ) {
            [MBManager showBriefAlert:@"余额不足"];
            return;
        }
    }
   
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
  
    
    dict[@"token"] = loginToken;
    for (YWGameQueueModel *gameQueueModel  in  self.createModel.gameQueue) {
        if ([gameQueueModel.isMgt isEqualToString:@"1"]) {
            dict[@"gameId"] = gameQueueModel.gameId;
            dict[@"productId"] =  gameQueueModel.roomId;
        }
    }
    dict[@"productCount"] =@"1";
    dict[@"productName"] =  self.createModel.roomInfo.roomSlogan;
    dict[@"productUrls"] =   self.segment;
    dict[@"price"] = [NSString stringWithFormat:@"%f",self.allPrice];;
    dict[@"callbackType"] = self.callbackType;//回调业务类型 1：房间创建；2：加入队列
    dict[@"appId"] = @"4001";
    dict[@"cpChannel"] = @"apple";
    dict[@"platfrom"] = @"sp";
    dict[@"userCouponId"] = self.vourcherModel.ID;
     LFLog(@"%@",dict);
     LFLog(@"%@",PAY);
   
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [LFHttpTool post:PAY params:dict progress:^(id downloadProgress) {
        
    } success:^(id responseObj) {
        LFLog(@"%@",responseObj);
        [MBManager hideAlert];
        if ([responseObj[@"status"] isEqual:@(0)]) {
            SAPayModel * wishPoolModel =  [SAPayModel mj_objectWithKeyValues:responseObj[@"data"]];
            self.wishPoolModel = wishPoolModel;
            [self payConsumecoin:responseObj[@"data"]];
        }
    } failure:^(NSError *error) {
        LFLog(@"%@",error);
        [MBManager hideAlert];
        [MBManager showBriefAlert:@"网络不给力"];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
-(void)payConsumecoin:(NSDictionary*)dict{
    WeakSelf(weakSelf);
    if (self.aliPayBt.selected == YES){
        SAPayWebViewController * webVc = [[SAPayWebViewController alloc] init];
        webVc.vcMsgStr = self.wishPoolModel.vcMsg;
        [weakSelf.navigationController pushViewController:webVc animated:YES];
        webVc.payVerification = ^{
            [self aliorderQuery];

        };
       
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }else if( self.WeChatPyBt.selected == YES){
        AFURLSessionManager *manager1 = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        //        NSString *requestUrlStr = PAY_WX;
        NSMutableURLRequest *req = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:PAY_WX parameters:nil error:nil];
        // 设置postBody
        LFLog(@"%@",self.wishPoolModel.vcMsg);
        NSData *data =[self.wishPoolModel.vcMsg dataUsingEncoding:NSUTF8StringEncoding];
        [req setHTTPBody:data];
        [[manager1 dataTaskWithRequest:req uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
            
        } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
            
        } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            
            if (!error) {
                LFLog(@"%@",responseObject);
                if ([responseObject[@"status"] isEqualToString:@"SUCC"]) {
                    self.pay_trade_no = responseObject[@"pay_trade_no"];
                    SAWetChatWebViewController * webVc = [[SAWetChatWebViewController alloc] init];
                    webVc.payResultUrl = responseObject[@"payResultUrl"];
                    webVc.payVerification = ^{

                        [MBManager showWaitingWithTitle:@"等待支付结果"];
                       
                          [self payVerificati];
                    };
                    [self.navigationController pushViewController:webVc animated:YES];

                    [MBProgressHUD hideHUDForView:self.view animated:YES];

              }
            }else{
                LFLog(@"%@",error);
            }
            
        }]resume];
        
    }else if( self.cionPayBt.selected == YES){
        if (  self.totalPric> self.coin ) {
              [MBManager showBriefAlert:@"余额不足"];
            return;
        }
        
        
        NSMutableDictionary *  costCoinDict = diction;
        costCoinDict[@"vcMsg"] =  self.wishPoolModel.vcMsg;
        
        AFURLSessionManager *manager1 = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        //        NSString *requestUrlStr = PAY_WX;
        NSMutableURLRequest *req = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:COST_COIN parameters:costCoinDict error:nil];
        // 设置postBody
        LFLog(@"%@",self.wishPoolModel.vcMsg);
        NSData *data =[self.wishPoolModel.vcMsg dataUsingEncoding:NSUTF8StringEncoding];
        [req setHTTPBody:data];
        [[manager1 dataTaskWithRequest:req uploadProgress:^(NSProgress * _Nonnull uploadProgress) {

        } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {

        } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {

            if (!error) {
                LFLog(@"%@",responseObject);
                [MBManager showBriefAlert:@"支付成功"];
                            [LFNSNOTI postNotificationName:paySucess object:nil];
                            [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                LFLog(@"%@",error);
            }

        }]resume];
        
        
        
        
        
        
        
        
        
        
        
        
        
//
//        LFLog(@"%@", costCoinDict[@"vcMsg"]);
//        [YWRequestData costCoinDict:costCoinDict success:^(id responseObj) {
//              [MBManager showBriefAlert:@"支付成功"];
//            [LFNSNOTI postNotificationName:paySucess object:nil];
//            [weakSelf.navigationController popViewControllerAnimated:YES];
//        }];
//
    }
    
    
    
}

-(void)payVerificati{
    WeakSelf(weakSelf);
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"pay_trade_no"] = self.pay_trade_no;
    dict[@"leuid"] = login.userId;
    LFLog(@"%@",self.wishPoolModel.outTradeNo);
    [LFHttpTool post:PAY_WX_QUERY params:dict progress:^(id downloadProgress) {
        
    } success:^(id responseObj) {
        LFLog(@"%@",responseObj);
        [MBManager hideAlert];
        if ([responseObj[@"entity"][@"trade_result"] length]){
            if ( weakSelf.payVerificationS) {
                  weakSelf.payVerificationS();
            }
           
             [LFNSNOTI postNotificationName:paySucess object:nil];
            [weakSelf.navigationController popViewControllerAnimated:YES];
            
        }else{
            [MBManager showBriefAlert:@"支付失败"];
        }
    } failure:^(NSError *error) {
        LFLog(@"%@",error);
        [MBManager hideAlert];
        [MBManager showBriefAlert:@"网络不给力"];
    }];
    
}
-(void)aliorderQuery{
    WeakSelf(weakSelf);
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"orderNo"] =  self.wishPoolModel.outTradeNo;
    dict[@"leuid"] = login.userId;
    [LFHttpTool post:PAY_Ali_QUERY params:dict progress:^(id downloadProgress) {
        
    } success:^(id responseObj) {
        LFLog(@"%@",responseObj);
        [MBManager hideAlert];
        if ([responseObj[@"entity"][@"trade_result"] length]){
            [MBManager showBriefAlert:@"支付成功"];
            if ( weakSelf.payVerificationS) {
                weakSelf.payVerificationS();
            }
             [LFNSNOTI postNotificationName:paySucess object:nil];
            [weakSelf.navigationController popViewControllerAnimated:YES];
           
        }else{
            [MBManager showBriefAlert:@"支付失败"];
        }
    } failure:^(NSError *error) {
        LFLog(@"%@",error);
        [MBManager hideAlert];
        [MBManager showBriefAlert:@"网络不给力"];
    }];
    
}
//-(void)payscuessAlertView{
//
//    UIView * bottomView = [[UIView alloc] init];
//
//    bottomView.backgroundColor = [UIColor clearColor];
//    bottomView.gk_size = CGSizeMake(KScreenW-80, 230);
//
//    self.paySucessAlertView = [SAPaySucessAlertView paySucessAlertViewView];
//    self.paySucessAlertView.hidenCover = ^{
//        [GKCover hideCover];
//    };
//    self.paySucessAlertView.sureSkipWishListVc = ^{
//        //        SAWishListController * wishListController = [[SAWishListController alloc] init];
//        //        [weakSelf.navigationController pushViewController:wishListController animated:YES];
//    };
//    self.paySucessAlertView.frame = bottomView.bounds;
//    [bottomView addSubview:self.paySucessAlertView];
//    [GKCover coverFrom:self.view contentView:bottomView style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleCenter showAnimStyle:GKCoverShowAnimStyleBottom hideAnimStyle:GKCoverHideAnimStyleBottom notClick:NO];
//    bottomView.clf_centerY = LFscreenH/2-50;
//
//}

#pragma mark 获取版本信息
- (NSString *)getAppVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *minorVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return minorVersion;
}
@end
