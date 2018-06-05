//
//  YWEnterQueueAlertView.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/11.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWEnterQueueAlertView.h"
#import "YWRoomModel.h"
@interface YWEnterQueueAlertView()
@property (weak, nonatomic) IBOutlet UIButton *closeBt;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *sureBt;
@property(nonatomic,strong)YWSelectButton *  selectBt;
@property(nonatomic,strong)NSMutableArray * allBts;
@end
@implementation YWEnterQueueAlertView
-(NSMutableArray *)allBts{
    if (!_allBts) {
        _allBts = [NSMutableArray array];
    }
    return _allBts;
}
-(void)awakeFromNib{
    
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    [SVGloble gradientLayer:self.sureBt];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"searchDatas" ofType:@"plist"];
    NSMutableDictionary *datas = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    NSArray * array = datas[@"createSegMatchs"];
    [self createRquestBt:array];
    [self.sureBt addTarget:self action:@selector(sureBtClick) forControlEvents:UIControlEventTouchUpInside];
     [self.closeBt addTarget:self action:@selector(closeBtClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)closeBtClick{
     [GKCover hideCover];
}
-(void)sureBtClick{

    
      [GKCover hideCover];
    
    if (self.selectBt.selected == NO) {
        [MBManager showBriefAlert:@"请选择你的段位"];
        return;
    }
    if ([_roomModel.roomInfo.roomType isEqualToString:@"1"]||[_roomModel.roomInfo.roomType isEqualToString:@"3"]) {
        if ([_roomModel.roomInfo.roomMoney doubleValue]>0) {
          
              self.joinEnterQueue(nil);
        
            
            
            return;
        }
        
    }
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"searchDatas" ofType:@"plist"];
    NSMutableDictionary *datas = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    NSArray * filePathArray = datas[@"createSegMatchs"];
    NSDictionary * dict = filePathArray[self.selectBt.tag];
    LFLog(@"%@",dict[@"name"]);

    NSMutableDictionary * jiondict = diction;
    jiondict[@"token"] = loginToken;
    jiondict[@"gameId"] = _roomModel.roomInfo.gameId;
    jiondict[@"roomId"] = _roomModel.roomInfo.roomId;
    jiondict[@"userGrade"] = dict[@"number"];
    LFLog(@"%@",jiondict);
    [YWRequestData freeJionQueueDict:jiondict success:^(id responseObj) {
         [LFNSNOTI postNotificationName:enterQueueRefresh object:enterQueueRefresh];
        self.joinQueue(dict[@"name"]);
    }];

  
}

-(void)setRoomModel:(YWRoomModel *)roomModel{
    LFLog(@"%@",roomModel.roomInfo.segMatch );
    _roomModel = roomModel;
    if ([roomModel.roomInfo.segMatch isEqualToString: @""]) {
        
    }else{
       
        NSArray * array = [roomModel.roomInfo.segMatch componentsSeparatedByString:@","];//#为分隔符
        LFLog(@"%@",roomModel.roomInfo.segMatch);
        for (int i = 0; i<self.allBts.count; i++) {
              YWSelectButton * bt = self.allBts[i];
            bt.userInteractionEnabled = NO;
            [bt setBackgroundColor:[SVGloble colorWithHexString:@"#D8D8D8"]];
            [bt setTitleColor:deepGrayColor forState:UIControlStateNormal];
            for (int j = 0; j<array.count; j++) {
                NSString * number= array[j];
               
                if (i ==  [number integerValue]-1) {
                     bt.userInteractionEnabled = YES;
                  [bt setBackgroundColor:[UIColor whiteColor]];
                      [bt setTitleColor:[SVGloble colorWithHexString:@"#39404E"] forState:UIControlStateNormal];
                    
                }
            }
        }
    }
}
//创建按钮
-(void)createRquestBt:(NSArray *)array{
    //
    //    if (!self.selectDict||self.patternsBt.selected == NO) {
    //        return;
    //    }
//    for (id obj in self.bgView.subviews) {
//        if ([obj isKindOfClass:[UIButton class]]) {
//            [obj removeFromSuperview];
//        }
//    }
    //中间3个按钮
    int maxCols = 3;
    CGFloat buttonStartX = 10;
    CGFloat butttonStartY = 15+10;
    CGFloat xMargin = 20;
    CGFloat yMargin = 13;
    CGFloat buttonH = 36;
    CGFloat buttonW = (LFscreenW-40-(maxCols - 1) * xMargin - 2*buttonStartX)/maxCols;
    [self.allBts removeAllObjects];
    for (int i = 0; i <  array.count; i++) {
        NSDictionary * dict =array[i];
        YWSelectButton * bt = [[YWSelectButton alloc] init];
        [bt setTitle:dict[@"name"] forState:UIControlStateNormal];
        bt.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15.f];
        bt.tag = i;
        [bt setTitleColor:[SVGloble colorWithHexString:@"#39404E"] forState:UIControlStateNormal];
//        [self.allbts addObject:bt];
        [self selectBtStatus:bt];
        //计算X、Y
        int row = i / maxCols;
        int col = i % maxCols;
        CGFloat buttonX = buttonStartX + col * (xMargin + buttonW);
        CGFloat buttonEndY = butttonStartY + row * (buttonH+yMargin);
        [bt addTarget:self action:@selector(clickBgBtClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:bt];
        bt.frame = CGRectMake(buttonX, buttonEndY, buttonW, buttonH);
        [self.allBts addObject:bt];
    }

    
 
}
-(void)selectBtStatus:(UIButton *)bt{
    [bt layercornerRadius:3];
    bt.layer.borderColor = deepGrayColor.CGColor;
    bt.layer.borderWidth = 0.5;
    
}
-(void)clickBgBtClick:(YWSelectButton *)bt{
    
    self.selectBt.layer.borderColor = deepGrayColor.CGColor;
    self.selectBt.selected = NO;
    bt.selected = YES;
    self.selectBt = bt;
     bt.layer.borderColor = yellowBoderColor.CGColor;
    
    
    
}
+(instancetype)loadNameEnterQueueAlertViewXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
-(void)dealloc{
    [LFNSNOTI removeObserver:self];
}


@end
