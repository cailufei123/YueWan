//
//  YWTXViewController.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/5/9.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWTXViewController.h"
#import "YWforwardAlertView.h"
#import "YWBUZUAlertView.h"
#import "YWTxRecordListViewController.h"
#import "KSGuaidViewManager.h"
@interface YWTXViewController ()<UITextFieldDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtf;
@property (weak, nonatomic) IBOutlet UIButton *allTxBt;
@property (weak, nonatomic) IBOutlet UITextField *nameTf;
@property (weak, nonatomic) IBOutlet UITextField *aliCountTf;
@property (weak, nonatomic) IBOutlet UIButton *goBt;
@property (weak, nonatomic) IBOutlet UIButton *txRecordBt;
@property (weak, nonatomic) IBOutlet UILabel *yeLb;
@property (strong, nonatomic) NSString * cion;
@property (strong, nonatomic) NSString  * cionfloat;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollow;
@property (weak, nonatomic) IBOutlet UIView *realNameView;
@property (weak, nonatomic) IBOutlet UIView *aliView;
@property (assign, nonatomic)CGFloat  yueInt;
@property (assign, nonatomic)CGFloat  enterYueInt;
@property (assign, nonatomic)BOOL  isEnter;
@end

@implementation YWTXViewController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [LFNSNOTI removeObserver:self];
}
-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldTextDidChangeOneCI:)
                                                name:UITextFieldTextDidChangeNotification
                                              object:self.txtf];
    self.isEnter = YES;
    [self updataUI];
    
    
}
-(void)updataUI{
    NSMutableDictionary * getCoinDict1 = diction;
    getCoinDict1[@"token"] = loginToken;
    [YWRequestData getCoinDict:getCoinDict1 success:^(id responseObj) {
        self.yeLb.text =  [NSString stringWithFormat:@"零钱余额%0.2lf元",[responseObj[@"data"][@"mobileCoin"] doubleValue]];
        self.cion =  [NSString stringWithFormat:@"%0.lf",[responseObj[@"data"][@"mobileCoin"] doubleValue]];
        //       self.cion = @"100";
        self.yueInt = [responseObj[@"data"][@"mobileCoin"] doubleValue];
        LFLog(@"%lf", self.yueInt);
        if (self.yueInt<=0) {
            self.yeLb.text = @"零钱余额0.00元";
            self. allTxBt.hidden = YES;
        }else if (self.yueInt>0&&self.yueInt<50){
            self.yeLb.text =  [NSString stringWithFormat:@"零钱余额%0.2lf元,满50元才可以提现",[responseObj[@"data"][@"mobileCoin"] doubleValue]];
            self. allTxBt.hidden = YES;
        }else if (self.yueInt>=50){
            self.yeLb.text =  [NSString stringWithFormat:@"零钱余额%0.2lf元",[responseObj[@"data"][@"mobileCoin"] doubleValue]];
            self. allTxBt.hidden = NO;
        }
        
        
    }];
}
-(void)textFieldTextDidChangeOneCI:(NSNotification *)notification
{
    
    
   
    self.isEnter = YES;
      UITextField *textfield=[notification object];
    
   

    if (textfield == self.txtf) {
        if (textfield.text.length) {
           
            self.enterYueInt = [textfield.text integerValue];
            self.yeLb.text =  [NSString stringWithFormat:@"额外扣除¥%0.2lf手续费（费率8%%）",[textfield.text doubleValue]*0.08];
            self. allTxBt.hidden = YES;
            if ([textfield.text doubleValue]<50) {
               self.yeLb.text =  [NSString stringWithFormat:@"零钱余额%0.2lf元,满50元才可以提现", self.yueInt];
//                self.yeLb.text =  [NSString stringWithFormat:@"零钱余额%0.2lf元", self.yueInt];
                self. allTxBt.hidden = NO;
            }
            if (self.yueInt<50) {
                 self.yeLb.text =  [NSString stringWithFormat:@"零钱余额%0.2lf元,满50元才可以提现", self.yueInt];
            }
        }else{
             [self updataUI];
            
        }
      
    }
  
    NSLog(@"ssssss %@",textfield.text);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.txtf.delegate = self;
      self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"提现说明" color:[UIColor whiteColor] highlightColor:[UIColor whiteColor] target:self action:@selector(usedrule)];
    self.navigationItem.title = @"提现";
    self.scrollow.delegate = self;
    [self.allTxBt addTarget:self action:@selector(allTxBtClick) forControlEvents:UIControlEventTouchUpInside];
      [self.goBt addTarget:self action:@selector(goBtClick) forControlEvents:UIControlEventTouchUpInside];
     [self.txRecordBt addTarget:self action:@selector(txRecordBtClick) forControlEvents:UIControlEventTouchUpInside];
    self.aliView.layer.borderColor = groBoderColor.CGColor;
    self.aliView.layer.borderWidth = 0.5;
    self.realNameView.layer.borderColor = groBoderColor.CGColor;
    self.realNameView.layer.borderWidth = 0.5;
    
}
-(void)usedrule{
    ATServiceAgreementController * serviceAgreementVc = [[ATServiceAgreementController alloc] init];
    serviceAgreementVc.htmlurl = WITHDRAW_DEPOSIT;
    serviceAgreementVc.htmltitle = @"提现说明";
    [self.navigationController pushViewController:serviceAgreementVc animated:YES];
    
}
-(void)txRecordBtClick{
    YWTxRecordListViewController * txRecordVc = [[YWTxRecordListViewController alloc] init];
    [self.navigationController pushViewController:txRecordVc animated:YES];
}
-(void)allTxBtClick{
      self.isEnter = NO;
    if ([self.cion doubleValue]<50) {
        [MBManager showBriefAlert:@"账户金额小于50不能提现"];
        return;
    }
    LFLog(@"%lf",[self.cion doubleValue]*0.92);
    
    self.txtf.text = [NSString stringWithFormat:@"%d",(int)([self.cion doubleValue]*0.92)];    ;
    self.yeLb.text =  [NSString stringWithFormat:@"额外扣除¥%0.2lf手续费（费率8%%）",([self.cion doubleValue]*0.08)];
    self. allTxBt.hidden = YES;
}
-(void)goBtClick{
    
   
    if (self.isEnter) {
        if ([self.txtf.text doubleValue]<50){
            [MBManager showBriefAlert:@"满50.00元才可以提现"];
            return;
        }
    }
   
    if ([self.cion doubleValue]<50) {
        [MBManager showBriefAlert:@"账户金额小于50不能提现"];
        return;
    }
    if (!self.txtf.text.length) {
        [MBManager showBriefAlert:@"输入提现金额"];
        return;
    }
    if (!self.aliCountTf.text.length) {
        [MBManager showBriefAlert:@"提现账号不能为空"];
        return;
    }
    if (!self.nameTf.text.length) {
        [MBManager showBriefAlert:@"用户名不能为空"];
        return;
    }
    LFLog(@"")
    if ([self.txtf.text integerValue]<=[ self.cion doubleValue]*0.92) {
        [self forwardAlertView];
    }else{
        
        WeakSelf(weakSelf)
        YWBUZUAlertView * aaRoomMasterAlertView = [YWBUZUAlertView loadNameBUZUAlertViewXib];
        aaRoomMasterAlertView.messageLb.text = [NSString stringWithFormat:@"剩余零钱不足以支付提现手续费¥%0.lf，当前最大可提现金额为¥%d",[self.txtf.text doubleValue]*0.08,(int)([self.cion doubleValue]*0.92)];
        
        
        aaRoomMasterAlertView.upDatamessage = ^{
            [weakSelf allTxBtClick];
            [GKCover hide];
            [weakSelf forwardAlertView];
            
        };
        
        aaRoomMasterAlertView.clf_size = CGSizeMake(LFscreenW-40, 260);
        [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:aaRoomMasterAlertView style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleCenter showAnimStyle:GKCoverShowAnimStyleNone hideAnimStyle:GKCoverHideAnimStyleNone notClick:YES showBlock:nil hideBlock:nil];
    }
    
    
  
}
-(void)forwardAlertView{
  
    YWforwardAlertView * aaRoomMasterAlertView = [YWforwardAlertView loadNameForwardAlertViewXib];
    aaRoomMasterAlertView.messageLb.text =  [NSString stringWithFormat:@"%0.ld",[self.txtf.text integerValue]];
      aaRoomMasterAlertView.subMessageLb.text = [NSString stringWithFormat:@"额外扣除¥%0.2lf手续费",[self.txtf.text doubleValue]*0.08];
    
    self.cionfloat =  [NSString stringWithFormat:@"%0.lf",[self.txtf.text doubleValue]];
    
    
//    if ([self.txtf.text doubleValue] > self.yueInt*0.92 &&[self.txtf.text doubleValue]< self.yueInt) {
//        aaRoomMasterAlertView.messageLb.text =   [NSString stringWithFormat:@"%d",(int)([self.txtf.text doubleValue]*0.92)];
//        aaRoomMasterAlertView.subMessageLb.text = [NSString stringWithFormat:@"额外扣除¥%0.2lf手续费",[self.txtf.text doubleValue]*0.08];
//    }
    aaRoomMasterAlertView.upDatamessage = ^{
        
        LFLog(@"%@",self.cionfloat );
        NSMutableDictionary * userTxDict = [NSMutableDictionary dictionary];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *fileName = [NSString stringWithFormat:@"%@%@",[formatter stringFromDate:[NSDate date]],login.mobile];
//        userTxDict[@"token"] = @"1111AAAABBBB2222";
        userTxDict[@"token"] = loginToken;
        userTxDict[@"orderId"] = fileName;
         userTxDict[@"realFee"] =  [NSString stringWithFormat:@"%0.lf",[self.cionfloat doubleValue]*0.08 +  [self.cionfloat doubleValue]] ;
        userTxDict[@"totalFee"] =  self.cionfloat;
         userTxDict[@"serviceFee"] =  [NSString stringWithFormat:@"%0.lf",[self.txtf.text doubleValue]*0.08];
        userTxDict[@"aliAcount"] = self.aliCountTf.text;
        userTxDict[@"payee_real_name"] =  self.nameTf.text;
        userTxDict[@"remark"] = @"提现";
        userTxDict[@"payer_show_name"] = @"truong";
        
//        userTxDict[@"token"] = @"1111AAAABBBB2222";
//        userTxDict[@"orderId"] = @"yyyyyaaaa1111";
//        userTxDict[@"realFee"] = @"50";
//        userTxDict[@"totalFee"] =  @"46";
//        userTxDict[@"serviceFee"] = @"4";
//        userTxDict[@"aliAcount"] = @"123777788";
//        userTxDict[@"payee_real_name"] =  @"truong";
//        userTxDict[@"remark"] = @"提现";
//        userTxDict[@"payer_show_name"] = @"truong";
//        
      
        LFLog(@"%@",userTxDict);
        
        [YWRequestData userTxDict:userTxDict success:^(id responseObj) {
            [MBManager showBriefAlert:@"提现申请已提交，等待审核"];
            NSMutableDictionary * getCoinDict1 = diction;
            getCoinDict1[@"token"] = loginToken;
            [GKCover hide];
            [YWRequestData getCoinDict:getCoinDict1 success:^(id responseObj) {
                self.yeLb.text =  [NSString stringWithFormat:@"零钱余额%0.2lf元",[responseObj[@"data"][@"mobileCoin"] doubleValue]];
                self.cion =  [NSString stringWithFormat:@"%0.lf",[responseObj[@"data"][@"mobileCoin"] doubleValue]];
                //       self.cion = @"100";
            }];
        }];
        
    };
    
    aaRoomMasterAlertView.clf_size = CGSizeMake(LFscreenW-40, 260);
    [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:aaRoomMasterAlertView style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleCenter showAnimStyle:GKCoverShowAnimStyleNone hideAnimStyle:GKCoverHideAnimStyleNone notClick:YES showBlock:nil hideBlock:nil];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [self validateNumber:string];
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self.view endEditing:YES];
}

@end
