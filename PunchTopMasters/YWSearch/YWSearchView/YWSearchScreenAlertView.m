//
//  YWSearchScreenAlertView.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/3.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWSearchScreenAlertView.h"
@interface YWSearchScreenAlertView()
@property(nonatomic,strong)NSMutableArray * games;
@property(nonatomic,strong)NSMutableArray * rooms;
@property(nonatomic,strong)NSMutableArray * dans;

@property(nonatomic,strong)NSMutableArray * allbts;
@property(nonatomic,strong)YWSelectButton * selectGameBt;
@property(nonatomic,strong)YWSelectButton * selectAgmentBt;
@property(nonatomic,strong)YWSelectButton * selectRoomBt;
@property(nonatomic,strong) UIView * gameAreView;
@property(nonatomic,strong) UIView * agmentView;
@property(nonatomic,strong) UIView * roomView;

@property(nonatomic,assign) CGFloat  gameAreViewH;
@property(nonatomic,assign) CGFloat  agmentViewH;
@property(nonatomic,assign) CGFloat  roomViewH;
@end
@implementation YWSearchScreenAlertView
-(void)awakeFromNib{
    [super awakeFromNib];
     NSString *filePath = [[NSBundle mainBundle] pathForResource:@"searchDatas" ofType:@"plist"];
    NSMutableDictionary *datas = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    self.dans = datas[@"segMatchs"];
    self.rooms = datas[@"roomTypes"];
    self.games =  datas[@"gameAreas"];
    
    UIView * line = [[UIView alloc] init];
    line.backgroundColor = [SVGloble colorWithHexString:@"#E5E7E9"];
    [self addSubview:line];
    line.frame = CGRectMake(0, 0.5, LFscreenW, 0.5);
    [self createAgmentView:nil];
    [self creategameAreView: self.games];
    [self createRoomView: self.rooms];
}
-(void)setStr:(NSString *)str{
    if ([str isEqualToString:@"1"]) {
       
        self.gameAreView.hidden = YES;
        self.agmentView.hidden = NO; self.clf_height = self.agmentViewH;
        self.roomView.hidden = YES;
    }else if ([str isEqualToString:@"2"]) {
        self.gameAreView.hidden = NO; self.clf_height = self.gameAreViewH;
        self.agmentView.hidden = YES;
        self.roomView.hidden = YES;
    }else if ([str isEqualToString:@"3"]){
        self.gameAreView.hidden = YES;
        self.agmentView.hidden = YES;
        self.roomView.hidden = NO; self.clf_height = self.roomViewH;
    }
    [self layoutIfNeeded];
}
-(void)layoutSubviews{
    
    
}
-(void)createRoomView:(NSMutableArray *)array{
    UIView * roomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LFscreenW, 100)];
    self.roomView = roomView;
    
    //中间3个按钮
    int maxCols = 1;
    CGFloat buttonStartX = 0;
    CGFloat butttonStartY = 0;
    CGFloat xMargin = 0;
    CGFloat yMargin = 0;
    CGFloat buttonH = 44;
    CGFloat buttonW = (LFscreenW-(maxCols - 1) * xMargin - 2*buttonStartX)/maxCols;
    for (int i = 0; i < array.count; i++) {
        NSDictionary * dict = array[i];
        UIButton * bt = [[UIButton alloc] init];
        UIView * bgview = [[UIView alloc] init];
        UIView * line = [[UIView alloc] init];
        line.backgroundColor = [SVGloble colorWithHexString:@"#E5E7E9"];
        [bgview addSubview:line];
        [bgview addSubview:bt];
        
        [bt setTitleColor:yellowBoderColor forState:UIControlStateSelected];
         [bt setTitleColor:publishTextColor forState:UIControlStateNormal];
        [bt setTitle:dict[@"name"] forState:UIControlStateNormal];
        bt.titleLabel.font = [UIFont systemFontOfSize:14];
        bt.tag = [dict[@"number"] integerValue];
        [bt setTitleColor:publishTextColor forState:UIControlStateNormal];
        [self.allbts addObject:bt];
        
        //计算X、Y
        int row = i / maxCols;
        int col = i % maxCols;
        CGFloat buttonX = buttonStartX + col * (xMargin + buttonW);
        CGFloat buttonEndY = butttonStartY + row * (buttonH+yMargin);
        [bt  addTarget:self action:@selector(roomBtClick:) forControlEvents:UIControlEventTouchUpInside];
        [roomView addSubview:bgview];
        bgview.frame = CGRectMake(buttonX, buttonEndY, buttonW, buttonH);
        bt.frame = CGRectMake(0, 0, buttonW, buttonH-0.5);
        line.frame = CGRectMake(0, 44-0.5, buttonW, 0.5);
        roomView.clf_height = bgview.clf_bottom;
        self.roomViewH =  bgview.clf_bottom;
    }
    [self addSubview:roomView];
    self.gk_size = CGSizeMake(LFscreenW, roomView.clf_height);
    
    
}
-(void)creategameAreView:(NSMutableArray *)array{
    UIView * gameAreView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LFscreenW, 100)];
      self.gameAreView = gameAreView;
    
    //中间3个按钮
    int maxCols = 1;
    CGFloat buttonStartX = 0;
    CGFloat butttonStartY = 0;
    CGFloat xMargin = 0;
    CGFloat yMargin = 0;
    CGFloat buttonH = 44;
    CGFloat buttonW = (LFscreenW-(maxCols - 1) * xMargin - 2*buttonStartX)/maxCols;
    for (int i = 0; i < array.count; i++) {
        NSDictionary * dict = array[i];
        UIButton * bt = [[UIButton alloc] init];
        UIView * bgview = [[UIView alloc] init];
        UIView * line = [[UIView alloc] init];
        line.backgroundColor = [SVGloble colorWithHexString:@"#E5E7E9"];
        [bgview addSubview:line];
        [bgview addSubview:bt];
        
        [bt setTitleColor:yellowBoderColor forState:UIControlStateSelected];
        [bt setTitleColor:publishTextColor forState:UIControlStateNormal];
        [bt setTitle:dict[@"name"] forState:UIControlStateNormal];
        bt.titleLabel.font = [UIFont systemFontOfSize:14];
        bt.tag = [dict[@"number"] integerValue];
        [bt setTitleColor:[SVGloble colorWithHexString:@"#39404E"] forState:UIControlStateNormal];
        [self.allbts addObject:bt];
      
        //计算X、Y
        int row = i / maxCols;
        int col = i % maxCols;
        CGFloat buttonX = buttonStartX + col * (xMargin + buttonW);
        CGFloat buttonEndY = butttonStartY + row * (buttonH+yMargin);
        [bt  addTarget:self action:@selector(gameAreBtClick:) forControlEvents:UIControlEventTouchUpInside];
        [gameAreView addSubview:bgview];
        bgview.frame = CGRectMake(buttonX, buttonEndY, buttonW, buttonH);
        bt.frame = CGRectMake(0, 0, buttonW, buttonH-0.5);
        line.frame = CGRectMake(0, 44-0.5, buttonW, 0.5);
        gameAreView.clf_height = bgview.clf_bottom;
         self.gameAreViewH =  bgview.clf_bottom;
    }
    [self addSubview:gameAreView];
    self.gk_size = CGSizeMake(LFscreenW, gameAreView.clf_height);
    
    
}
//创建按钮
-(void)createAgmentView:(UIButton *)button{
    UIView * agmentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LFscreenW, 100)];
    self.agmentView = agmentView;
    //中间3个按钮
    int maxCols = 3;
    CGFloat buttonStartX = 35;
    CGFloat butttonStartY = 15;
    CGFloat xMargin = 10;
    CGFloat yMargin = 12;
    CGFloat buttonH = 36;
    CGFloat buttonW = (LFscreenW-(maxCols - 1) * xMargin - 2*buttonStartX)/maxCols;
    for (int i = 0; i < self.dans.count; i++) {
        NSDictionary * dict = self.dans[i];
        YWSelectButton * bt = [[YWSelectButton alloc] init];
        [bt setTitle:dict[@"name"] forState:UIControlStateNormal];
        bt.titleLabel.font = [UIFont systemFontOfSize:14];
        bt.tag = [dict[@"number"] integerValue];
        [bt setTitleColor:[SVGloble colorWithHexString:@"#39404E"] forState:UIControlStateNormal];
        [self.allbts addObject:bt];
        [self selectBtStatus:bt];
        //计算X、Y
        int row = i / maxCols;
        int col = i % maxCols;
        CGFloat buttonX = buttonStartX + col * (xMargin + buttonW);
        CGFloat buttonEndY = butttonStartY + row * (buttonH+yMargin);
        [bt  addTarget:self action:@selector(clickBgBtClick:) forControlEvents:UIControlEventTouchUpInside];
        [agmentView addSubview:bt];
        bt.frame = CGRectMake(buttonX, buttonEndY, buttonW, buttonH);
        agmentView.clf_height = bt.clf_bottom+20;
          self.agmentViewH =  bt.clf_bottom+10;
    }
    [self addSubview:agmentView];
    self.gk_size = CGSizeMake(LFscreenW, agmentView.clf_height);

}
-(void)clickBgBtClick:(YWSelectButton * )bt{
    self.selectAgmentBt.layer.borderColor = deepGrayColor.CGColor;
    self.selectAgmentBt.selected = NO;
    bt.selected = YES;
    self.selectAgmentBt = bt;
    bt.layer.borderColor = yellowBoderColor.CGColor;
    self.sureClick(self.dans[bt.tag] ,1);
}



-(void)gameAreBtClick:(YWSelectButton * )bt{
    self.selectGameBt.backgroundColor = [UIColor whiteColor];
    self.selectGameBt.selected = NO;
    bt.selected = YES;
    self.selectGameBt = bt;
    bt.backgroundColor = bagColor;
    self.sureClick( self.games[bt.tag],2);
}
-(void)roomBtClick:(YWSelectButton * )bt{
    self.selectRoomBt.backgroundColor = [UIColor whiteColor];
    self.selectRoomBt.selected = NO;
    bt.selected = YES;
    self.selectRoomBt = bt;
    bt.backgroundColor = bagColor;
    self.sureClick(self.rooms[bt.tag],3);
}






-(void)selectBtStatus:(UIButton *)bt{
    [bt layercornerRadius:3];
    bt.layer.borderColor = deepGrayColor.CGColor;
    bt.layer.borderWidth = 0.5;
    
}

+(instancetype)loadNameSearchScreenAlertViewXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
@end

