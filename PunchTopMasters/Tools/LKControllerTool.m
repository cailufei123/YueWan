//
//  LKControllerTool.m
//  Likein
//
//  Created by 蔡路飞 on 16/7/10.
//  Copyright © 2016年 leshigames. All rights reserved.
//

#import "LKControllerTool.h"
#import "SATabBarController.h"
//#import "SALoginViewController.h"
//#import "MZGuidePages.h"
//#import "RESideMenu.h"
//#import "LKSettViewController.h"
#import "SANavigationController.h"
#import "AppDelegate.h"

@implementation LKControllerTool


+ (void)chooseRootViewController
{
    // 如何知道第一次使用这个版本？比较上次的使用情况:
    NSString *versionKey = (__bridge NSString *)kCFBundleVersionKey;
    
    // 从沙盒中取出上次存储的软件版本号(取出用户上次的使用记录)
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults objectForKey:versionKey];
    
    // 获得当前打开软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    
   
    
    //    1）如果版本相同，则直接跳转到主页面
    if ([currentVersion isEqualToString:lastVersion]) {
        
        [LKControllerTool rootController];
        //    2）版本不相同，有版本更新；显示版本新特性
    } else {
         [LKControllerTool rootController];
//        UIWindow *window = [UIApplication sharedApplication].keyWindow;
//        // 当前版本号 != 上次使用的版本：显示版本新特性
//        SALoginViewController * loginvc =  [[SALoginViewController alloc] init];
//        SANavigationController * nc = [[SANavigationController alloc] initWithRootViewController:loginvc];
//        window.rootViewController = nc;
////        [LKControllerTool guidePages];//去掉引导页  在改的时候打开
//        // 2.1存储这次使用的软件版本！！！
//        [defaults setObject:currentVersion forKey:versionKey];
//        [defaults synchronize];
    }
    
    
    
   
}
//+ (void)guidePages
//{
//     UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    
//    //数据源
//    NSArray *imageArray = @[ @"引导页1.jpg", @"引导页2.jpg", @"0引导页3.jpg"];
//    
//    //  初始化方法1
//    MZGuidePages *mzgpc = [[MZGuidePages alloc] init];
//    mzgpc.imageDatas = imageArray;
//    __weak typeof(MZGuidePages) *weakMZ = mzgpc;
//   
//    mzgpc.buttonAction = ^{
//       
//         [LKControllerTool rootController];
//       
//        [UIView animateWithDuration:0.0f
//                         animations:^{
//                             
//                             weakMZ.alpha = 0.0;
//                             
//                         }
//                         completion:^(BOOL finished) {
//                            
//                             [weakMZ removeFromSuperview];
//                            
//                            
//
//                             
//                         }];
//    };
//    
//    //  初始化方法2
//    //    MZGuidePagesController *mzgpc = [[MZGuidePagesController alloc]
//    //    initWithImageDatas:imageArray
//    //                                                                            completion:^{
//    //                                                                              NSLog(@"click!");
//    //
//    
//    //要在makeKeyAndVisible之后调用才有效
//    [window addSubview:mzgpc];
//}
+(void)rootController{

     UIWindow *window = [UIApplication sharedApplication].keyWindow;
    SATabBarController * tabBarvc = [[SATabBarController alloc] init];
       window.rootViewController = tabBarvc;
   
}
@end
