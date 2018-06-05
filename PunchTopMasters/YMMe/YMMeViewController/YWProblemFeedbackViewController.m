//
//  YWProblemFeedbackViewController.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/5/11.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWProblemFeedbackViewController.h"
#import "TYLimitedTextView.h"
#import "UITextView+Placeholder.h"
@interface YWProblemFeedbackViewController ()<TYLimitedTextViewDelegate>
@property (weak, nonatomic) IBOutlet TYLimitedTextView *reportMessageTextView;

@property (weak, nonatomic) IBOutlet UITextField *phoneTf;
@property (weak, nonatomic) IBOutlet UIView *lastVIew;

@property (weak, nonatomic) IBOutlet UILabel *numberLb;
@end

@implementation YWProblemFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置允许输入的最大长度
    self.reportMessageTextView.maxLength = 200;
    self.reportMessageTextView. placeholderColor = [SVGloble colorWithHexString:@"#cccccc"];
    //    self.numberLb.text =
    //设置代理方法
    self.reportMessageTextView.realDelegate = self;
    
    //    self.reportMessageTextView.backgroundColor = [UIColor cyanColor];
    
    //设置placeholder
    self.reportMessageTextView.placeholder = @"感谢您的反馈，我们收到后尽快给予答复。";
//    [self addNoticeForKeyboard];
}



#pragma mark - TYLimitedTextViewDelegate
-(BOOL)limitedTextViewShouldReturn:(UITextView *)textView{
    NSLog(@"点击了return");
    return NO;
}

-(void)limitedTextViewDidChange:(UITextView *)textView{
    NSLog(@"文字改变了 -- %@",textView.text);
    self.numberLb.text = [NSString stringWithFormat:@"%zi/%zi字",self.reportMessageTextView.inputLength,self.reportMessageTextView.maxLength];
    
}

-(void)limitedTextViewDidEndEditing:(UITextView *)textView{
    NSLog(@"结束编辑 - text:%@",textView.text);
}

#pragma mark - TYLimitedTextFieldDelegate
-(BOOL)limitedTextFieldShouldReturn:(UITextField *)textField{
    NSLog(@"点击了return");
    return NO;
}

-(void)limitedTextFieldDidChange:(UITextField *)textField{
    NSLog(@"文字改变了 -- %@",textField.text);
}

-(void)limitedTextFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"结束编辑 - text:%@",textField.text);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
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
    CGFloat offset = self.lastVIew.clf_bottom  - (LFscreenH - kbHeight);
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //将视图上移计算好的偏移
    if(offset > 0) {
        [UIView animateWithDuration:duration animations:^{
            //            if ([self isEqual:notification.object]) {
            //                  self.clf_y = offset;
            //            }
            self.lastVIew.clf_bottom = LFscreenH - kbHeight;
            
        }];
    }
}

///键盘消失事件
- (void) keyboardWillHide:(NSNotification *)notify {
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        //
        //        if ([self isEqual:notify.object]) {
        //             self.clf_centerY = LFscreenH/2;
        //        }
        self.lastVIew.clf_centerY = LFscreenH/2;
    }];
}

- (IBAction)updataBtClick:(id)sender {
    if (!self.reportMessageTextView.text.length) {
         [MBManager showBriefAlert:@"反馈内容不能为空"];
        return;
    }
    if (!self.phoneTf.text.length) {
        [MBManager showBriefAlert:@"联系方式不能为空"];
        return;
    }
  
    NSMutableDictionary * dict = diction;
    dict[@"token"] = loginToken;
     dict[@"cont"] = self.reportMessageTextView.text;
     dict[@"contact"] = self.phoneTf.text;
     dict[@"version"] = @"1.0.0";
    LFLog(@"%@",dict);
    [YWRequestData faedBackDict:dict success:^(id responseObj) {
        [MBManager showBriefAlert:@"提交成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}


@end
