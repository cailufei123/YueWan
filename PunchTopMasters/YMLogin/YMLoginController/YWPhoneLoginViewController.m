//
//  YWPhoneLoginViewController.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/3/16.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWPhoneLoginViewController.h"
#import "YWRegistViewController.h"
#import "YWForgetPrassWordViewController.h"
@interface YWPhoneLoginViewController ()<UITextFieldDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneTf;
@property (weak, nonatomic) IBOutlet UITextField *prassWordTf;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollow;
@property (weak, nonatomic) IBOutlet UIButton *registBt;

@end

@implementation YWPhoneLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.phoneTf.borderStyle= self.prassWordTf.borderStyle =UITextBorderStyleNone;
    self.scrollow.delegate = self;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapdd)];
    [self.scrollow addGestureRecognizer:tap];
      self.navigationItem.title = @"手机登陆";
    [self.registBt addTarget:self action:@selector(registBtClick) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)registBtClick{
    YWRegistViewController * registVc =[[YWRegistViewController alloc] init];
    [self.navigationController pushViewController:registVc animated:YES];
}
- (IBAction)loginBt:(id)sender {
    if (self.phoneTf.text.length<=0) {
        [MBManager showBriefAlert:@"手机号不能为空" ];
        return;
    }else if(self.prassWordTf.text.length<6){
        [MBManager showBriefAlert:@"密码不正确"];
        return;
    }
    NSMutableDictionary * dict = diction;
    dict[@"mobile"] = self.phoneTf.text;
    dict[@"password"] =[self.prassWordTf.text toMD5];
    [YWRequestData userLoginDict:dict success:^(id responseObj) {
        SALoginModel* loginmodel = [SALoginModel mj_objectWithKeyValues:responseObj[@"data"]];
        loginmodel.logPassWord =self.prassWordTf.text;
        loginmodel.mobile =  self.phoneTf.text;
        
        [LFAccountTool save:loginmodel];
        [MBManager hideAlert];
        EMError * error1 = [[EMClient sharedClient] loginWithUsername:huanchatId password:huanchatId];
        if (!error1) {
            NSLog(@"登录成功");
        }
         [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }];
    
 
}

- (IBAction)forgetBt:(id)sender {
    YWForgetPrassWordViewController * registVc =[[YWForgetPrassWordViewController alloc] init];
    [self.navigationController pushViewController:registVc animated:YES];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
    
}
-(void)tapdd{
     [self.view endEditing:YES];
    
}
@end
