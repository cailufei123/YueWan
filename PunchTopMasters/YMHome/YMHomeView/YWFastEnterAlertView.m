//
//  YWFastEnterAlertView.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/3/29.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWFastEnterAlertView.h"
#import "YWSelectModel.h"
@interface YWFastEnterAlertView()

@property (weak, nonatomic) IBOutlet YWSelectButton *qqBt;
@property (weak, nonatomic) IBOutlet YWSelectButton *chatBt;
@property (weak, nonatomic) IBOutlet YWSelectButton *moreBt;
@property (weak, nonatomic) IBOutlet YWSelectButton *firveBt;
@property (weak, nonatomic) IBOutlet YWSelectButton *towBt;

@property (weak, nonatomic) IBOutlet UIButton *fastBt;
@property (weak, nonatomic) IBOutlet UIButton *closeBt;
@property(nonatomic,strong) NSMutableArray * qqs;
@property(nonatomic,strong) NSMutableArray * patterns;
@property(nonatomic,strong) NSMutableArray * allDans;
@property(nonatomic,strong) NSMutableArray * allbts;


@property(nonatomic,strong)UIButton * qqsSelectBt;
@property(nonatomic,strong)UIButton * patternsBt;
@property(nonatomic,strong)UIButton * isSelectMoreBt;
@property(nonatomic,strong)UIButton * selectdanBt;
@property(nonatomic,strong)NSMutableArray *   YselectDans;
@property(nonatomic,strong)NSMutableArray *   levSelectBts;
@property(nonatomic,strong)YWSelectModel *   selectModel;
@property(nonatomic,strong)NSMutableArray *   levSelectModels;//存放所有选中的model
@property(nonatomic,strong)NSMutableArray *   segMatchs;//存放所有字符串

@property(nonatomic,strong)NSMutableDictionary * gameAreadict;
@property(nonatomic,strong)NSMutableDictionary * roomTypedict;
@property(nonatomic,strong)NSMutableDictionary * segMatchdict;

@property(nonatomic,strong)NSMutableArray * rooms;
@property(nonatomic,strong)NSMutableArray * games;
@end
@implementation YWFastEnterAlertView
-(void)awakeFromNib{
    [super awakeFromNib];
    self.YselectDans = [NSMutableArray array];
     self.segMatchs = [NSMutableArray array];
    self.levSelectModels  = [NSMutableArray array];
    self.qqs = [NSMutableArray arrayWithObjects:self.qqBt,self.chatBt, nil];
    self.patterns = [NSMutableArray arrayWithObjects:self.moreBt,self.firveBt,self.towBt, nil];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"searchDatas" ofType:@"plist"];
    NSMutableDictionary *datas = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    self.allDans = datas[@"createSegMatchs"];
    self.rooms =   datas[@"roomTypes"];
    self.games =  datas[@"gameAreas"];
    
    self.selectModel = [[YWSelectModel alloc] init];
    self.levSelectBts = [LevelModel mj_objectArrayWithKeyValuesArray:self.allDans];
    
    self.allbts = [NSMutableArray array];
    for (NSDictionary * dict  in self.allDans) {
        YWSelectButton * bt = [[YWSelectButton alloc] init];
        [bt setTitle:dict[@"name"] forState:UIControlStateNormal];
      
         bt.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15.f];
        bt.tag = [dict[@"number"] integerValue];
        [bt setTitleColor:[SVGloble colorWithHexString:@"#39404E"] forState:UIControlStateNormal];
        [self.allbts addObject:bt];
    }
    
    for (int i = 0; i<self.qqs.count; i++) {
        UIButton * button =   self.qqs[i];
        button.tag = i;
        [self selectBtStatus:self.qqs[i]];
        [self.qqs[i] addTarget:self action:@selector(chatBtClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    for (int i = 0; i<self.patterns.count; i++) {
        UIButton * button =   self.patterns[i];
        button.tag = i;
        [self selectBtStatus:self.patterns[i]];
        [self.patterns[i] addTarget:self action:@selector(patternsBtClick:) forControlEvents:UIControlEventTouchUpInside];
    }
      self.bgLyout.constant = 0;
      self.bgView.hidden = YES;
     [self.fastBt addTarget:self action:@selector(fastBtClickRoom) forControlEvents:UIControlEventTouchUpInside];
    [self.closeBt addTarget:self action:@selector(closeBtBtClick) forControlEvents:UIControlEventTouchUpInside];
     [SVGloble gradientLayer:self.fastBt];
}
-(void)closeBtBtClick{
    [GKCover hideCover];
}
-(void)fastBtClickRoom{
    if (self.qqsSelectBt.selected == NO) {
        [MBManager showBriefAlert:@"请选择游戏区服"];return;
    }
    if (self.patternsBt.selected == NO) {
        [MBManager showBriefAlert:@"请选择游戏模式"];return;
    }
    if (self.selectdanBt.selected == NO) {
        [MBManager showBriefAlert:@"选择段位"];return;
    }
    [self.segMatchs removeAllObjects];
    for ( LevelModel * levelsModel  in self.selectModel.levels) {
        [self.segMatchs addObject:levelsModel.number];
    }
    
      self.sureClickScreen( self.gameAreadict, self.segMatchdict);
//    NSString *str = [self.segMatchs componentsJoinedByString:@","];
//    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
//     dict[@"gameArea"] = self.selectModel.erviceArea;
//     dict[@"roomMode"] =self.selectModel.pattern;
//     dict[@"roomType"] =self.selectModel.roomType;
//     dict[@"segMatch"] =str;
//    dict[@"page"] =@"0";
//    dict[@"size"] =@"10";
//     LFLog(@"---------------%@",dict);
//
//
//
//
//
//     LFLog(@"---------------%@",str);
//    [YWRequestData fastEnterRoomDict:dict success:^(id responseObject) {
//
//    } failed:^(NSError *error) {
//
//    }];
//
}
//创建按钮
-(void)createRquestBt{
//   
//    if (!self.selectDict||self.patternsBt.selected == NO) {
//        return;
//    }
    for (id obj in self.bgView.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            [obj removeFromSuperview];
        }
    }
    //中间3个按钮
    int maxCols = 3;
    CGFloat buttonStartX = 0;
    CGFloat butttonStartY = 15+10;
    CGFloat xMargin = 10;
    CGFloat yMargin = 13;
    CGFloat buttonH = 36;
    CGFloat buttonW = (LFscreenW-56-40-(maxCols - 1) * xMargin - 2*buttonStartX)/maxCols;
    [self.YselectDans removeAllObjects];
//    [self.levSelectBts removeAllObjects];
    
    for (UIButton * bt in self.allbts) {
        bt.selected = NO;
    }

    
    
    for (int i = 0; i <  self.allbts.count; i++) {
        
        UIButton * bt = self.allbts[i];
        [self selectBtStatus:bt];
        //计算X、Y
        int row = i / maxCols;
        int col = i % maxCols;
      
        CGFloat buttonX = buttonStartX + col * (xMargin + buttonW);
        CGFloat buttonEndY = butttonStartY + row * (buttonH+yMargin);
        [bt addTarget:self action:@selector(clickBgBtClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:bt];
        
        bt.frame = CGRectMake(buttonX, buttonEndY, buttonW, buttonH);
    }
    UIButton * but = [self.allbts lastObject];
    self.bgLyout.constant = but.clf_bottom;
   self.bgView.hidden = NO;
    self.gk_size = CGSizeMake(LFscreenW-56, 380+but.clf_bottom);
  
    [GKCover layoutSubViews ];
}

-(void)clickBgBtClick:(UIButton *)bt{
    
    
    
//     LevelModel * levelsModel = self.levSelectBts[bt.tag-1];
//    if (bt.selected) {
//        bt.selected = NO;
//         bt.layer.borderColor = deepGrayColor.CGColor;
//        if ([self.levSelectModels containsObject:levelsModel]) {
//            [self.levSelectModels removeObject:levelsModel];
//        }
//    }else{
//          bt.selected = YES;
//         bt.layer.borderColor = yellowBoderColor.CGColor;
//        if (![self.selectModel.levels containsObject:levelsModel]) {
//            [ self.levSelectModels addObject:levelsModel];
//        }
//    }
//    
//    self.selectModel.levels = self.levSelectModels;
     self.segMatchdict = self.allDans[bt.tag-1];
    
    self.selectdanBt.selected = NO;
    bt.selected = YES;
    self.selectdanBt = bt;
    LFLog(@"---------------%@",self.selectModel.levels);
}

-(void)selectBtStatus:(UIButton *)bt{
    [bt layercornerRadius:3];
    bt.layer.borderColor = deepGrayColor.CGColor;
    bt.layer.borderWidth = 0.5;

}

-(void)chatBtClick:(UIButton *)bt{
    self.qqsSelectBt.layer.borderColor = deepGrayColor.CGColor;
    self.qqsSelectBt.selected = NO;
    bt.selected = YES;
    self.qqsSelectBt = bt;
    bt.layer.borderColor = yellowBoderColor.CGColor;
    if (bt==self.qqBt) {
       self.selectModel.erviceArea = @"1";
        
    }else if (bt==self.chatBt){
        self.selectModel.erviceArea = @"2";
    }
 
    self.gameAreadict = self.games[bt.tag+1];
    
    
}
-(void)patternsBtClick:(UIButton *)bt{
    if (bt==self.moreBt) {
        self.selectModel.pattern = @"1";
    }else if (bt==self.firveBt){
        self.selectModel.pattern = @"2";
    }else if (bt==self.towBt){
        self.selectModel.pattern = @"3";
    }
    self.isSelectMoreBt.layer.borderColor = deepGrayColor.CGColor;
    self.patternsBt.selected = NO;
    bt.selected = YES;
    self.patternsBt = bt;
    self.isSelectMoreBt = bt;
//    [self createRquestBt:bt];
    bt.layer.borderColor = yellowBoderColor.CGColor;
    [self createRquestBt];
    
//      self.roomTypedict = self.games[bt.tag+1];
}
-(void)sureBtClick{
    
    
  
    [GKCover hideCover];
}

+(instancetype)loadNameFastEnterAlertViewXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

@end
