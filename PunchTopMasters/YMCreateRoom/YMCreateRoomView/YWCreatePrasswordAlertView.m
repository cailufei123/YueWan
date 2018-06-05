//
//  YWCreatePrasswordAlertView.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/28.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWCreatePrasswordAlertView.h"
#import "UITextView+Placeholder.h"
#import "TYLimitedTextField.h"
@interface YWCreatePrasswordAlertView()<TYLimitedTextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *texttfView;
@property (weak, nonatomic) IBOutlet TYLimitedTextField *passWordTf;
@end
@implementation YWCreatePrasswordAlertView
-(void)awakeFromNib{
    [super awakeFromNib];
    self.passWordTf.keyboardType  = UIKeyboardTypeNumberPad;
    //设置允许输入的最大长度
    self.passWordTf.maxLength = 4;
    self.passWordTf. placeholderColor = groBoderColor;
    //    self.numberLb.text =
    //设置代理方法
    self.passWordTf.realDelegate = self;
    self.texttfView.layer.borderColor = groBoderColor.CGColor;
     self.texttfView.layer.borderWidth = 0.5;
    //设置placeholder
    self.passWordTf.placeholder = @"请输入4位数字密码";
    [self addNoticeForKeyboard];
}
- (IBAction)closeBtClick:(id)sender {
    [GKCover hide];
}
- (IBAction)sureBtClick:(id)sender {
    if (self.passWordTf.text.length  != 4) {
        [MBManager showBriefAlert:@"输入四位数密码"];
        return;
    }
     [GKCover hide];
    self.surepassword(self.passWordTf.text);
}

+(instancetype)loadNameCreatePrasswordAlertViewXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
#pragma mark - TYLimitedTextViewDelegate
-(BOOL)limitedTextViewShouldReturn:(UITextView *)textView{
    NSLog(@"点击了return");
    return NO;
}

-(void)limitedTextViewDidChange:(UITextView *)textView{
    NSLog(@"文字改变了 -- %@",textView.text);
//    self.numberLb.text = [NSString stringWithFormat:@"%zi/%zi字",self.reportMessageTextView.inputLength,self.reportMessageTextView.maxLength];
    
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
    //    [self.view endEditing:YES];
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
    CGFloat offset = self.clf_bottom  - (LFscreenH - kbHeight);
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //将视图上移计算好的偏移
    if(offset > 0) {
        [UIView animateWithDuration:duration animations:^{
            //            if ([self isEqual:notification.object]) {
            //                  self.clf_y = offset;
            //            }
            self.clf_bottom = LFscreenH - kbHeight;
            
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
        self.clf_centerY = LFscreenH/2;
    }];
}

//-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    [self.view endEditing:YES];
//
//}
@end



