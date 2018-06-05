//
//  SAModifyNicknameViewController.m
//  SkinAssistant
//
//  Created by 蔡路飞 on 2017/7/21.
//  Copyright © 2017年 LeGame. All rights reserved.
//

#import "SAModifyNicknameViewController.h"

@interface SAModifyNicknameViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nametextFile;
@property (weak, nonatomic) IBOutlet UIButton *commitBt;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lyout;

@end

@implementation SAModifyNicknameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"昵称";
    self.nametextFile.text = self.nickName;
    self.nametextFile.borderStyle = UITextBorderStyleNone;
    [self.commitBt addTarget:self action:@selector(commitBtClick) forControlEvents:UIControlEventTouchUpInside];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(codetextFiledEditChanged:)
                                                name:UITextFieldTextDidChangeNotification object:self.nametextFile];
    self.lyout.constant = kTopHeight;
}
-(void)commitBtClick{
    if (self.nametextFile.text.length<2) {
         [MBManager showBriefAlert:@"不能少于2个汉字"];
        return;
    }
    [self.view endEditing:YES];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"token"] = loginToken;
    dict[@"name"] =  self.nametextFile.text;
    [MBManager showWaitingWithTitle:@"请稍后.."];
    [LFHttpTool post:USER_NAME_MODIFY params:dict progress:^(id downloadProgress) {
    } success:^(id responseObj) {
        LFLog(@"%@",responseObj);
        if ([responseObj[@"status"] isEqual:@(0)]) {
              [MBManager showBriefAlert:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
//            self.refreshMePage();
        }else{
         [MBManager showBriefAlert:responseObj[@"message"]];
        }
        [MBManager hideAlert];
      
    } failure:^(NSError *error) {
        [MBManager hideAlert];
        [MBManager showBriefAlert:@"修改失败"];
    }];

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

-(void)codetextFiledEditChanged:(NSNotification *)obj{
    UITextField *textField = (UITextField *)obj.object;
    //    NSString *text = textField.text;
    //获取输入法
    NSString * toBeString = textField.text;
    NSString * lang = textField.textInputMode.primaryLanguage;
    
    //若果输入的中文
    if ([lang isEqualToString:@"zh-Hans"]) {
        
        UITextRange * selecteRange = [textField markedTextRange];
        if (!selecteRange &&toBeString.length>12) {
            textField.text = [toBeString substringToIndex:12];
            
        }
    }else if(toBeString.length>12){
        textField.text = [toBeString substringToIndex:12];
        
    }
    
}


@end
