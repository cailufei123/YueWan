//
//  YWForgetPrassWordViewController.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/3/19.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWForgetPrassWordViewController.h"
#define timeCount 60
@interface YWForgetPrassWordViewController ()<UITextFieldDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneTf;
@property (weak, nonatomic) IBOutlet UITextField *codeTf;

@property (weak, nonatomic) IBOutlet UITextField *passWordTf;

@property (weak, nonatomic) IBOutlet UIButton *getCodeBt;

@property(nonatomic,strong)NSTimer * timer;
@property(nonatomic,assign)NSInteger count;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation YWForgetPrassWordViewController

//按下return keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"手机注册";
    self.scrollView.delegate = self;
    self.codeTf.borderStyle = self.passWordTf.borderStyle = self.phoneTf.borderStyle = UITextBorderStyleNone;
      self.codeTf.delegate =  self.passWordTf.delegate =  self.phoneTf.delegate =  self;
    self.count = timeCount;
    [self.getCodeBt addTarget:self action:@selector(getCodeBtCilck) forControlEvents:UIControlEventTouchUpInside];
    WeakSelf(weakSelf)
    self.timer = [NSTimer wh_scheduledTimerWithTimeInterval:1 repeats:YES callback:^(NSTimer *timer) {
        [weakSelf timerFireMethod];
    }];
    [self.timer pauseTimer];
    [self addNoticeForKeyboard];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapdd)];
    [self.scrollView addGestureRecognizer:tap];
   
}
-(void)tapdd{
    [self.view endEditing:YES];
    
}
#pragma mark - 键盘通知
- (void)addNoticeForKeyboard {
    
    //注册键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    //注册键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

///键盘显示事件
- (void) keyboardWillShow:(NSNotification *)notification {
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    //计算出键盘顶端到inputTextView panel底端的距离(加上自定义的缓冲距离INTERVAL_KEYBOARD)
    CGFloat offset = self.bottomView.clf_bottom  - (self.view.frame.size.height - kbHeight);
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //将视图上移计算好的偏移
    if(offset > 0) {
        [UIView animateWithDuration:duration animations:^{
            [self.scrollView setContentOffset:CGPointMake(0, offset)];
        }];
    }
}

///键盘消失事件
- (void) keyboardWillHide:(NSNotification *)notify {
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        [self.scrollView setContentOffset:CGPointMake(0, 0)];
    }];
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
    
}
- (IBAction)registBt:(UIButton *)sender {//点击注册
    
}
-(void)agreementClick{//点击协议
    
    
}
-(void)timerFireMethod{
    if (self.count<=0){
        self.getCodeBt.userInteractionEnabled = YES;
        self.getCodeBt.selected = NO;
        [self.getCodeBt setTitle:@"发送验证码" forState:UIControlStateNormal];
        [self.timer pauseTimer];
    }else{
        self.getCodeBt.selected = YES;
        self.getCodeBt.userInteractionEnabled = NO;
        [self.getCodeBt setTitle:[NSString stringWithFormat:@"(%02ld秒)可重发", self.count-- ] forState:UIControlStateNormal];
    }
    
    
}
-(void)getCodeBtCilck{
    self.count = timeCount;
     [self.timer resumeTimer];
    if (self.phoneTf.text.length<11) {
        [MBManager showBriefAlert:@"输入11位数手机号" ];
        return;
    }
    BOOL  strBool=  [self.phoneTf.text isMobileNumberClassification];
    if (!strBool) {
        [MBManager showBriefAlert:@"请输入正确的电话号码"];
        return;
    }
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"mobile"] = self.phoneTf.text;
    [LFHttpTool post:FORGET_GET_VCODE params:dic progress:^(id downloadProgress) {
        
    } success:^(id responseObj) {
        [MBManager hideAlert];
        LFLog(@"%@",responseObj);
        if ([responseObj[@"status"]isEqual:@(0)]) {
          
            [MBManager showBriefAlert:@"验证码已发送"];
            
        }else{
            [MBManager showBriefAlert:responseObj[@"message"]];
        }
        
    } failure:^(NSError *error) {
        [MBManager hideAlert];
    }];
    
   
    
}

- (IBAction)completeBtClick:(id)sender {//点击完成按钮
    if (self.phoneTf.text.length<=0) {
        [MBManager showBriefAlert:@"手机号不能为空" ];
        return;
    }else if(self.codeTf.text.length<=0){
        [MBManager showBriefAlert:@"验证码不能为空"];
        return;
    }else if(self.passWordTf.text.length<6){
        [MBManager showBriefAlert:@"密码不能少于6位"];
        return;
    }
    [self.view endEditing:YES];
    [MBManager showWaitingWithTitle:@"请稍后.."];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"mobile"] = self.phoneTf.text;
    dict[@"smsCode"] = self.codeTf.text;
    dict[@"password"] =[self.passWordTf.text toMD5];
    
    
    [LFHttpTool post:FORGET_RESET params:dict progress:^(id downloadProgress) {
        
    } success:^(id responseObj) {
        [MBManager hideAlert];
        NSString *message = nil;
        if ([responseObj[@"status"]isEqual:@(0)]) {
            SALoginModel* loginmodel = [SALoginModel mj_objectWithKeyValues:responseObj[@"data"]];
            loginmodel.logPassWord =self.passWordTf.text;
            loginmodel.mobile =self.phoneTf.text;
            [LFAccountTool save:loginmodel];
            [MBManager showBriefAlert:@"修改成功"];
            [self logingBtClick ];
            
        }else{
            [MBManager showBriefAlert:responseObj[@"message"]];
        }
        
        if (![responseObj[@"status"]isEqual:@(0)]) {
            [MBManager showBriefAlert:message];
        }
        
    } failure:^(NSError *error) {
        [MBManager showBriefAlert:@"登录失败"];
    }];
    
}

- (void)logingBtClick {
    
    if (self.phoneTf.text.length<=0) {
        [MBManager showBriefAlert:@"手机号不能为空" ];
        return;
    }else if(self.passWordTf.text.length<6){
        [MBManager showBriefAlert:@"密码不正确"];
        return;
    }
    NSMutableDictionary * dict = diction;
    dict[@"mobile"] = self.phoneTf.text;
    dict[@"password"] =[self.passWordTf.text toMD5];
    [YWRequestData userLoginDict:dict success:^(id responseObj) {
        SALoginModel* loginmodel = [SALoginModel mj_objectWithKeyValues:responseObj[@"data"]];
        loginmodel.logPassWord =self.passWordTf.text;
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
-(void)dealloc{
    [self.timer invalidate];
}
@end

