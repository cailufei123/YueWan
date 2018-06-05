//
//  YWSearchCell.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/2.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWSearchCell.h"
@interface YWSearchCell()
@property (weak, nonatomic) IBOutlet UIImageView *roomStyle;
@property (weak, nonatomic) IBOutlet UILabel *gameMatchLb;
@property (weak, nonatomic) IBOutlet UILabel *linePeopleLb;
@property (weak, nonatomic) IBOutlet UIImageView *roomMasterIcon;

@property (weak, nonatomic) IBOutlet UILabel *roomSloganLb;
@property (weak, nonatomic) IBOutlet UILabel *roomMasterNameLb;
@property (weak, nonatomic) IBOutlet UIButton *gameAreBt;
@property (weak, nonatomic) IBOutlet UIButton *roomNumberBt;
@property (strong, nonatomic)  NSMutableDictionary *datas;
@property (strong, nonatomic)  NSMutableArray *strs;
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
@property (weak, nonatomic) IBOutlet UILabel *roomPriceLb;
@property (weak, nonatomic) IBOutlet UIButton *roomStatusBt;
@property(nonatomic,strong) NSString *  gameStatus;
//"rewardMode" = 1,
//"status" = 1,
//"gameArea" = 1,
//"userLogo" = http://i3.letvimg.com/lc05_iptv/201712/22/16/22/1c5664aa-25b7-4104-8fe6-ea67493aaf01.png,
//"roomMoney" = 0,
//"segMatch" = 0,
//"updateTime" = 1522756651000,
//"segment" = 5,
//"roomSlogan" = 上分队，来不坑的队友,
//"roomId" = 726106115,
//"productType" = 1,
//"huanChatId" = 45464421466113,
//"currentQueueCount" = 1,
//"gameId" = 0,
//"id" = 48,
//"roomType" = 1,
//"num" = 1,
//"requireQueueCount" = 5,
//"userName" = 132****7551,
//"roomMode" = 1,
//"createTime" = 1522756651000,
//"userId" = 100115769,

//默认队列
@property(nonatomic,strong) NSString *  requireQueueCount;
//当前队列
@property(nonatomic,strong) NSString *  currentQueueCount;
@end
@implementation YWSearchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle =  UITableViewCellSelectionStyleNone;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"searchDatas" ofType:@"plist"];
    self.datas = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    [self.gameAreBt layercornerRadius:2];self.gameAreBt.layer.borderWidth = 0.5;
    [self.roomNumberBt layercornerRadius:2];self.roomNumberBt.layer.borderColor = [SVGloble colorWithHexString:@"#cccccc"].CGColor;self.roomNumberBt.layer.borderWidth = 0.5;
    self.linePeopleLb.layer.borderWidth = 0.5;
}
-(NSMutableArray *)strs{
    if (!_strs) {
        _strs = [NSMutableArray array];
    }
    return _strs;
}
-(void)setSearchModel:(YWSearchModel *)searchModel{
    [self.strs removeAllObjects];
     NSArray * roomModes = self.datas[@"roomModes"];
      NSArray * segMatchsLists = self.datas[@"segMatchsLists"];
    _searchModel = searchModel;
    if ([searchModel.roomType isEqualToString:@"1"]) {
        [self.roomStyle setImage:[UIImage imageNamed:@"aa_room_list"]];
    }else if ([searchModel.roomType isEqualToString:@"2"]){
         [self.roomStyle setImage:[UIImage imageNamed:@"sb_room_list"]];
    }else if ([searchModel.roomType isEqualToString:@"3"]){
         [self.roomStyle setImage:[UIImage imageNamed:@"xs_room_list"]];
    }
    NSDictionary * d =  roomModes[[searchModel.roomMode integerValue]];
   
 NSArray *array = [searchModel.segMatch componentsSeparatedByString:@","];//#为分隔符
    LFLog(@"%@  %@",searchModel.segMatch,array);
    for (NSString * st  in array) {
        if (st.length) {
            NSDictionary * dc = segMatchsLists[[st integerValue]];
            [self.strs addObject:dc[@"name"]];
        }
        
    }
    NSString *laststr = [self.strs componentsJoinedByString:@" "];//#为分隔符
     self.gameMatchLb.text =[NSString stringWithFormat:@"%@ | 要求：%@",d[@"name"],laststr];
    if ([searchModel.gameArea isEqualToString:@"1"]) {
        self.gameAreBt.selected = YES;self.gameAreBt.layer.borderColor = [SVGloble colorWithHexString:@"#6FA4FF"].CGColor;
    }else if ([searchModel.gameArea isEqualToString:@"2"]){
        self.gameAreBt.selected = NO;self.gameAreBt.layer.borderColor = [SVGloble colorWithHexString:@"#4DC427"].CGColor;
    }
    [self. roomMasterIcon sd_setImageWithURL:[NSURL URLWithString:searchModel.userLogo] placeholderImage:nil];
    
    LFLog(@"%@",searchModel.roomPass)
    if ([searchModel.roomPass isEqualToString:@"null"]||searchModel.roomPass.length<=0) {
       
          self.roomNumberBt.selected = NO;
       
    }else{
         self.roomNumberBt.selected = YES;
       
    }
     [self.roomNumberBt setTitle:[NSString stringWithFormat:@"房号：%@",searchModel.roomId] forState:UIControlStateNormal];
    self.linePeopleLb.text = [NSString stringWithFormat:@"%@/%@",searchModel.currentQueueCount,searchModel.requireQueueCount];
     self.roomMasterNameLb.text =  [NSString stringWithFormat:@"房主：%@",searchModel.userName];
    self.roomSloganLb.text =  searchModel.roomSlogan.length?searchModel.roomSlogan:@"上分队，来不坑的队友";
     self.roomSloganLb.text =  searchModel.roomSlogan.length?searchModel.roomSlogan:@"上分队，来不坑的队友";
    if ([searchModel.gameStatus isEqualToString:@"0"]) {
        
    }else if ([searchModel.gameStatus isEqualToString:@"0"]){// 0：未开始；1、启动中(房主点击唤起游戏) 2、游戏中(客服收到链接已开始游戏) 3、结算中，(房主手动点击结束游戏) 4、游戏结束；
        [self.roomStatusBt setTitle:@"等待中" forState:UIControlStateNormal];
    }else if ([searchModel.gameStatus isEqualToString:@"1"]){
         [self.roomStatusBt setTitle:@"启动中" forState:UIControlStateNormal];
    }else if ([searchModel.gameStatus isEqualToString:@"2"]){
         [self.roomStatusBt setTitle:@"游戏中" forState:UIControlStateNormal];
    }else if ([searchModel.gameStatus isEqualToString:@"3"]){
         [self.roomStatusBt setTitle:@"结算中" forState:UIControlStateNormal];
    }else if ([searchModel.gameStatus isEqualToString:@"4"]){
         [self.roomStatusBt setTitle:@"游戏结束" forState:UIControlStateNormal];
    }
    
    if ([searchModel.roomType isEqualToString:@"1"]) { // 房间类型 1、AA制 2、撒币 3、 悬赏
        // 房间费用 当AA制此值为房间费 撒币和悬赏为房主出价金额
        self.roomPriceLb.text = [NSString stringWithFormat:@"房间费%@元",searchModel.roomMoney];
    }else if ([searchModel.roomType isEqualToString:@"2"]){
        if ([searchModel.rewardMode isEqualToString:@"1"]) {
             self.roomPriceLb.text = [NSString stringWithFormat:@"平分%@元",searchModel.roomMoney];
        }else if ([searchModel.gameStatus isEqualToString:@"2"]){
              self.roomPriceLb.text = [NSString stringWithFormat:@"拼手气%@元",searchModel.roomMoney];
        }
      
    }else if ([searchModel.roomType isEqualToString:@"3"]){
          self.roomPriceLb.text = [NSString stringWithFormat:@"MVP得%@元",searchModel.roomMoney];
    }
  
}
@end
