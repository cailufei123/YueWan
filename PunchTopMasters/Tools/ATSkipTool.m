//
//  ATSkipTool.m
//  Auction
//
//  Created by 蔡路飞 on 2017/11/3.
//  Copyright © 2017年 Cailufei. All rights reserved.
//

#import "ATSkipTool.h"
#import "YWRegistLoginViewController.h"
#import "YWPhoneLoginViewController.h"
#import "YWRoomModel.h"
#import "YWCreatePrasswordAlertView.h"
#import "YMRoomViewController.h"
#import "YWDeleRoomAlertView.h"
#import "YWSearchViewController.h"
#import <UShareUI/UShareUI.h>
//#import "PDDLoginRegistrationContorller.h"
//#import "PDDClassViewController.h"
//#import "PDDDetailsViewController.h"
//#import "PDDOnlyClassViewController.h"
//#import "SASunOrderViewController.h"
//#import "PDDSignViewController.h"
//#import "PDDShareGiftViewController.h"
//#import "ATPresentCionsViewController.h"
//0商品详情 1H5链接 2皮肤竞拍 3分类 4每日打卡 5我的银子6客服页面7优惠券8收藏夹9收货地址10分享有礼11最新开团动态
static id _instance;
@interface ATSkipTool()<UIWebViewDelegate>
@property(strong,nonatomic) YWRoomModel * roomModel;
@property(nonatomic,strong)YWMyRoomModel * meRoomModel;
@property(nonatomic,strong)YWDeleRoomAlertView *deleRoomAlertView;
@property(nonatomic,strong)YWMyRoomModel * myRoomModel;
@property(nonatomic,strong)UIViewController * controller;
@property (nonatomic, strong) NSMutableDictionary *skipShareDic;
@end
@implementation ATSkipTool
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

//public static final int SKIP_ALL_TYPE = 0;//快速开黑
//public static final int SKIP_AA_TYPE = 1;//快速开黑
//public static final int SKIP_SB_TYPE = 2;//快速开黑
//public static final int SKIP_XS_TYPE = 3;//快速开黑
//
//public static final int SKIP_ROOM_DETAIL = 4;//房间详情页
//public static final int SKIP_ROOM_LIST = 5;//房间列表页
//public static final int SKIP_MSG_DETAIL = 6;//消息详情页
//public static final int SKIP_SHARE_FRIEND = 7;//邀请好友页
//public static final int SKIP_HTML = 8;//HTML
-(void)ViewController:(UIViewController * )controller message:(RoomModel *)adModel{
    {
        
        LFLog(@"%@",adModel.type);
       if ([adModel.type isEqualToString:@"0"]) {//商品详情
           [self enterRoom:adModel ViewController:controller];
        }else if ([adModel.type isEqualToString:@"1"]){//H5链接

             [self enterRoom:adModel ViewController:controller];
        }else if ([adModel.type isEqualToString:@"2"]){//皮肤竞拍
         
    [self enterRoom:adModel ViewController:controller];
        }else if ([adModel.type isEqualToString:@"3"]){//分类

      [self enterRoom:adModel ViewController:controller];

        }else if ([adModel.type isEqualToString:@"4"]){//每日打卡
           
  [self enterRoom:adModel ViewController:controller];
        }else if ([adModel.type isEqualToString:@"5"]){//我的银子
            YWSearchViewController * searchVc = [[YWSearchViewController alloc] init];
//            searchVc.gameAreadict = self.gameAreadict;
//            searchVc.roomTypedict = self.roomTypedict;
//            searchVc.segMatchdict = self.segMatchdict;
            
          
            [controller.navigationController pushViewController:searchVc animated:YES];
         
        }else if ([adModel.type isEqualToString:@"6"]){//客服页面
          

        }else if ([adModel.type isEqualToString:@"7"]){//优惠券

            [self skipShare];

        }else if ([adModel.type isEqualToString:@"8"]){//收藏夹
            ATServiceAgreementController * serviceAgreementVc = [[ATServiceAgreementController alloc] init];
            serviceAgreementVc.htmlurl = adModel.shortLink;
            serviceAgreementVc.htmltitle = @"使用规则";
            [controller.navigationController pushViewController:serviceAgreementVc animated:YES];


        }
    }
}
-(void)enterRoom:(RoomModel *)searchModel ViewController:(UIViewController * )controller{
    self.controller = controller;
    NSMutableDictionary * dic = diction;dic[@"id"] = searchModel.eventId;
    [YWRequestData getRoomDetailsDict:dic success:^(id responseObj) {
        
        
        
        self.roomModel = [YWRoomModel mj_objectWithKeyValues:responseObj[@"data"]];
        if(  !self.roomModel.roomInfo){
            [MBManager showBriefAlert:@"没有此房间"];
        }
        NSMutableDictionary * dict = diction;dict[@"token"] =  loginToken;
        [YWRequestData isEnterRoomWhitUserId:searchModel.eventId enterSuccess:^(BOOL isEnter, BOOL isMe,YWMyRoomModel * myRoomModel) {
            if (![searchModel.eventId isEqualToString:myRoomModel.roomId]) {
                
                if (!([ self.roomModel.roomInfo.roomPass isEqualToString:@"null"]|| self.roomModel.roomInfo.roomPass.length<=0) ) {
                    WeakSelf(weakSelf)
                    YWCreatePrasswordAlertView * createPrasswordView = [YWCreatePrasswordAlertView loadNameCreatePrasswordAlertViewXib];
                    createPrasswordView.surepassword = ^(NSString *password) {
                        
                        
                        if ([password isEqualToString: self.roomModel.roomInfo.roomPass]) {
                            YMRoomViewController * roomViewC = [[YMRoomViewController alloc] init];
                            roomViewC.roomId =   searchModel.eventId;
                            [controller.navigationController pushViewController:roomViewC animated:YES];
                        }else{
                            [MBManager showBriefAlert:@"密码不正确"];
                        }
                    };
                    createPrasswordView.clf_size = CGSizeMake(LFscreenW-40, 250);
                    [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:createPrasswordView style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleCenter showAnimStyle:GKCoverShowAnimStyleBottom hideAnimStyle:GKCoverHideAnimStyleNone notClick:NO];
                    
                    return ;
                }
            }
            
            
            if (isEnter) {
                
                
                YMRoomViewController * roomViewC = [[YMRoomViewController alloc] init];
                roomViewC.roomId =  searchModel.eventId;
                [controller.navigationController pushViewController:roomViewC animated:YES];
                
            }
            
            if (isMe) {
                self. meRoomModel = myRoomModel;
                self.deleRoomAlertView = [YWDeleRoomAlertView loadNameDeleRoomAlertViewXib];
                [self.deleRoomAlertView.alertImg setImage:[UIImage imageNamed:@"sure_alert_icon"]];
                self.deleRoomAlertView.messageLb.text = @"您加入新房间，将会解散原来的房间";
                [self.deleRoomAlertView.sureBt addTarget:self action:@selector(sureBtClick) forControlEvents:UIControlEventTouchUpInside];
                self.deleRoomAlertView.gk_size = CGSizeMake(LFscreenW-40, 250);
                [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:self.deleRoomAlertView style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleCenter showAnimStyle:GKCoverShowAnimStyleCenter hideAnimStyle:GKCoverHideAnimStyleCenter notClick:NO showBlock:^{
                } hideBlock:^{
                    
                }];
                
            }
        }];
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
           
                
                
            
                YMRoomViewController * roomViewC = [[YMRoomViewController alloc] init];
                roomViewC.roomId =   self.roomModel.roomInfo.roomId;
                [ self.controller.navigationController pushViewController:roomViewC animated:YES];
            
       }];
        
    }];
}






//-(void)pttkCreate:(NSString *)shortLinkStr{
//    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
//
//    dict[@"token"] = loginToken;
//
//    [LFHttpTool post:[NSString stringWithFormat:@"%@%@",TotolUrl,pttkCreateUrl] params:dict progress:^(id downloadProgress) {
//
//    } success:^(id responseObj) {
//        [MBManager hideAlert];
//        LFLog(@"%@",responseObj);
//
//        if ([responseObj[@"status"] isEqual:@(0)]) {
//
//            //            SATopWeDateilesbViewController * topWeDateilesbVc = [[SATopWeDateilesbViewController alloc] init];
//            //            topWeDateilesbVc.navigationItemTitle = @"在线小游戏";
//            //            topWeDateilesbVc.shortLink = [NSString stringWithFormat:@"%@&token=%@",shortLinkStr,responseObj[@"data"]];
//            //            [self.navigationController pushViewController:topWeDateilesbVc animated:YES];
//
//        }
//
//    } failure:^(NSError *error) {
//        [MBManager hideAlert];
//        [MBManager showBriefAlert:@"网络不给力"];
//
//
//    }];
//
//
//}



- (void)loginAction:(UIViewController * )controller{
    YWPhoneLoginViewController * registVc = [[YWPhoneLoginViewController alloc] init];
    SALoginRegistNavController *naVc = [[SALoginRegistNavController alloc] initWithRootViewController:registVc];
    [controller presentViewController:naVc animated:YES completion:nil];
    
}

-(void)QQtemporaryDialogue:(UIViewController * )controller{
    
    
    NSString * qqNumber=@"289155123";
    //是否安装QQ
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]])
    {
        //用来接收临时消息的客服QQ号码(注意此QQ号需开通QQ推广功能,否则陌生人向他发送消息会失败)
        NSString *QQ = qqNumber;
        //调用QQ客户端,发起QQ临时会话
        NSString *url = [NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",QQ];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
        NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",qqNumber]];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        webView.delegate = self;
        [webView loadRequest:request];
        [controller.view addSubview:webView];
    }else{
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"nil" message:@"对不起，您还没安装QQ" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            
            return ;
        }];
        
        [alertController addAction:cancelAction];
        [controller presentViewController:alertController animated:YES completion:nil];
    }
    
    
    
    
}

-(void)pushToViewControllerWithClassName:(NSString *)className ViewController:(UIViewController * )controller {
    if (className != nil) {
        id myObj = [[NSClassFromString(className) alloc] init];
        @try {
            [controller.navigationController pushViewController:myObj animated:YES];
        }
        @catch (NSException *exception) {
            // 捕获到的异常exception
        }
        @finally {
            // 结果处理
        }
    }
}

-(void)goToXyBtClick{
    
    
    
    LFLog(@"%@",URL_CONFIGS);
    
    [LFHttpTool post:URL_CONFIGS params:nil progress:^(id downloadProgress) {
        
    } success:^(id responseObj) {
        LFLog(@"%@",responseObj);
        if ([responseObj[@"status"] isEqual:@(0)]) {
            self.skipShareDic = responseObj[@"data"][@"SHARE_INVITE_IOS"];
            [self skipShare ];
        }
        
        
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)skipShare{
    if (!loginTokenlength) {
        [ATSKIPTOOl loginAction:self.controller];
        return;
    }
    
    //配置上面需求的参数
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),]];
    [UMSocialShareUIConfig shareInstance].shareTitleViewConfig.isShow = YES;
    [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageMaxRowCountForLandscapeAndBottom = 1;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageMaxColumnCountForLandscapeAndBottom = 1;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageMaxRowCountForPortraitAndBottom = 1;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageMaxColumnCountForLandscapeAndBottom = 3;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageMaxColumnCountForPortraitAndMid = 3;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageMaxColumnCountForPortraitAndBottom = 3;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageMaxColumnCountForLandscapeAndMid = 3;
    
    //    [UMSocialShareUIConfig shareInstance].shareCancelControlConfig.isShow = NO;
    //    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewBackgroundColor = [UIColor redColor];
    //    //每页的背景颜色为黄色
    //    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageBGColor = [UIColor yellowColor];
    //去掉毛玻璃效果
    [UMSocialShareUIConfig shareInstance].shareContainerConfig.isShareContainerHaveGradient = NO;
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        [self shareImageAndTextToPlatformType:platformType];
    }];
    
    
}
- (void)shareImageAndTextToPlatformType:(UMSocialPlatformType)platformType
{
    
    UIImage *image = nil;
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    NSString * valueStr =  self.skipShareDic[@"value"];
    //    NSString * tokenUrl = [valueStr stringByReplacingOccurrencesOfString:@"periodId={periodId}&goodId={goodId}&osType={osType}" withString:[NSString stringWithFormat:@"periodId=%@&goodId=%@&osType=%@", self.orderDateilsModel.orderVo.periodId, self.orderDateilsModel.orderVo.productId,@"2"]];
    //
    //    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:tokenUrl]];
    
    //    if(tokenUrl.length) {
    //        image = [UIImage imageWithData:data]; // 取得图片
    //    }else{
    //        NSDictionary *infoPlist = [[NSBundle mainBundle] infoDictionary];
    //        NSString *icon = [[infoPlist valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
    //        image = [UIImage imageNamed:icon];
    //    }
    NSDictionary *infoPlist = [[NSBundle mainBundle] infoDictionary];
    NSString *icon = [[infoPlist valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
    image = [UIImage imageNamed:icon];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle: self.skipShareDic[@"desc"] descr:@"" thumImage:image];
    //设置网页地址
    shareObject.webpageUrl =valueStr;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}
@end
