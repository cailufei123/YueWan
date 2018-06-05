//
//  YWBindingPhoneViewController.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/3/19.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWBindingPhoneViewController.h"
#define timeCount 60    
@interface YWBindingPhoneViewController ()<UITextFieldDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneTf;
@property (weak, nonatomic) IBOutlet UITextField *codeTf;



@property (weak, nonatomic) IBOutlet UIButton *getCodeBt;

@property(nonatomic,strong)NSTimer * timer;
@property(nonatomic,assign)NSInteger count;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;



@end

@implementation YWBindingPhoneViewController



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
    self.codeTf.borderStyle = self.phoneTf.borderStyle = UITextBorderStyleNone;
    self.codeTf.delegate =   self.phoneTf.delegate =  self;
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
- (IBAction)completeBtClick:(id)sender {//点击完成的按钮
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
    
}
-(void)dealloc{
    [self.timer invalidate];
}
@end


