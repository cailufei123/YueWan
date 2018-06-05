//
//  YWMeSetViewController.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/19.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWMeSetViewController.h"
#import "YWSetModel.h"
#import "YWBindCustomerServiceAlertView.h"
#import "YWUBindQQWXAlertView.h"

@interface YWMeSetViewController ()
@property (weak, nonatomic) IBOutlet UILabel *isSetQQLb;
@property (weak, nonatomic) IBOutlet UILabel *isSetWeChatLb;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLb;
@property (weak, nonatomic) IBOutlet UILabel *QQNumberLb;
@property (weak, nonatomic) IBOutlet UILabel *wxNumberLb;
@property(nonatomic,strong) YWSetModel * setModel ;
@property (strong, nonatomic)  YWBindCustomerServiceAlertView *bindCustomerServiceAlertView;
- (IBAction)outLoginBtClick:(id)sender;

@end

@implementation YWMeSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    [self checkQQWXisSet ];
    self.phoneNumberLb.text = login.mobile;
  
}

-(void)checkQQWXisSet{
    if (loginOpenId.length) {
        if ([login.source isEqualToString:@"2"]) {
            self.wxNumberLb.text = @"已绑定";
            self.QQNumberLb.text = @"未绑定";
            self.isSetQQLb.text = @"未设置";
            self.isSetQQLb.textColor = [SVGloble colorWithHexString:@"#6FA4FF"];
            [self checkCustomer:@"2" issetLable:self.isSetWeChatLb];
        }else if ([login.source isEqualToString:@"3"]){
            self.isSetWeChatLb.text = @"未设置";
            self.isSetWeChatLb.textColor = [SVGloble colorWithHexString:@"#6FA4FF"];
            self.QQNumberLb.text = @"已绑定";
            self.wxNumberLb.text = @"未绑定";
              [self checkCustomer:@"1" issetLable:self.isSetQQLb];
        }
        
    }else{
        self.isSetQQLb.text = @"未设置";
        self.isSetWeChatLb.text = @"未设置";
        self.isSetQQLb.textColor = [SVGloble colorWithHexString:@"#6FA4FF"];
        self.isSetWeChatLb.textColor = [SVGloble colorWithHexString:@"#6FA4FF"];
        
    }
}


-(void)checkCustomer:(NSString * )type issetLable:(UILabel * )labl{
    NSMutableDictionary *checkDict = diction;
    checkDict[@"type"] = type;
    checkDict[@"openId"] = loginOpenId;
    checkDict[@"token"] = loginToken;
     LFLog(@"%@",checkDict);
    [YWRequestData checkCustomerServiceDict:checkDict success:^(id responseObj) {
     YWSetModel * setModel = [YWSetModel mj_objectWithKeyValues:responseObj[@"data"]];
        self.setModel = setModel;
        if ([setModel.bindStatus isEqualToString:@"1"]) {
             labl.text = @"未设置";
             labl.textColor = [SVGloble colorWithHexString:@"#6FA4FF"];
        }else if ([setModel.bindStatus isEqualToString:@"0"]){
            labl.text = @"已设置";
            labl.textColor = [SVGloble colorWithHexString:@"#484848"];
        }
    }];
    
}
- (IBAction)qqCustomerServiceTop:(id)sender {
    if ([login.source isEqualToString:@"2"]){
        
        [MBManager showBriefAlert:@"先绑定QQ"];return ;
    }
    NSMutableDictionary *checkDict = diction;
    checkDict[@"type"] = @"1";
    checkDict[@"openId"] = loginOpenId;
    checkDict[@"token"] = loginToken;
    [YWRequestData checkCustomerServiceDict:checkDict success:^(id responseObj) {
        YWSetModel * setModel = [YWSetModel mj_objectWithKeyValues:responseObj[@"data"]];
        self.setModel = setModel;
        if ([self.setModel.bindStatus isEqualToString:@"0"]) {//已经绑定
            YWUBindQQWXAlertView * uBindQQWXAlertView = [YWUBindQQWXAlertView loadNameUBindQQWXAlertViewXib];
            uBindQQWXAlertView.gk_size = CGSizeMake(LFscreenW-40, 220);
            WeakSelf(weakSelf)
            uBindQQWXAlertView.bindqqWx = ^{
                NSMutableDictionary *unBind =diction;
                if ([login.source isEqualToString:@"2"]) {
                  
                    unBind[@"type"] = @"2";
                }else if ([login.source isEqualToString:@"3"]){
                    unBind[@"type"] = @"1";
                }
                
                unBind[@"openId"] = loginOpenId;
                unBind[@"token"] = loginToken;
                [YWRequestData unBindQQWXDict:unBind success:^(id responseObj) {
                    [weakSelf checkQQWXisSet];
                    [self getUserBotInfo:@"1"];
                }];
            };
            [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:uBindQQWXAlertView style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleCenter showAnimStyle:GKCoverShowAnimStyleCenter hideAnimStyle:GKCoverHideAnimStyleNone notClick:NO showBlock:nil hideBlock:nil];
            
        }else if([self.setModel.bindStatus isEqualToString:@"1"]){//未绑定
            [self getUserBotInfo:@"1"];
        }
        
        
        
    }];
    
   
   

}
- (IBAction)wxCustomerServiceTop:(id)sender {
if ([login.source isEqualToString:@"3"]){
      
        [MBManager showBriefAlert:@"先绑定微信"];return ;
    }
    NSMutableDictionary *checkDict = diction;
    checkDict[@"type"] = @"2";
    checkDict[@"openId"] = loginOpenId;
    checkDict[@"token"] = loginToken;
      LFLog(@"%@",checkDict);
    [YWRequestData checkCustomerServiceDict:checkDict success:^(id responseObj) {
        YWSetModel * setModel = [YWSetModel mj_objectWithKeyValues:responseObj[@"data"]];
        self.setModel = setModel;
        
        if ([self.setModel.bindStatus isEqualToString:@"0"]) {//已经绑定
            WeakSelf(weakSelf)
            YWUBindQQWXAlertView * uBindQQWXAlertView = [YWUBindQQWXAlertView loadNameUBindQQWXAlertViewXib];
            uBindQQWXAlertView.gk_size = CGSizeMake(LFscreenW-40, 220);
            uBindQQWXAlertView.bindqqWx = ^{
                NSMutableDictionary *unBind =diction;
                if ([login.source isEqualToString:@"2"]) {
                    
                    unBind[@"type"] = @"2";
                    
                }else if ([login.source isEqualToString:@"3"]){
                    unBind[@"type"] = @"1";
                    
                }
                
                unBind[@"openId"] = loginOpenId;
                unBind[@"token"] = loginToken;
                [YWRequestData unBindQQWXDict:unBind success:^(id responseObj) {
                    [weakSelf checkQQWXisSet];
                    [self getUserBotInfo:@"2"];
                }];
            };
            [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:uBindQQWXAlertView style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleCenter showAnimStyle:GKCoverShowAnimStyleCenter hideAnimStyle:GKCoverHideAnimStyleNone notClick:NO showBlock:nil hideBlock:nil];
        }else if([self.setModel.bindStatus isEqualToString:@"1"]){//未绑定
            [self getUserBotInfo:@"2"];
        }
        
        
    }];
    
   
   
}
-(void) getUserBotInfo:(NSString * )type{
    [GKCover hide];
    NSMutableDictionary *checkDict =diction;
    checkDict[@"type"] = type;
    checkDict[@"openId"] = loginOpenId;
    checkDict[@"token"] = loginToken;
    [YWRequestData checkCustomerServiceDict:checkDict success:^(id responseObj) {
        YWSetModel * setModel = [YWSetModel mj_objectWithKeyValues:responseObj[@"data"]];
          self.bindCustomerServiceAlertView = [YWBindCustomerServiceAlertView loadNameBindCustomerServiceAlertViewXib];
        self.bindCustomerServiceAlertView .type = type;
        self.bindCustomerServiceAlertView .setModel = setModel;
        self.bindCustomerServiceAlertView.gk_size = CGSizeMake(LFscreenW-40, 350);
        [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:self.bindCustomerServiceAlertView style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleCenter showAnimStyle:GKCoverShowAnimStyleCenter hideAnimStyle:GKCoverHideAnimStyleNone notClick:NO showBlock:^{
            
        } hideBlock:^{
            NSMutableDictionary * verifynfoDict = diction;
            verifynfoDict[@"type"] = type;
            verifynfoDict[@"verify"] = setModel.verify;
            verifynfoDict[@"token"] = loginToken;
            verifynfoDict[@"openId"] = loginOpenId;
            BotInfoModel * botInfoModel = [setModel.botInfos firstObject];
            verifynfoDict[@"botId"] = botInfoModel.botId;
            LFLog(@"%@",verifynfoDict);
            [YWRequestData verifynfoDict:verifynfoDict success:^(id responseObj) {
                  [self checkQQWXisSet];
            }];
          
        }];
    }];
}
- (IBAction)outLoginBtClick:(id)sender {
//    jxt_showAlertTwoButton(@"常规两个按钮alert", @"支持按钮点击回调，支持C函数快速调用", @"cancel", ^(NSInteger buttonIndex) {
//        NSLog(@"cancel");
//    }, @"other", ^(NSInteger buttonIndex) {
//        NSLog(@"other");
//    });
    [self jxt_showAlertWithTitle:nil message:@"确定退出登录?" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
        alertMaker.
        addActionCancelTitle(@"取消").
        addActionDestructiveTitle(@"确定");
    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
        if (buttonIndex == 0) {
    
        }else if (buttonIndex == 1) {
            [self outLogin];
        }
    }];
    
}
- (IBAction)phoneNmuberTop:(id)sender {
}
- (IBAction)qqNmuberTop:(id)sender {
    [self getAuthWithUserInfoFromSina:UMSocialPlatformType_QQ];
}
- (IBAction)wxNmuberTop:(id)sender {
     [self getAuthWithUserInfoFromSina:UMSocialPlatformType_WechatSession];
}

- (void)getAuthWithUserInfoFromSina:(UMSocialPlatformType)PlatformType
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:PlatformType currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            NSLog(@"Sina gender: %@", error);
        } else {
            UMSocialUserInfoResponse *resp = result;
            [UMSocialGlobal shareInstance].isClearCacheWhenGetUserInfo = NO;
            // 授权信息
            NSLog(@"Sina uid: %@", resp.uid);
            NSLog(@"Sina accessToken: %@", resp.accessToken);
            NSLog(@"Sina refreshToken: %@", resp.refreshToken);
            NSLog(@"Sina expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"Sina name: %@", resp.name);
            NSLog(@"Sina iconurl: %@", resp.iconurl);
            NSLog(@"Sina gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            NSLog(@"Sina originalResponse: %@", resp.originalResponse);
            
            
            
            [self bingQQorWechat:resp];
        }
    }];
}

-(void)bingQQorWechat:(UMSocialUserInfoResponse *)resp{
         
   
    if (loginOpenId.length) {
         NSMutableDictionary *  unBindDit = diction;
        unBindDit[@"token"] = loginToken;
        [YWRequestData unBingQQorWechatNumberDict:unBindDit success:^(id responseObj) {//解绑微信或者QQ
            [self bingQQorWx:resp];
        }];
    }else{
        [self bingQQorWx:resp];
    }
    
}
-(void)bingQQorWx:(UMSocialUserInfoResponse *)resp{//b微信或者QQ
    NSMutableDictionary *  bingDit = diction;
    bingDit[@"uid"] =  resp.uid;
    if (resp.platformType == UMSocialPlatformType_WechatSession) {
        bingDit[@"source"] = @"2";//微信是2QQ是3
    }else if(resp.platformType == UMSocialPlatformType_QQ) {
        bingDit[@"source"] = @"3";//微信是2QQ是3
    }
    bingDit[@"pic"] = resp.iconurl;
    bingDit[@"token"] =loginToken;
    [YWRequestData bingQQorWechatDict:bingDit success:^(id responseObj) {
        SALoginModel* loginmodel = login;
        loginmodel.sUid =  resp.uid;
         loginmodel.source =  bingDit[@"source"];
        LFLog(@"%@",loginmodel.source);
        [LFAccountTool save:loginmodel];
        [MBManager showBriefAlert:@"绑定成功"];
        if (loginOpenId.length) {
            if ([login.source isEqualToString:@"2"]) {
                self.wxNumberLb.text = @"已绑定";
//                self.wxNumberLb.textColor = [SVGloble colorWithHexString:@"#6FA4FF"];
                self.QQNumberLb.text = @"未绑定";
//                self.QQNumberLb.textColor = [SVGloble colorWithHexString:@"#484848"];
            }else if ([login.source isEqualToString:@"3"]){
                self.QQNumberLb.text = @"已绑定";
                self.wxNumberLb.text = @"未绑定";
            }
        }
       
       
        
        NSMutableDictionary *unBind =diction;
        if ([login.source isEqualToString:@"2"]) {
            unBind[@"type"] = @"2";
        }else if ([login.source isEqualToString:@"3"]){
            unBind[@"type"] = @"1";
        }
        
        unBind[@"openId"] = loginOpenId;
        unBind[@"token"] = loginToken;
        [YWRequestData unBindQQWXDict:unBind success:^(id responseObj) {
             [self checkQQWXisSet];
         
        }];
         [self checkQQWXisSet];

    }];
}
-(void)outLogin{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    
    dict[@"token"] = loginToken;
    [MBManager showWaitingWithTitle:@"正在退出.."];
    
    [LFHttpTool post:USER_OUTLOGIN params:dict progress:^(id downloadProgress) {
        
    } success:^(id responseObj) {
        
        [MBManager hideAlert];
        
        if ([responseObj[@"status"]isEqual:@(0)]) {
              [MBManager showBriefAlert:@"退出成功"];
            
            NSString* filename = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"];
            
            NSFileManager *defaultManager = [NSFileManager defaultManager];
            if ([defaultManager isDeletableFileAtPath:filename]) {
                [defaultManager removeItemAtPath:filename error:nil];
            }
            
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            SATabBarController * tabBarvc = [[SATabBarController alloc] init];
            window.rootViewController = tabBarvc;

            
        }
    } failure:^(NSError *error) {
        [MBManager hideAlert];
        [MBManager showBriefAlert:@"网络不给力"];
    }];
    
    
}
@end
