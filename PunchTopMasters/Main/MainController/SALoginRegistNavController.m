//
//  LKLoginRegistNavController.m
//  Likein
//
//  Created by 蔡路飞 on 16/7/11.
//  Copyright © 2016年 leshigames. All rights reserved.
//

#import "SALoginRegistNavController.h"

@interface SALoginRegistNavController ()<UIGestureRecognizerDelegate>

@end

@implementation SALoginRegistNavController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.interactivePopGestureRecognizer.delegate = self;
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    normalAttrs[NSForegroundColorAttributeName] = naverTextColor;
//    self.navigationBar.translucent = NO;
    self.navigationBar.barTintColor = naverBagColor;
    self.navigationBar.titleTextAttributes = normalAttrs;
   
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
        // self.automaticallyAdjustsScrollViewInsets=NO; 不要自动调整内边距
        
        UIButton * backItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [backItem setImage:[UIImage imageNamed:@"btn_back_titlebar"] forState:UIControlStateNormal];
        [backItem setImage:[UIImage imageNamed:@"btn_back_titlebar"] forState:UIControlStateHighlighted];
        
        [backItem setTitle:@"" forState:UIControlStateNormal];
        [backItem setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        backItem.titleLabel.font = [UIFont systemFontOfSize:15];

        backItem.size = CGSizeMake(40, 40);
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backItem];
       backItem.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
        [backItem addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.hidesBottomBarWhenPushed = YES;
        

     [super pushViewController:viewController animated:animated];
  
    
}
-(UIViewController *)popViewControllerAnimated:(BOOL)animated{
    
    return  [super popViewControllerAnimated:animated];
}
-(void)back{
    if (self.childViewControllers.count>1){
        [self popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
   
}
//手势识别器会调用这个代理方法YES 有效  NO没有效果
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    //    if (self.childViewControllers.count==1) {
    //         return NO;
    //    }
    //    return YES;
    return self.childViewControllers.count>1;
}

//-(UIStatusBarStyle)preferredStatusBarStyle{
//    
//    return UIStatusBarStyleDefault;
//}
//



@end
