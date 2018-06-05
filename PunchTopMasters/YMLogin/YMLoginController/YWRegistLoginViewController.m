//
//  YWRegistLoginViewController.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/3/15.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWRegistLoginViewController.h"
#import "YWRegistViewController.h"
#import "YWPhoneLoginViewController.h"
@interface YWRegistLoginViewController ()
- (IBAction)registbt:(UIButton *)sender;

- (IBAction)qqLoginBt:(UIButton *)sender;
@end

@implementation YWRegistLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册领取礼包";
}




- (IBAction)registbt:(UIButton *)sender {//注册
    YWRegistViewController * registVc = [[YWRegistViewController alloc] init];
    [self.navigationController pushViewController:registVc animated:YES];
}

- (IBAction)qqLoginBt:(UIButton *)sender {//QQ登录
    
}
- (IBAction)wetLoginBt:(UIButton *)sender {//微信登录
    
}
- (IBAction)phoneLoginBt:(UIButton *)sender {//手机登录
    YWPhoneLoginViewController * phoneLoginVc = [[YWPhoneLoginViewController alloc] init];
    [self.navigationController pushViewController:phoneLoginVc animated:YES];
}
@end
