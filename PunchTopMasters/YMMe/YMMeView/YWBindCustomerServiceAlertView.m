//
//  YWBindCustomerServiceAlertView.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/20.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWBindCustomerServiceAlertView.h"
@interface YWBindCustomerServiceAlertView()
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *numberLb;
@property (weak, nonatomic) IBOutlet UILabel *codeLb;
@property (weak, nonatomic) IBOutlet UIButton *numberCopyBt;
@property (weak, nonatomic) IBOutlet UIButton *codeCopyBt;
- (IBAction)closeBtClick:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *nextbt;
@property (strong, nonatomic)  BotInfoModel * QQbotInfoModel;

@end
@implementation YWBindCustomerServiceAlertView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.numberCopyBt.layer.borderWidth = 0.5;
    self.codeCopyBt.layer.borderWidth = 0.5;
     self.numberCopyBt.layer.borderColor = [SVGloble colorWithHexString:@"#414754"].CGColor;
      self.codeCopyBt.layer.borderColor = [SVGloble colorWithHexString:@"#414754"].CGColor;
    [SVGloble gradientLayer:self.nextbt];
    [self.codeCopyBt addTarget:self action:@selector(codeCopyBtClick) forControlEvents:UIControlEventTouchUpInside];
    [self.numberCopyBt addTarget:self action:@selector(numberCopyBtClick) forControlEvents:UIControlEventTouchUpInside];
      [self.nextbt addTarget:self action:@selector(nextbtClick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)nextbtClick{
    [GKCover hideCover];
}
-(void)numberCopyBtClick{
    [MBManager showBriefAlert:@"复制成功"];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    LFLog(@"%@",self.QQbotInfoModel.botId);
     pasteboard.string =  self.QQbotInfoModel.botId;
    if ([self.type isEqualToString:@"1"]) {
          NSString *qqStr=[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",  self.QQbotInfoModel.botId];
        [self openApp:qqStr];
    }else if ([self.type isEqualToString:@"2"]) {
          [self openApp:[NSString stringWithFormat:@"weixin:/im/chat?chat_type=wpa&uin=%@&version=1&src_type=web", self.QQbotInfoModel.botId]];
//        [self openApp:@"weixin://"];
    }
    
}
-(void)codeCopyBtClick{
    [MBManager showBriefAlert:@"复制成功"];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
      pasteboard.string =  _setModel.verify;
    if ([self.type isEqualToString:@"1"]) {
      NSString *qqStr=[NSString stringWithFormat:@"mqq://"];
        [self openApp:qqStr];
    }else if ([self.type isEqualToString:@"2"]) {
         [self openApp:@"weixin://"];
    }
}

-(void)openApp:(NSString * )Str{
    NSURL *url = [NSURL URLWithString:Str];
    if( [[UIApplication sharedApplication]canOpenURL:url] ) {
        [[UIApplication sharedApplication]openURL:url options:@{}completionHandler:^(BOOL     success) {
        }];
}
}
+(instancetype)loadNameBindCustomerServiceAlertViewXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
-(void)setSetModel:(YWSetModel *)setModel{
    _setModel = setModel;
   
    if ([self.type isEqualToString:@"1"]) {
         BotInfoModel * botInfoModel = [setModel.botInfos firstObject];
        self.QQbotInfoModel = botInfoModel;
        self.titleLb.text = [NSString stringWithFormat:@"添加开黑%@助手",@"QQ"];
        self.numberLb.text = [NSString stringWithFormat:@"客服QQ号：%@",botInfoModel.botId];
        self.codeLb.text = [NSString stringWithFormat:@"验证码：%@",setModel.verify];
    }else if ([self.type isEqualToString:@"2"]) {
        BotInfoModel * botInfoModel = [setModel.botInfos firstObject];
                 self.QQbotInfoModel = botInfoModel;
                self.titleLb.text = [NSString stringWithFormat:@"添加开黑%@助手",@"微信"];
                self.numberLb.text = [NSString stringWithFormat:@"微信号：%@",botInfoModel.botId];
                self.codeLb.text = [NSString stringWithFormat:@"验证码：%@",setModel.verify];
        
    }
    
  
}
- (IBAction)closeBtClick:(UIButton *)sender {
    [GKCover hideCover];
}
@end
