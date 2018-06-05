//
//  YWRoomCountTableViewCell.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/5/10.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWRoomCountTableViewCell.h"
@interface YWRoomCountTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *usericon;
@property (weak, nonatomic) IBOutlet UILabel *userNameLb;
@property (weak, nonatomic) IBOutlet UILabel *sagmentLb;
@property (weak, nonatomic) IBOutlet UILabel *userStatusLb;
@property (weak, nonatomic) IBOutlet UIButton *followBt;

@property (weak, nonatomic) IBOutlet UIButton *kickBt;

@end
@implementation YWRoomCountTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.kickBt.layer.borderWidth = 0.5;
     self.kickBt.layer.borderColor = deepGrayColor.CGColor;
    
    [self.followBt addTarget:self action:@selector(followBtClick:) forControlEvents:UIControlEventTouchUpInside];
     [self.kickBt addTarget:self action:@selector(kickBtClick) forControlEvents:UIControlEventTouchUpInside];
   
}
-(void)kickBtClick{
    if ([_roomPersonModel.queue_level isEqualToString:@"2"]) {
        self.kickQueue(_roomPersonModel);
    }else if ([_roomPersonModel.queue_level isEqualToString:@"3"]){
          self.kickguest(_roomPersonModel);
    }
  
    
}
-(void)followBtClick:(UIButton *)bt{
    NSMutableDictionary * followDit = diction;
    followDit[@"token"] = loginToken;
    followDit[@"followUserId"] = _roomPersonModel.userId;
    [YWRequestData followUserDict:followDit success:^(id responseObj) {
        [MBManager showBriefAlert:@"关注成功"];
        self.followBt.selected = YES;
        self.followBt.backgroundColor = [SVGloble colorFromHexString:@"#E7E8E9"];
        self.followBt.userInteractionEnabled = NO;
    }];
}
-(void)setRoomPersonModel:(YWRoomPersonModel *)roomPersonModel{
    _roomPersonModel = roomPersonModel;
    [self.usericon sd_setImageWithURL:[NSURL URLWithString:roomPersonModel.userLogo]];
    self.userNameLb.text = roomPersonModel.userName;
//    NSMutableDictionary *datas = [[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"searchDatas" ofType:@"plist"]];
//    NSArray * array = datas[@"createSegMatchs"];
//    NSDictionary * dict = array[[roomPersonModel.userSeg integerValue]-1];
//    self.sagmentLb.text = dict[@"name"];
    if ([roomPersonModel.queue_level isEqualToString:@"1"]) {
        self.userStatusLb.text = @"房主";  self.userStatusLb.hidden = NO;
        self.userStatusLb.backgroundColor = [SVGloble colorWithHexString:@"#CD5643"];
    }else if  ([roomPersonModel.queue_level isEqualToString:@"2"]){
       
         self.userStatusLb.text = @"队列";  self.userStatusLb.hidden = NO;
         self.userStatusLb.backgroundColor = [SVGloble colorWithHexString:@"#4A5160"];
    }else if  ([roomPersonModel.queue_level isEqualToString:@"3"]){
         self.userStatusLb.text = @"房主";  self.userStatusLb.hidden = YES;
    }
    
    NSMutableDictionary * followExtDit = diction;
    followExtDit[@"token"] = loginToken;
    followExtDit[@"followUserId"] = roomPersonModel.userId;
    [YWRequestData followExitDict:followExtDit success:^(id responseObj) {
        if ([responseObj[@"data"] isEqual:@(0)]) {
            self.followBt.selected = NO;
            self.followBt.backgroundColor = [SVGloble colorWithHexString:@"#FFC542"];
              self.followBt.userInteractionEnabled = YES;
        }else{
            self.followBt.selected = YES;
             self.followBt.backgroundColor = [SVGloble colorWithHexString:@"#E7E8E9"];
            self.followBt.userInteractionEnabled = NO;
           
        }
    }];
    
    if ([self.roomModel.roomInfo.userId isEqualToString:loginUid]) {
        if ([roomPersonModel.userId isEqualToString:loginUid]) {//kan deren
            self.followBt.hidden = YES;
            self.kickBt.hidden = YES;
        }else{
            self.followBt.hidden = NO;
            self.kickBt.hidden = NO;
        }
        
    }else{
        if ([roomPersonModel.userId isEqualToString:loginUid]) {//kan deren
            self.followBt.hidden = YES;
            self.kickBt.hidden = YES;
        }else{
            self.followBt.hidden = NO;
            self.kickBt.hidden = YES;
        }
        
    }
    
   
    
}


@end
