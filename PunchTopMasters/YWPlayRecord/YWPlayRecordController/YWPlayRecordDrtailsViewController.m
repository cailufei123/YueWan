//
//  YWPlayRecordDrtailsViewController.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/5/4.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWPlayRecordDrtailsViewController.h"
#import "YWPlayRecordDateilsModel.h"
#import "YWPlayUsersView.h"
@interface YWPlayRecordDrtailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *gameStatusLb;
@property (weak, nonatomic) IBOutlet UILabel *gameDsLb;
@property (weak, nonatomic) IBOutlet UIView *topBgView;
@property (weak, nonatomic) IBOutlet UIButton *arrowBt;
@property (weak, nonatomic) IBOutlet UIImageView *userMasterIcon;
@property (weak, nonatomic) IBOutlet UILabel *userMasterNameLb;
@property (weak, nonatomic) IBOutlet UILabel *moneyLb;

@property (weak, nonatomic) IBOutlet UILabel *gameTypeLb;
@property (weak, nonatomic) IBOutlet UILabel *roomTypeLb;
@property (weak, nonatomic) IBOutlet UILabel *roomMoneyLb;
@property (weak, nonatomic) IBOutlet UILabel *couponLb;
@property (weak, nonatomic) IBOutlet UILabel *couponTypeLb;
@property (weak, nonatomic) IBOutlet UILabel *allPriceLb;
@property (weak, nonatomic) IBOutlet UILabel *outTroLb;
@property (weak, nonatomic) IBOutlet UIButton *fuzhiBt;
@property (weak, nonatomic) IBOutlet UILabel *orderTimeLb;
@property (weak, nonatomic) IBOutlet UILabel *payTypeLb;
@property (weak, nonatomic) IBOutlet UIView *listBgView;
@property (weak, nonatomic) IBOutlet UIView *bigBgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bigBgViewLyout;
@property(nonatomic,strong) YWPlayRecordDateilsModel * playRecordDateilsModel;
@property(nonatomic,strong) NSMutableArray  * otherArr;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *orderViewLyout;
@property (weak, nonatomic) IBOutlet UIView *orderView;
@property(nonatomic,strong) YWPvosModel  * meModel;

@property (weak, nonatomic) IBOutlet UIImageView *sanjiaoImg;
@property (copy, nonatomic)  NSString * gameArea;
@property (copy, nonatomic)  NSString * roomMode;
@property (copy, nonatomic)  NSString * roomType;
@property (weak, nonatomic) IBOutlet UIView *couponView;
@property (weak, nonatomic) IBOutlet UIView *tatolVIew;
@property (weak, nonatomic) IBOutlet UILabel *fnagjianewiLb;
@property (weak, nonatomic) IBOutlet UIButton *agenbt;
@end

@implementation YWPlayRecordDrtailsViewController
-(NSMutableArray *)otherArr{
    if (!_otherArr) {
        _otherArr = [NSMutableArray array];
    }
    return _otherArr;
}
- (void)viewDidLoad {
    [self.otherArr removeAllObjects];
    [super viewDidLoad];
    self.navigationItem.title =@"开黑记录";
//    [self gradientFremeww:self.topBgView.bounds startColor:[SVGloble colorWithHexString:@"#CE5441"] endColor:[SVGloble colorWithHexString:@"#EC776D"] ];
//    [SVGloble gradientLayer:self.topBgView];
    NSMutableDictionary * dict =diction;
    dict[@"token"] = loginToken;
      dict[@"userGameFlowId"] = self.userGameFlowId;
    [YWRequestData playRecordDetailstDict:dict success:^(id responseObj) {
        self.playRecordDateilsModel = [YWPlayRecordDateilsModel mj_objectWithKeyValues:responseObj[@"data"]];
        for ( YWPvosModel  * otherModel in self.playRecordDateilsModel.vos) {
            if ([otherModel.userType isEqualToString:@"1"]) {
                self. meModel = otherModel;
            }else{
                  [self.otherArr addObject:otherModel];
            }
           
        }
        if (self.otherArr .count>0) {
            int max_number = 0;          //最大值
            int max_index = 0;           //最大值的下标
            
            int min_number = INFINITY;   //最小值
            int min_index = 0;           //最小值下标
            for (int i=0; i<self.otherArr.count; i++)
            {
                //取最大值和最大值的对应下标
                YWPvosModel  * otherModel = self.otherArr[i];
                int a = [otherModel.winMoney intValue];
                if (a>max_number)
                {
                    max_index=i;
                }
                max_number = a>max_number?a:max_number;
                
                //取最小值和最小值对应的下标
                YWPvosModel  * otherModelb = self.otherArr[i];
                int b = [otherModelb.winMoney intValue];
                if (b<min_number)
                {
                    min_index = i;
                }
                min_number = b>min_number?min_number:b;
                
                
            }
            YWPvosModel  * maxotherModel = self.otherArr[max_index];
            maxotherModel.shouqi = @"1";
        }
       
        [self updataUI ];
    }];
    
    [self.arrowBt addTarget:self action:@selector(arrowBtClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.fuzhiBt layercornerRadius:11];
    self.fuzhiBt.layer.borderColor = [SVGloble colorWithHexString:@"#999999"].CGColor;
      self.fuzhiBt.layer.borderWidth =0.5;
    [self.fuzhiBt addTarget:self action:@selector(fuzhiBtClick) forControlEvents:UIControlEventTouchUpInside];
     [self.agenbt addTarget:self action:@selector(agenbtClick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)agenbtClick{
  
    [LFNSNOTI postNotificationName:skipHomeNotice object:nil];
      [self.navigationController popToRootViewControllerAnimated:YES];
    
}
-(void)fuzhiBtClick{
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = self.playRecordDateilsModel.order.outTradeNo;
    [MBManager showBriefAlert:@"复制成功"];
}
-(void)arrowBtClick:(UIButton * )bt{
    if ( bt.selected) {
        bt.selected = NO;
        self.sanjiaoImg.hidden = NO;
        self.bigBgViewLyout.constant = 169 +  self.otherArr.count * 60;
        self.bigBgView.hidden = NO;
    }else{
        self.sanjiaoImg.hidden = YES;
        bt.selected = YES;
        self.bigBgViewLyout.constant =0;
        self.bigBgView.hidden = YES;
    }
    
}
-(void)showView{
    self.couponView.hidden = NO;
    self.tatolVIew.hidden = NO;
}
-(void)hideView{
    self.couponView.hidden = YES;
    self.tatolVIew.hidden = YES;
}
-(void)updataUI{
    self.agenbt.hidden = YES;
    self.gameDsLb.hidden = NO;
      [self.listBgView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
   //开黑状态 游戏中1,战绩待汇报2，战绩审核中4，战绩待确认5，战绩已超时201，已确认101，被驳回102，已完成103，战绩已失效202 ,
    if ([self.playRecordDateilsModel .userGameFLow.status isEqualToString:@"1"]){
        self.gameStatusLb.text = @"游戏中";
        if([self.meModel.userId isEqualToString:loginUid]){
              self.gameDsLb.text = @"游戏中"; 
        }else{
              self.gameDsLb.text = @"若开黑完毕，可通知房主结束游戏";
        }
       
    }else if([self.playRecordDateilsModel .userGameFLow.status isEqualToString:@"2"]){
            self.gameStatusLb.text = @"战绩待汇报";
       
      
    }else if([self.playRecordDateilsModel .userGameFLow.status isEqualToString:@"4"]){
            self.gameStatusLb.text = @"战绩审核中";
        if([self.meModel.userId isEqualToString:loginUid]){
            self.gameDsLb.text = @"请耐心等待，如遇问题可联系客服QQ。";
        }else{
            self.gameDsLb.text = @"请耐心等待，如遇问题可联系客服QQ。";
        }
    }else if([self.playRecordDateilsModel .userGameFLow.status isEqualToString:@"5"]){
            self.gameStatusLb.text = @"战绩待确认";
        if([self.meModel.userId isEqualToString:loginUid]){
               self.gameDsLb.text = @"请在30分钟内确认战绩，超时赏金自动发给房客";
        }else{
              self.gameDsLb.text = @"若30分钟内房主不确认战绩  系统将自动确认";
        }
        
   
    }else if([self.playRecordDateilsModel .userGameFLow.status isEqualToString:@"201"]){
            self.gameStatusLb.text = @"战绩已超时";
           self.gameDsLb.text =  @"战绩已超时";
    }else if([self.playRecordDateilsModel .userGameFLow.status isEqualToString:@"101"]){
            self.gameStatusLb.text = @"已确认";
        if([self.meModel.userId isEqualToString:loginUid]){
            self.gameDsLb.text = @"已确认";
        }else{
            self.gameDsLb.text = @"房主已经确认已确认";
        }
        
    }else if([self.playRecordDateilsModel .userGameFLow.status isEqualToString:@"102"]){
            self.gameStatusLb.text = @"被驳回";
    }else if([self.playRecordDateilsModel .userGameFLow.status isEqualToString:@"103"]){
            self.gameStatusLb.text = @"已完成";
        if([self.meModel.userId isEqualToString:loginUid]){
            self.gameDsLb.text = @"已完成";
        }else{
            self.gameDsLb.text = @"已完成";
        }
        self.gameDsLb.hidden = YES;
        self.agenbt.hidden = NO;
    }else if([self.playRecordDateilsModel .userGameFLow.status isEqualToString:@"202"]){
            self.gameStatusLb.text = @"战绩已失效";
           self.gameDsLb.text = @" 经系统核实，本局开黑无效，赏金已退还";
       
    }
    
    [self.userMasterIcon sd_setImageWithURL:[NSURL URLWithString:self.meModel.userIcon]];
    self.userMasterNameLb.text = self.meModel.userName;
//    if([self.meModel.userId isEqualToString:loginUid]){
//       self.moneyLb.text = [NSString stringWithFormat:@"%@元",self.meModel.amountMoney];
//    }else{
//       self.moneyLb.text = [NSString stringWithFormat:@"%@元",self.meModel.winMoney];
//    }
     self.moneyLb.text = [NSString stringWithFormat:@"%@元",self.meModel.amountMoney];
    for (int i = 0; i < self.otherArr.count; i++) {
        YWPvosModel  * otherModel = self.otherArr[i];
        CGFloat buttonStartX = 0;
        CGFloat buttonH = 60;
        CGFloat buttonW = LFscreenW;
        CGFloat butttonStartY = i * buttonH;
        YWPlayUsersView * playUserView  = [YWPlayUsersView loadNamePlayUserView];
        otherModel.rewardMode = self.playRecordDateilsModel.roomInfo.rewardMode;
        playUserView.otherModel = otherModel;
        playUserView.frame = CGRectMake(buttonStartX, butttonStartY, buttonW, 60);
        [self.listBgView addSubview:playUserView];
    }
    self.bigBgViewLyout.constant = 169 +  self.otherArr.count * 60;
    if ( self.playRecordDateilsModel.order ) {
        self.orderView.hidden = NO;
        [self showView];
        if([self.meModel.userId isEqualToString:loginUid]){
            self.couponLb.text =  [NSString stringWithFormat:@"-%0.2f",[self.playRecordDateilsModel.order.originalPrice  doubleValue]-[self.playRecordDateilsModel.order.price  doubleValue]];
            self.allPriceLb.text =  [NSString stringWithFormat:@"%0.2f",[self.playRecordDateilsModel.order.price  doubleValue]];
            self.roomMoneyLb.text = [NSString stringWithFormat:@"%0.2f",[self.playRecordDateilsModel.order.originalPrice  doubleValue]];
        }else{
            
            self.fnagjianewiLb.text = @"赏金";
            self.couponTypeLb.hidden = YES;
            [self hideView];
            self.roomMoneyLb.text = [NSString stringWithFormat:@"%0.2f",[self.playRecordDateilsModel.userGameFLow.winMoney  doubleValue]];
        }
        
        
    }else{
        [self hideView];
        self.orderView.hidden = YES;
       
     
        
        if([self.meModel.userId isEqualToString:loginUid]){
            self.roomMoneyLb.text  = [NSString stringWithFormat:@"￥%@",@"0.00"];
        }else{
            
            self.fnagjianewiLb.text = @"赏金";
              self.roomMoneyLb.text  = [NSString stringWithFormat:@"￥%@",@"0.00"];
          
           
        }
    }
    
  
    if ([self.playRecordDateilsModel.userGameFLow.gameArea isEqualToString:@"1"]) {
        self.gameArea = @"QQ区";
    }else{
        self.gameArea = @"微信区";
    }
    if ([self.playRecordDateilsModel.userGameFLow.roomMode isEqualToString:@"1"]) {// 1、多人排位 2、五人排位 3、多人对战',
        self.roomMode = @"多人排位";
    }else if ([self.playRecordDateilsModel.userGameFLow.roomMode isEqualToString:@"2"]){
        self.roomMode = @"五人排位";
    }else if ([self.playRecordDateilsModel.userGameFLow.roomMode isEqualToString:@"3"]){
        self.roomMode = @"对战";
    }
    
    
    if ([self.playRecordDateilsModel.userGameFLow.roomType isEqualToString:@"1"]) {// 1、多人排位 2、五人排位 3、多人对战',
        self.roomType = @"AA房间";
    }else if ([self.playRecordDateilsModel.userGameFLow.roomType isEqualToString:@"2"]){
        self.roomType = @"撒币房";
    }else if ([self.playRecordDateilsModel.userGameFLow.roomType isEqualToString:@"3"]){
        self.roomType = @"悬赏房";
    }
    self.gameTypeLb.text = [NSString stringWithFormat:@"%@|%@",self.gameArea , self.roomMode ];
    self.roomTypeLb.text =  self.roomType;
      self.roomMoneyLb.text =  [NSString stringWithFormat:@"￥%@",self.playRecordDateilsModel.userGameFLow.winMoney];
    
//    if([self.meModel.userId isEqualToString:loginUid]){
////        
////        if (<#condition#>) {
////            <#statements#>
////        }
//        
//        if (!self.playRecordDateilsModel.orderCouponInfo) {
//            self.couponLb.text =  [NSString stringWithFormat:@"-%@",@"0.00"];
//            self.allPriceLb.text =  [NSString stringWithFormat:@"%0.2f",[self.playRecordDateilsModel.userGameFLow.amountMoney  doubleValue]];
//        }else{
//            self.couponLb.text =  [NSString stringWithFormat:@"-%@",self.playRecordDateilsModel.orderCouponInfo.price];
//            self.allPriceLb.text =  [NSString stringWithFormat:@"%0.2f",[self.playRecordDateilsModel.userGameFLow.amountMoney doubleValue] - [self.playRecordDateilsModel.orderCouponInfo.price doubleValue]];
//        }
//    }else{
//        if (!self.playRecordDateilsModel.orderCouponInfo) {
//            self.couponLb.text =  [NSString stringWithFormat:@"-%@",@"0.00"];
//            self.allPriceLb.text =  [NSString stringWithFormat:@"%0.2f",[self.playRecordDateilsModel.userGameFLow.winMoney  doubleValue]];
//        }else{
//            self.couponLb.text =  [NSString stringWithFormat:@"-%@",self.playRecordDateilsModel.orderCouponInfo.price];
//            self.allPriceLb.text =  [NSString stringWithFormat:@"%0.2f",[self.playRecordDateilsModel.userGameFLow.winMoney  doubleValue] - [self.playRecordDateilsModel.orderCouponInfo.price doubleValue]];
//        }
//        
//    }
    if ([self.playRecordDateilsModel.roomInfo.rewardMode isEqualToString:@"1"] ) {
         self.couponTypeLb.text = @"平分";
        self.couponTypeLb.hidden = YES;
    }else{
         self.couponTypeLb.text = @"拼手气";
    }
    self.outTroLb.text =  [NSString stringWithFormat:@"订单号码：%@",self.playRecordDateilsModel.order.outTradeNo]; 
     self.orderTimeLb.text = [NSString stringWithFormat:@"订单时间：%@",self.playRecordDateilsModel.order.createTime];

    if ([self.playRecordDateilsModel.order.payChannel  isEqualToString:@"8"])  {
        self.payTypeLb.text = @"支付方式：支付宝";
    }else if ([self.playRecordDateilsModel.order.payChannel  isEqualToString:@"8"]) {
        self.payTypeLb.text = @"支付方式：微信";
    }

}


-(void)gradientFremeww:(CGRect)frame startColor:(UIColor *)startColor endColor:(UIColor *)endColor{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame =  frame;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)startColor
                       .CGColor,
                       (id)endColor.CGColor,nil];
    //  设置三种颜色变化点，取值范围 0.0~1.0
    //    gradient.locations = @[@(0.1f) ,@(0.5f)];
    
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradient.startPoint = CGPointMake(0, 0);
    gradient.endPoint = CGPointMake(1, 0);
    
    [self.topBgView.layer addSublayer:gradient];
    
}



@end
