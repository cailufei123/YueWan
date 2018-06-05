//
//  AppDelegate.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/3/9.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "AppDelegate.h"
#import <Hyphenate/Hyphenate.h>
#import "SATabBarController.h"
 #import "EaseUI.h"
#import "WRNavigationBar.h"
#import "IQKeyboardManager.h"
#import <UMShare/UMShare.h>
#import <UserNotifications/UserNotifications.h>
//#import <UMSocialCore/UMSocialCore.h>
#import <UMPush/UMessage.h>
#import <UMAnalytics/MobClickGameAnalytics.h>
#import "DataBase.h"
#import "KSGuaidViewManager.h"
@interface AppDelegate ()<EMClientDelegate,EMChatManagerDelegate, EMChatroomManagerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    KSGuaidManager.images = @[[UIImage imageNamed:@"1"],
                              [UIImage imageNamed:@"2"],
                              [UIImage imageNamed:@"2"],
                              [UIImage imageNamed:@"4"]];
    
    /*
     方式一:
     
     CGSize size = [UIScreen mainScreen].bounds.size;
     
     KSGuaidManager.dismissButtonImage = [UIImage imageNamed:@"hidden"];
     
     KSGuaidManager.dismissButtonCenter = CGPointMake(size.width / 2, size.height - 80);
     */
    
    //方式二:
    KSGuaidManager.shouldDismissWhenDragging = YES;
    
    [KSGuaidManager begin];
    
     LFLog(@"%@",loginUid);
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.backgroundColor = [UIColor whiteColor];
    SATabBarController * tabBarvc = [[SATabBarController alloc] init];
    self. window.rootViewController = tabBarvc;
     [self setNavBarAppearence];
    [self.window makeKeyAndVisible];
    
//    [[EaseSDKHelper shareHelper] hyphenateApplication:application
//                        didFinishLaunchingWithOptions:launchOptions
//                                               appkey:@"1199180309253044#yuewantest"
//                                         apnsCertName:@"datePlayKaifa"
//                                          otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];

    //AppKey:注册的AppKey，详细见下面注释。
    //apnsCertName:推送证书名（不需要加后缀），详细见下面注释。
    EMOptions *options = [EMOptions optionsWithAppkey:@"1199180309253044#yuewan-final"];
    options.apnsCertName = @"datePlayKaifa";
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    //SDK 中，如果发生自动登录，会有以下回调：
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
//    //注册
//    EMError *error = [[EMClient sharedClient] registerWithUsername:huanchatId password:huanchatId];
//    if (error==nil) {
//        NSLog(@"注册成功");
//    }
    EMError *error = [[EMClient sharedClient] logout:YES];
    if (!error) {
        NSLog(@"退出成功");
    }
    
    EMError * error1 = [[EMClient sharedClient] loginWithUsername:huanchatId password:huanchatId];
    if (!error1) {
        NSLog(@"登录成功");
    }
    LFLog(@"%ld",error1.code);
    EMError *error2 = [[EMClient sharedClient] loginWithUsername:huanchatId password:huanchatId];
    if (!error2)
    {
        [[EMClient sharedClient].options setIsAutoLogin:YES];
    }
    BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
    if (!isAutoLogin) {
         [[EMClient sharedClient] loginWithUsername:huanchatId password:huanchatId];
    }
    
  
   
  [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [self configUSharePlatforms];//分享登陆
        [self uMessageNotificatiodidFinishLaunchingWithOptions:launchOptions];//友盟推送
    
      [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    
  
    return YES;
}
- (void)configUSharePlatforms
{
     [[UMSocialManager defaultManager] setUmSocialAppkey:@"5b0780deb27b0a78c6000016"];
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx4811a06dcdcd581b" appSecret:@"389aca7ab30fc23e5ebc127c494ca6b6" redirectURL:@"http://mobile.umeng.com/social"];
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1106722445" appSecret:@"g6jxiREGYnXlZth6" redirectURL:@"http://mobile.umeng.com/social"];
}
#pragma mark-------------友盟推送--------
-(void)uMessageNotificatiodidFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Push组件基本功能配置
    UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
    //type是对推送的几个参数的选择，可以选择一个或者多个。默认是三个全部打开，即：声音，弹窗，角标
    entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionSound|UMessageAuthorizationOptionAlert;
    [UNUserNotificationCenter currentNotificationCenter].delegate=self;
    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity     completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
        }else{
        }
    }];

   
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // 1.2.7版本开始不需要用户再手动注册devicetoken，SDK会自动注册
    //[UMessage registerDeviceToken:deviceToken];
    NSString *devicToken = [[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                             stringByReplacingOccurrencesOfString: @">" withString: @""]
                            stringByReplacingOccurrencesOfString: @" " withString: @""];
    NSUserDefaults * userdevice = [NSUserDefaults standardUserDefaults];
    [userdevice setObject:devicToken forKey:userdevicToken];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"deviceId"] = devicToken;
    dict[@"token"] = loginToken;
    dict[@"type"] = @"1";
    LFLog(@"%@",devicToken);
    LFLog(@"%@",login.userId);
    [LFHttpTool post:PUSH_DEVICEID params:dict progress:^(id downloadProgress) {
        
    } success:^(id responseObj) {
    } failure:^(NSError *error) {
    }];
    
    
    
}
- (void)setNavBarAppearence
{
    //    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor purpleColor]}];
    //    [UINavigationBar appearance].tintColor = [UIColor yellowColor];
    //    [UINavigationBar appearance].barTintColor = [UIColor redColor];
    
  
    
    // 设置是 广泛使用WRNavigationBar，还是局部使用WRNavigationBar，目前默认是广泛使用
    [WRNavigationBar wr_widely];
    [WRNavigationBar wr_setBlacklist:@[@"SpecialController",
                                       @"TZPhotoPickerController",
                                       @"TZGifPhotoPreviewController",
                                       @"TZAlbumPickerController",
                                       @"TZPhotoPreviewController",
                                       @"TZVideoPlayerController"]];
    
    // 设置导航栏默认的背景颜色
    [WRNavigationBar wr_setDefaultNavBarBarTintColor:naverBagColor];
    // 设置导航栏所有按钮的默认颜色
    [WRNavigationBar wr_setDefaultNavBarTintColor:[UIColor whiteColor]];
    // 设置导航栏标题默认颜色
    [WRNavigationBar wr_setDefaultNavBarTitleColor:[UIColor whiteColor]];
    // 统一设置状态栏样式
    [WRNavigationBar wr_setDefaultStatusBarStyle:UIStatusBarStyleLightContent];
    // 如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
    [WRNavigationBar wr_setDefaultNavBarShadowImageHidden:YES];
}

/*!
 *  自动登录返回结果
 *
 *  @param error 错误信息
 */

- (void)autoLoginDidCompleteWithError:(EMError *)error{
    
    
}
/*!
 *  SDK连接服务器的状态变化时会接收到该回调
 *
 *  有以下几种情况，会引起该方法的调用：
 *  1. 登录成功后，手机无法上网时，会调用该回调
 *  2. 登录成功后，网络状态变化时，会调用该回调
 *
 *  @param aConnectionState 当前状态
 */
//- (void)connectionStateDidChange:(EMConnectionState)aConnectionState{
//
//
//}

/*!
 *  当前登录账号在其它设备登录时会接收到该回调
 */
- (void)userAccountDidLoginFromOtherDevice{
   
    
}

/*!
 *  当前登录账号已经被从服务器端删除时会收到该回调
 */
- (void)userAccountDidRemoveFromServer{
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
   [[EMClient sharedClient] applicationDidEnterBackground:application];
    
    [LFNSNOTI postNotificationName:enterBackgroundRoom object:nil];
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
   [[EMClient sharedClient] applicationWillEnterForeground:application];
     [LFNSNOTI postNotificationName:enterForegroundRoom object:nil];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)messagesDidReceive:(NSArray *)aMessages {
    
//    model.avatarImage = message.ext[@"userIcon"];
//    model.nickname =  message.ext[@"userName"];
    for (EMMessage *message in aMessages) {
        LFLog(@"%@",message.ext[@"userIcon"]);
        [USER_DEFAULT setObject:message.ext[@"userIcon"] forKey:message.conversationId];
        
     
    }
}
// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}





- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}



//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        
        //应用处于前台时的远程推送接受
        [UMessage setAutoAlert:NO];
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        LFLog(@"%@",userInfo);
        LFLog(@"%@",[userInfo[@"custom"] mj_JSONObject ]);
        
        SAMessageModel * messageModel = [SAMessageModel mj_objectWithKeyValues:[userInfo[@"custom"] mj_JSONObject ]];
        NSDate * data  =[NSDate date];
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSString *dateStr = [fmt stringFromDate:data];
        messageModel.timeStr = dateStr;
        messageModel.extra1 = @"0";
        [[DataBase sharedDataBase] addMessage:messageModel];
//        [[NSNotificationCenter defaultCenter] postNotificationName:pushRefresh object:nil];
    }else{
        
        //应用处于前台时的本地推送接受
    }
    //当应用处于前台时提示设置，需要哪个可以设置哪一个
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}

//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [UMessage setAutoAlert:NO];
        [UMessage didReceiveRemoteNotification:userInfo];
        
        //        [nvc pushViewController:orderListCtrl animated:YES];
        if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {//应用处于前台
            
            SATabBarController * tabar =  (SATabBarController * )self.window.rootViewController;
            tabar.selectedIndex = 2;
        }else{
            
            SAMessageModel * messageModel = [SAMessageModel mj_objectWithKeyValues:[userInfo[@"custom"] mj_JSONObject ]];
            
            NSArray * allarray = [[DataBase sharedDataBase] getAllMessage];
            for ( SAMessageModel * messageMode  in allarray) {
                if ([messageMode. skip_id isEqualToString:messageModel.skip_id]) {
                    return;
                }
            }
            NSDate * data  =[NSDate date];
            NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
            fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
            fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            NSString *dateStr = [fmt stringFromDate:data];
            messageModel.timeStr = dateStr;
            messageModel.extra1 = @"0";
            [[DataBase sharedDataBase] addMessage:messageModel];
//            [[NSNotificationCenter defaultCenter] postNotificationName:pushRefresh object:nil];
            SATabBarController * tabar =  (SATabBarController * )self.window.rootViewController;
            tabar.selectedIndex = 0;
        }
        
        
        
        
        
        
        
        
    }else{
        //应用处于后台时的本地推送接受
        
    }
   
}


@end
