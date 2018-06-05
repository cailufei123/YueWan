//
//  SATabBarController.m
//  SkinAssistant
//
//  Created by 蔡路飞 on 2017/6/7.
//  Copyright © 2017年 LeGame. All rights reserved.
//

#import "SATabBarController.h"
#import "SANavigationController.h"
#import "SATabBar.h"
#import "YMRoomViewController.h"
#import "YWPublishViewController.h"
#import "YWMeViewController.h"
#import "YMCreateRoomController.h"
#import "YWHomeViewController.h"
//#import "YWRegistLoginViewController.h"loginAction
#import "YWPhoneLoginViewController.h"




@interface SATabBarController ()<UITabBarControllerDelegate,tabBaruDelegate>
@property (nonatomic, assign)NSInteger oldSelectIndex; 

@end

@implementation SATabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**** 设置所有UITabBarItem的文字属性 ****/
    [self setupItemTitleTextAttributes];
    /**** 添加子控制器 ****/
    [self setupChildViewControllers];
    [self setupTabBar];
//     [self computeReddot];
    self.delegate = self;
//    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO);
//    ([UIScreeninstancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
}
-(void)viewWillAppear:(BOOL)animated{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(longinseccous) name:@"longinseccous" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(immediatelyWish) name:skipHomeNotice object:nil];
//    [LFNSNOTI addObserver:self selector:@selector(classifClick) name:skipClassif object:nil];
//////    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushmessageClick) name:@"pushmessage" object:nil];
//   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getmessageBageVlu) name:pushRefresh object:nil];
////
   }
-(void)classifClick{
  self.selectedIndex = 1;
    
}
-(void)immediatelyWish{
 self.selectedIndex = 0;

}
-(void)pushmessageClick{
//    self.selectedIndex = 0;
//    SAMessageViewController *messageVc = [[SAMessageViewController alloc] init];
//    [self .navigationController pushViewController:messageVc animated:YES];
//    
}

-(void)viewWillDisappear:(BOOL)animated{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];

}
-(void)getmessageBageVlu{
//    [self computeReddot];
}
//-(void)computeReddot{
//    NSMutableArray * datas1 = [[DataBase sharedDataBase] lookUpWith:@"0"];
//
//    if (datas1.count>0) {
//         self. ntrol.navigationController.tabBarItem.badgeValue = [NSString stringWithFormat: @"%ld",datas1.count];
//
//    }else {
//        self. ntrol.navigationController.tabBarItem.badgeValue = nil;
//
//    }
//
//
//}
-(void)setupItemTitleTextAttributes{
    UITabBarItem * item =[UITabBarItem  appearance];
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    normalAttrs[NSForegroundColorAttributeName] = [SVGloble colorWithHexString:@"#444444"];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [SVGloble colorWithHexString:@"#474747"];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
}
-(void)setupChildViewControllers{
    [self setupOneChildViewController:[[SANavigationController alloc] initWithRootViewController:[[YWHomeViewController alloc] init]]  title:@"房间" image:@"tabar_select_home" selectedImage:@"tabar_home"];
     [self setupOneChildViewController:[[SANavigationController alloc] initWithRootViewController:[[YWPublishViewController alloc] init]]  title:@"" image:@"tabar-home-select" selectedImage:@"tabar-home-default"];
     YWMeViewController * ntrol = [[YWMeViewController alloc] init];
       [self setupOneChildViewController:[[SANavigationController alloc] initWithRootViewController:ntrol]  title:@"我的" image:@"tabar_select_me" selectedImage:@"tabar_me"];
   
      ntrol.navigationController.tabBarItem.badgeValue = nil;
    }
-(void)setupOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString*)image selectedImage:(NSString *)selectedImage{
    
    vc.tabBarItem.title = title;
    if (image.length) { // 图片名有具体值
        vc.tabBarItem.image = [UIImage imageNamed:image];
        vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    }
    [self addChildViewController:vc];
    
    
}
-(void)setupTabBar{
    SATabBar * tabBar =  [[SATabBar alloc] init];
    tabBar.tabBarDelegate = self;
    [self setValue:tabBar forKey:@"tabBar"];
    
}
-(void)selectedItemButton:(NSInteger)index{
    if (!loginTokenlength) {
        [ATSKIPTOOl loginAction:self];return;
    }
//    self.selectedIndex = index;
    YMCreateRoomController * registLoinViewController = [[YMCreateRoomController alloc] init];
    SALoginRegistNavController * loginRegistNavController = [[SALoginRegistNavController alloc] initWithRootViewController:registLoinViewController];
 
    [self presentViewController:loginRegistNavController animated:YES completion:nil];
    
}
//- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
//{ SALoginViewController * registVc = [[SALoginViewController alloc] init];
//    
//    SALoginRegistNavController *naVc = [[SALoginRegistNavController alloc] initWithRootViewController:registVc];
//   
//    
//    [self presentViewController:naVc animated:YES completion:nil];
//
//}

-(BOOL)tabBarController:(UITabBarController*)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    
    self.oldSelectIndex = tabBarController.selectedIndex;
    // 记录之前选择的selectedIndex
    return YES;
}

-(void)tabBarController:(UITabBarController*)tabBarController didSelectViewController:(UIViewController*)viewController
{
    if (tabBarController.selectedIndex == 4) {
//        if (!loginTokenlength) {
//            tabBarController.selectedIndex = self.oldSelectIndex;
//             [ATSKIPTOOl loginAction:self];return;
//        }
    }else if (tabBarController.selectedIndex == 2){
        if (!loginTokenlength) {
            tabBarController.selectedIndex = self.oldSelectIndex;
             [ATSKIPTOOl loginAction:self];return;
        }
    }else if (tabBarController.selectedIndex == 3){
//        if (!loginTokenlength) {
//            tabBarController.selectedIndex = self.oldSelectIndex;
//            [ATSKIPTOOl loginAction:self];return;
//        }
        tabBarController.selectedIndex = self.oldSelectIndex;
        [ATSKIPTOOl loginAction:self];return;
        
    }
}
-(void)longinseccous{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         self.selectedIndex = 3;
    });
   
}

@end
