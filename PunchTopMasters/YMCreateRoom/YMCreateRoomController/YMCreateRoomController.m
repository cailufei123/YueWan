//
//  YMCreateRoomController.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/3/21.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YMCreateRoomController.h"
#import "YWSelectlevelAlertView.h"
 #import <Hyphenate/Hyphenate.h>
#import "YWChatViewController.h"
#import "YWPriceBgView.h"
#import "YWSearchModel.h"
#import "YWRoomModel.h"
#import "YWCreatePrasswordAlertView.h"
#import "YWCreatePayViewController.h"
#import "YWRoomModel.h"


@interface YMCreateRoomController ()<UITextViewDelegate,UITextFieldDelegate,UIScrollViewDelegate,EMChatroomManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *numberTitle;
@property(nonatomic,strong) NSMutableArray * qqs;
@property(nonatomic,strong) NSMutableArray * patterns;
@property(nonatomic,strong) NSMutableArray * types;
@property(nonatomic,strong) NSMutableArray * allDans;
@property(nonatomic,strong) NSMutableArray * allbts;
@property(nonatomic,strong) NSMutableArray * XSbts;




@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UITextField *titleTf;
@property (weak, nonatomic) IBOutlet YWSelectButton *qqBt;
@property (weak, nonatomic) IBOutlet YWSelectButton *chatBt;
@property (weak, nonatomic) IBOutlet YWSelectButton *moreBt;
@property (weak, nonatomic) IBOutlet YWSelectButton *firveBt;
@property (weak, nonatomic) IBOutlet YWSelectButton *towBt;
@property (weak, nonatomic) IBOutlet UITextField *danTf;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet YWSelectButton *AABt;
@property (weak, nonatomic) IBOutlet YWSelectButton *xsBt;
@property (weak, nonatomic) IBOutlet YWSelectButton *sbBt;
@property (weak, nonatomic) IBOutlet UIButton *createBt;
@property (weak, nonatomic) IBOutlet UIView *danView;

@property (weak, nonatomic) IBOutlet UIView *tapView;
@property (weak, nonatomic) IBOutlet UIView *topView1;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@property (weak, nonatomic) IBOutlet YWSelectButton *AARoomBt;
@property (weak, nonatomic) IBOutlet YWSelectButton *luckRoomBt;

@property (weak, nonatomic) IBOutlet UIView *priceBgView;
@property (weak, nonatomic) IBOutlet UIView *priceView1;
@property (weak, nonatomic) IBOutlet UIView *priceView2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *priceBgViewLyout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *priceViewLyout1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *priceViewLyout2;

@property(nonatomic,strong)YWSelectButton * qqsSelectBt;
@property(nonatomic,strong)YWSelectButton * patternsBt;
@property(nonatomic,strong)YWSelectButton * typesBt;
@property(nonatomic,strong)YWSelectButton * selectXSBt;


@property(nonatomic,assign)NSInteger  selectDan;
@property(nonatomic,strong)NSMutableArray *   YselectDans;
@property(nonatomic,strong)NSMutableDictionary * selectDict;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgLyout;
@property(nonatomic,strong)YWSelectlevelAlertView * selectlevelAlertView;
@property(nonatomic,strong)UIButton * isSelectMoreBt;
@property(nonatomic,strong)YWPriceBgView * createPriceBgView;

@property(nonatomic,strong) NSMutableArray * levSelectBts;
@property(nonatomic,strong) NSMutableArray * segMatchs;
@property(nonatomic,strong) YWSearchModel * createModel;







// (我们的)平台房间号
@property(nonatomic,strong) NSString *  roomId;
// 房主用户Id
@property(nonatomic,strong) NSString *  userId;
//房主头象
@property(nonatomic,strong) NSString *  userLogo;//
// 房主
@property(nonatomic,strong) NSString * userName;
// 房间口号
@property(nonatomic,strong) NSString *  roomSlogan;
// 游戏大区 1 QQ 2 微信
@property(nonatomic,strong) NSString *  gameArea;
// 房间类型 1、AA制 2、撒币 3、 悬赏
@property(nonatomic,strong) NSString * roomType;
// 房间费用 当AA制此值为房间费 撒币和悬赏为房主出价金额
@property(nonatomic,strong) NSString *  roomMoney;
// 房主的段位；
@property(nonatomic,strong) NSString *  segment;
// 段位匹配要求，逗号分隔；
@property(nonatomic,strong) NSString * segMatch;
// 1：平分；2：拼手气；
@property(nonatomic,strong) NSString *  rewardMode;
// 房间密码
@property(nonatomic,strong) NSString *  roomPass;
// 游戏模式 1、多人排位 2、五人排位 3、多人对战
@property(nonatomic,strong) NSString * roomMode;
// 状态 0、房间已解散 1、房间已创建
@property(nonatomic,strong) NSString *  status;
// 0：未开始；1、启动中(房主点击唤起游戏) 2、游戏中(客服收到链接已开始游戏) 3、结算中，(房主手动点击结束游戏) 4、游戏结束；
@property(nonatomic,strong) NSString *  gameStatus;

//默认队列
@property(nonatomic,strong) NSString *  requireQueueCount;
//当前队列
@property(nonatomic,strong) NSString *  currentQueueCount;
@end

@implementation YMCreateRoomController

-(void)dealloc{
     [LFNSNOTI removeObserver:self];
}

-(void)paySucessClick{
      [MBManager showBriefAlert:@"创建成功"];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(NSMutableArray *)segMatchs{
    
    if (!_segMatchs) {
        _segMatchs = [NSMutableArray array];
    }
    return _segMatchs;
}
- (void)viewDidLoad {
    [super viewDidLoad];
      [LFNSNOTI addObserver:self selector:@selector(paySucessClick) name:paySucess object:nil];
    self.navigationItem.title = @"创建房间";
    self.levSelectBts = [NSMutableArray array];
    self.selectDan = 4;
    self. YselectDans = [NSMutableArray array];
    self.qqs = [NSMutableArray arrayWithObjects:self.qqBt,self.chatBt, nil];
    self.patterns = [NSMutableArray arrayWithObjects:self.moreBt,self.firveBt,self.towBt, nil];
    self.types = [NSMutableArray arrayWithObjects:self.AABt,self.xsBt,self.sbBt, nil];
    self.XSbts = [NSMutableArray arrayWithObjects:self.AARoomBt,self.luckRoomBt, nil];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"searchDatas" ofType:@"plist"];
    NSMutableDictionary *datas = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    self.allDans = datas[@"createSegMatchs"];
    self.allbts = [NSMutableArray array];
    for (NSDictionary * dict  in self.allDans) {
    YWSelectButton * bt = [[YWSelectButton alloc] init];
    [bt setTitle:dict[@"name"] forState:UIControlStateNormal];
        bt.titleLabel.font = [UIFont systemFontOfSize:16];
        bt.tag = [dict[@"number"] integerValue]-1;
        [bt setTitleColor:[SVGloble colorWithHexString:@"#39404E"] forState:UIControlStateNormal];
        [self.allbts addObject:bt];
    }
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem wh_barButtonItemWithTitle:@"设置密码" imageName:nil target:self action:@selector(setPassword) fontSize:14 titleNormalColor:nil titleHighlightedColor:nil];
   [self wr_setNavBarBackgroundAlpha:0];
    
    
    
    self.titleView.layer.borderWidth = 0.5;
    self.titleView.layer.borderColor = deepGrayColor.CGColor;
    self.titleTf.borderStyle = UITextBorderStyleNone;
    [self.titleTf setValue:deepGrayColor
              forKeyPath:@"_placeholderLabel.textColor"];
    self.danTf.delegate = self; self.titleTf.delegate = self;
    
    self.danView.layer.borderWidth = 0.5;
    self.danView.layer.borderColor = deepGrayColor.CGColor;
    self.danTf.borderStyle = UITextBorderStyleNone;
    [self.danTf setValue:deepGrayColor
                forKeyPath:@"_placeholderLabel.textColor"];
   
    for (int i = 0; i<self.qqs.count; i++) {
        YWSelectButton * button = self.qqs[i];button.tag = i;
        [self selectBtStatus:button];
          [self.qqs[i] addTarget:self action:@selector(chatBtClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    for (int i = 0; i<self.patterns.count; i++) {
        YWSelectButton * button = self.patterns[i];button.tag = i;
        [self selectBtStatus:button];
        [self.patterns[i] addTarget:self action:@selector(patternsBtClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    for (int i = 0; i<self.types.count; i++) {
         YWSelectButton * button = self.types[i];button.tag = i;
        [self selectBtStatus:button];
          [self.types[i]  addTarget:self action:@selector(typesBtClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    for (int i = 0; i<self.XSbts.count; i++) {
         YWSelectButton * button = self.XSbts[i];button.tag = i;
        [self selectBtStatus:button];
        [self.XSbts[i]  addTarget:self action:@selector(XSBtClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    UITapGestureRecognizer * tap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapl)];
     UITapGestureRecognizer * tap1= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapl)];
    [self.tapView addGestureRecognizer:tap];
     [self.view addGestureRecognizer:tap1];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(codetextFiledEditChanged:)
                                                name:UITextFieldTextDidChangeNotification object:nil];
    
     UITapGestureRecognizer * danTftap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(danTftap)];
    [self.danTf addGestureRecognizer:danTftap];
    self.scrollView.delegate = self;
  
    
   
    [self.createBt addTarget:self action:@selector(createBtClickRoom) forControlEvents:UIControlEventTouchUpInside];
     [SVGloble gradientLayer:self.createBt];
    [self viewStatus];
}
-(void)viewStatus{//view的初始状态
    self.bgLyout.constant = 0;
    self.bgView.hidden = YES;
    self.priceBgViewLyout.constant = 0;
    self.priceBgView.hidden = YES;
    
}

-(void)setPassword{
    WeakSelf(weakSelf)
    YWCreatePrasswordAlertView * createPrasswordView = [YWCreatePrasswordAlertView loadNameCreatePrasswordAlertViewXib];
    createPrasswordView.surepassword = ^(NSString *password) {
        weakSelf.roomPass = password;
    };
    createPrasswordView.clf_size = CGSizeMake(LFscreenW-40, 250);
     [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:createPrasswordView style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleCenter showAnimStyle:GKCoverShowAnimStyleBottom hideAnimStyle:GKCoverHideAnimStyleNone notClick:NO];
}
-(void)tapl{
    [self.view endEditing:YES];
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}



-(void)selectBtStatus:(UIButton *)bt{
    [bt layercornerRadius:3];
    bt.layer.borderColor = deepGrayColor.CGColor;
    bt.layer.borderWidth = 0.5;
    
}
-(void)chatBtClick:(YWSelectButton *)bt{// 游戏大区 1 QQ 2 微信
      self.qqsSelectBt.layer.borderColor = deepGrayColor.CGColor;
      self.qqsSelectBt.selected = NO;
      bt.selected = YES;
      self.qqsSelectBt = bt;
      [self.view endEditing:YES];
      bt.layer.borderColor = yellowBoderColor.CGColor;
    self.gameArea = [NSString stringWithFormat:@"%ld",bt.tag+1];
   
   
    
}
-(void)patternsBtClick:(YWSelectButton *)bt{// 游戏模式 1、多人排位 2、五人排位 3、多人对战
   self.isSelectMoreBt.layer.borderColor = deepGrayColor.CGColor;
      self.patternsBt.selected = NO;
    bt.selected = YES;
    self.patternsBt = bt;
     self.isSelectMoreBt = bt;
    [self createRquestBt:bt];
     bt.layer.borderColor = yellowBoderColor.CGColor;
      [self.view endEditing:YES];
     self.roomMode = [NSString stringWithFormat:@"%ld",bt.tag+1];
}
-(void)typesBtClick:(YWSelectButton *)bt{//点击房间类型 // 房间类型 1、AA制 2、撒币 3、 悬赏
     self.typesBt.layer.borderColor = deepGrayColor.CGColor;
     self.typesBt.selected = NO;
     bt.selected = YES;
     self.typesBt = bt;
      [self.view endEditing:YES];
     bt.layer.borderColor = yellowBoderColor.CGColor;    self.types = [NSMutableArray arrayWithObjects:self.AABt,self.xsBt,self.sbBt, nil];
    if (bt == self.AABt) {
          self.roomType = @"1";
    }else if(bt == self.xsBt) {
         self.roomType = @"3";
    }else if(bt == self.sbBt) {
         self.roomType = @"2";
    }
   
    [self createPriceRoomStyle:bt];
}
-(void)XSBtClick:(YWSelectButton *)bt{//点击SB
    self.selectXSBt.layer.borderColor = deepGrayColor.CGColor;
    self.selectXSBt.selected = NO;
    bt.selected = YES;
    self.selectXSBt = bt;
    [self.view endEditing:YES];
    bt.layer.borderColor = yellowBoderColor.CGColor;
     self.rewardMode = [NSString stringWithFormat:@"%ld",bt.tag+1];

}
-(YWPriceBgView *)createPriceBgView{
     WeakSelf(weakSelf);
    if (!_createPriceBgView) {
        
   _createPriceBgView = [[YWPriceBgView alloc] initWithFrame:CGRectMake(0, 0, LFscreenW-72, 80) ];
_createPriceBgView.pirceStr = ^(NSString * str) {// 房间费用 当AA制此值为房间费 撒币和悬赏为房主出价金额
            LFLog(@"===---=-=-=-%@",str);
            weakSelf.roomMoney = str;
        };
    }
    return _createPriceBgView;
}
-(void)createPriceRoomStyle:(UIButton *)bt{//创建房间价格
    self.priceBgView.hidden = NO;
    if (bt == self.AABt) {
    self.priceBgViewLyout.constant = 105;
//        self.priceViewLyout2 = 0;
        self.priceView2.hidden = YES;
        self.createPriceBgView.statusStr = @"3";
    }else if (bt == self.xsBt){
        self.priceBgViewLyout.constant = 105;
//        self.priceViewLyout2.constant = 0;
         self.priceView2.hidden = YES;
        
         self.createPriceBgView.statusStr = @"2";
    }else if (bt == self.sbBt){
//         self.priceViewLyout2.constant = 60;
        self.priceBgViewLyout.constant = 180;
         self.priceView2.hidden = NO;
        
         self.createPriceBgView.statusStr = @"1";
    }
   
    [self.priceView1 addSubview: self.createPriceBgView];
   
}





//创建按钮
-(void)createRquestBt:(UIButton *)button{
      [self.view endEditing:YES];
    if (!self.selectDict||self.patternsBt.selected == NO) {
        return;
    }
    for (id obj in self.bgView.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            [obj removeFromSuperview];
        }
    }
    //中间3个按钮
    int maxCols = 3;
    CGFloat buttonStartX = 0;
    CGFloat butttonStartY = 15+10;
    CGFloat xMargin = 15;
    CGFloat yMargin = 13;
    CGFloat buttonH = 36;
    CGFloat buttonW = (LFscreenW-72-(maxCols - 1) * xMargin - 2*buttonStartX)/maxCols;
    [self.YselectDans removeAllObjects];
     [self.levSelectBts removeAllObjects];
    
    for (UIButton * bt in self.allbts) {
        bt.selected = NO;
    }
    if (button == self.moreBt) {
        if (self.selectDan  - 1<0) {
            UIButton * bt = self.allbts[self.selectDan];
            UIButton * bt1 = self.allbts[self.selectDan+1];
            [self.YselectDans addObject:bt]; [self.YselectDans addObject:bt1];
        }else if(self.selectDan  + 1>=7) {
            UIButton * bt1 = self.allbts[self.selectDan];
            UIButton * bt = self.allbts[self.selectDan - 1];
            
            [self.YselectDans addObject:bt]; [self.YselectDans addObject:bt1];
        }else{
             UIButton * bt0 = self.allbts[self.selectDan - 1];
            UIButton * bt = self.allbts[self.selectDan];
            UIButton * bt1 = self.allbts[self.selectDan + 1];
             [self.YselectDans addObject:bt0]; [self.YselectDans addObject:bt]; [self.YselectDans addObject:bt1];
        }
        
    }else if (button == self.firveBt){
        if (self.selectDan  - 1<0) {
            UIButton * bt = self.allbts[self.selectDan];
            UIButton * bt1 = self.allbts[self.selectDan+1];
            [self.YselectDans addObject:bt]; [self.YselectDans addObject:bt1];
        }else if(self.selectDan  + 1>=7) {
            
            UIButton * bt1 = self.allbts[self.selectDan];
              UIButton * bt = self.allbts[self.selectDan - 1];
          
            [self.YselectDans addObject:bt]; [self.YselectDans addObject:bt1];
        }else{
            UIButton * bt0 = self.allbts[self.selectDan - 1];
            UIButton * bt = self.allbts[self.selectDan];
            UIButton * bt1 = self.allbts[self.selectDan + 1];
            [self.YselectDans addObject:bt0]; [self.YselectDans addObject:bt]; [self.YselectDans addObject:bt1];
        }
        
        
    }else if (button == self.towBt){
        [self.YselectDans addObjectsFromArray:self.allbts];
    }
   
    
   
  
    for (int i = 0; i < self.YselectDans.count; i++) {

        UIButton * bt = self.YselectDans[i];
          [self selectBtStatus:bt];
        //计算X、Y
        int row = i / maxCols;
        int col = i % maxCols;
        
        CGFloat buttonX = buttonStartX + col * (xMargin + buttonW);
        CGFloat buttonEndY = butttonStartY + row * (buttonH+yMargin);
//        [bt setTitle:dict[@"name"] forState:UIControlStateNormal];
      
        [bt  addTarget:self action:@selector(clickBgBtClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:bt];
        
        bt.frame = CGRectMake(buttonX, buttonEndY, buttonW, buttonH);
        
        if (button == self.moreBt) {
              LFLog(@"%ld",bt.tag);
            if (i<2) {
                 [self clickBgBtClick:bt];
            }
            
        }else if (button == self.firveBt){
              [self clickBgBtClick:bt];
        }else if (button == self.towBt){
            [self clickBgBtClick:bt];
        }
    
    }
      UIButton * but = [self.YselectDans lastObject];
      self.bgLyout.constant = but.clf_bottom;
     self.bgView.hidden = NO;
}


-(void)clickBgBtClick:(UIButton *)bt{
    LFLog(@"%ld",bt.tag);
    
    
    if (bt.tag == self.selectDan) {
        bt.selected = YES;
        if (![self.levSelectBts containsObject:bt]) {
             [self.levSelectBts addObject:bt];
        }
        bt.layer.borderColor = yellowBoderColor.CGColor;
    }else{
        if (bt.selected == YES) {
              bt.selected = NO;
             bt.layer.borderColor = deepGrayColor.CGColor;
            if ([self.levSelectBts containsObject:bt]) {
                [self.levSelectBts removeObject:bt];
            }
            
        }else{
            if (self.isSelectMoreBt == self.moreBt) {
                if (self.levSelectBts.count>1) {
                    [MBManager showBriefAlert:@"你最多只能选择相邻2个段位"];
                    return;
                }
            }
             bt.selected = YES;
              bt.layer.borderColor = yellowBoderColor.CGColor;
            if (![self.levSelectBts containsObject:bt]) {
                [self.levSelectBts addObject:bt];
            }
        }
        
    }
    [self. segMatchs removeAllObjects];
    for (int i = 0; i<self.levSelectBts.count; i++) {
        UIButton * bt = self.levSelectBts[i];
        [self. segMatchs addObject:[NSString stringWithFormat:@"%ld",bt.tag+1]];
    }
    
    self.segMatch  = [self.segMatchs componentsJoinedByString:@","];//--分隔符
  
//     self.allDans[]
//
//    levSelectBts
    
    LFLog(@"000----==---%@",self.levSelectBts);
     LFLog(@"000----=---%@",self.segMatch);
    
}
-(void)codetextFiledEditChanged:(NSNotification *)obj{
    UITextField *textField = (UITextField *)obj.object;
    //    NSString *text = textField.text;
    //获取输入法
    NSString * toBeString = textField.text;
    NSString * lang = textField.textInputMode.primaryLanguage;
    self.numberTitle.text = [NSString stringWithFormat:@"%ld/10",toBeString.length<10?toBeString.length:10];
    LFLog(@"-------------%ld",toBeString.length);
    //若果输入的中文
    if ([lang isEqualToString:@"zh-Hans"]) {
        
        UITextRange * selecteRange = [textField markedTextRange];
        if (!selecteRange &&toBeString.length>10) {
            textField.text = [toBeString substringToIndex:10];
            
        }
    }else if(toBeString.length>10){
        textField.text = [toBeString substringToIndex:10];
        
    }
    
}
-(void)textViewDidChange:(UITextView *)textView{
    
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (textField == self.danTf) {
         return  NO;//NO进入不了编辑模式
    }else{
          return  YES;//NO进入不了编辑模式
    }
   
    
}


//进入编辑模式
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //开始编辑时触发，文本字段将成为first responder
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
-(void)danTftap{
     [self.view endEditing:YES];
    self.selectlevelAlertView = [YWSelectlevelAlertView loadNameSelectlevelXib];
//    self.luckDrawAlertView = [PDDLuckDrawAlertView loadNameLuckDrawXib];
//    self.luckDrawAlertView.refreshSign = ^{
//        [weakSelf loadSign];
//    };
    WeakSelf(weakSelf)
    self.selectlevelAlertView.sureClickSelectlevelAlertView = ^(NSMutableDictionary *dict) {
        weakSelf. selectDict = dict;
        weakSelf.danTf.text = dict[@"name"];
         weakSelf.selectDan = [dict[@"number"] integerValue]-1;
        [weakSelf createRquestBt:weakSelf.patternsBt];
        
        weakSelf.segment = dict[@"number"];
    };
    
    self.selectlevelAlertView.array = self.allDans;
    self.selectlevelAlertView.gk_size = CGSizeMake(LFscreenW, 260);
     [GKCover hide];
  
        [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:self.selectlevelAlertView style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleBottom showAnimStyle:GKCoverShowAnimStyleBottom hideAnimStyle:GKCoverHideAnimStyleBottom notClick:NO];

    
  
    [GKCover layoutSubViews];
}
-(void)createBtClickRoom{
   

//
//    return;
  LFLog(@"%@",CREATE_ROOM);
    if (self.qqsSelectBt.selected == NO) {
        [MBManager showBriefAlert:@"请选择游戏服务区"]; return;
    }else if (self.patternsBt.selected == NO){
        [MBManager showBriefAlert:@"请选择房间类型"]; return;
    }else if (!self.selectDict){
        [MBManager showBriefAlert:@"请选择游戏段位"]; return;
    }else if (self.typesBt.selected == NO){
        [MBManager showBriefAlert:@"请选择房间类型"]; return;
    }else if (!self.roomMoney.length){
//        [MBManager showBriefAlert:@"请选择房间费用"]; return;
    }else  if (self.typesBt == self.sbBt) {
        if (self.selectXSBt.selected == NO){
            [MBManager showBriefAlert:@"请选择悬赏模式"]; return;
        }
    }
      NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"userId"] = loginUid;// 房主用户Id
    dict[@"huanUserId"] = huanchatId;// 环信id
    //    dict[@"userLogo"] = @"222";//房主头象
    //    dict[@"userName"] = @"haha"; // 房主
    dict[@"roomSlogan"] =self.titleTf.text.length>0?self.titleTf.text:@"上分队，来不坑的队友";  // 房间口号
    dict[@"gameArea"] = self.gameArea;// 游戏大区 1 QQ 2 微信
    dict[@"roomType"] =  self.roomType;// 房间类型 1、AA制 2、撒币 3、 悬赏
//    dict[@"roomMoney"] = self.roomMoney; // 房间费用 当AA制此值为房间费 撒币和悬赏为房主出价金额
     dict[@"roomMoney"] = @"0"; // 房间费用 当AA制此值为房间费 撒币和悬赏为房主出价金额
    dict[@"segment"]  =  self.segment; // 房主的段位；
    dict[@"productType"]  =  @"1"; // 房主的段位；
    dict[@"segMatch"]  =  self.segMatch;// 段位匹配要求，逗号分隔；
    dict[@"roomPass"]  =  self.roomPass; // 房间密码
    dict[@"roomMode"]  =  self.roomMode;  // 游戏模式 1、多人排位 2、五人排位 3、多人对战
    if ( self.typesBt == self.sbBt) {
        dict[@"rewardMode"]  = self.rewardMode; // 1：平分；2：拼手气；
    }else{
        dict[@"rewardMode"]  = @""; // 1：平分；2：拼手气；
    }
    LFLog(@"%@",dict);
    //查我在不在房间，和我在中不在队列中 在房间中可以退出在队列中不可以退出，如果创建了房间就不能再创建
    NSMutableDictionary * myRoomDict = diction;myRoomDict[@"token"] = loginToken;
    [YWRequestData myRoomDict:myRoomDict success:^(id responseObj) {
          YWMyRoomModel * myRoomModel = [YWMyRoomModel mj_objectWithKeyValues:responseObj[@"data"]];
      
        if ([myRoomModel.userId isEqualToString:loginUid]) {
             [MBManager showBriefAlert:@"您已经创建过房间"];
            return;
        }
         if (myRoomModel.roomId.length) {//在房间
             if ([myRoomModel.isInQueue isEqualToString:@"0"]) {//不在队列
                 NSMutableDictionary * leaveDict = diction;
                 leaveDict[@"roomId"] =  myRoomModel.roomId;
                 leaveDict[@"userId"] =loginUid;
                 [YWRequestData leaveRoomDict:leaveDict success:^(id responseObj) {//离开房间
                     
                 [YWRequestData createRoomDict:dict success:^(id responseObject) {//创建房间
                        YWRoomModel * createModel =[YWRoomModel mj_objectWithKeyValues:responseObj[@"data"]];
                     if ([self.roomMoney integerValue]>0) {
                             YWCreatePayViewController * orderVc = [[YWCreatePayViewController alloc] init];
                         orderVc.callbackType = @"1";
                          orderVc.segment =self.segment;
                         orderVc.createModel = createModel;
                             [self.navigationController pushViewController:orderVc withTransition:YES];
                     }else{
                          [LFNSNOTI postNotificationName:@"createentreroom" object:createModel.roomInfo.roomId];
                           [self dismissViewControllerAnimated:YES completion:nil];
                         [MBManager showBriefAlert:@"创建成功"];
                     }
                  
                    }];
                 }];
             }else{//在队列
                 [MBManager showBriefAlert:@"您已经其他房间队列中，不能创建房间"];
             }
           
         }else{//不在房间
             [YWRequestData createRoomDict:dict success:^(id responseObject) {//创建房间
                  YWRoomModel * createModel =[YWRoomModel mj_objectWithKeyValues:responseObject[@"data"]];
                
                 if ([self.roomMoney integerValue]>0) {
                     YWCreatePayViewController * orderVc = [[YWCreatePayViewController alloc] init];
                      orderVc.callbackType = @"1";
                        orderVc.segment =self.segment;
                     orderVc.createModel = createModel;
                     [self.navigationController pushViewController:orderVc withTransition:YES];
                 }else{
                     [LFNSNOTI postNotificationName:@"createentreroom" object:createModel.roomInfo.roomId];
                     [self dismissViewControllerAnimated:YES completion:nil];
                     [MBManager showBriefAlert:@"创建成功"];
                 }
                 

             }];
             
         }
        
    }];
}


@end
