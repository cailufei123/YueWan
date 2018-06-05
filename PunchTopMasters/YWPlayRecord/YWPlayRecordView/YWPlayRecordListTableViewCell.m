//
//  YWPlayRecordListTableViewCell.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/5/4.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWPlayRecordListTableViewCell.h"
@interface YWPlayRecordListTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UILabel *roomTypeLb;
@property (weak, nonatomic) IBOutlet UILabel *playTimeLb;
@property (weak, nonatomic) IBOutlet UILabel *playStatusLb;

@property (weak, nonatomic) IBOutlet UIButton *chackBt;
@property (copy, nonatomic)  NSString * gameArea;
@property (copy, nonatomic)  NSString * roomMode;
@property (copy, nonatomic)  NSString * roomType;
@end
@implementation YWPlayRecordListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.chackBt addTarget:self action:@selector(chackBtClick) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)chackBtClick{
    self.enterDetails(_playRcordModel);
}
-(void)setPlayRcordModel:(YWPlayRcordModel *)playRcordModel{
    _playRcordModel = playRcordModel;
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:playRcordModel.roomUserIcon] placeholderImage:nil];
    if ([playRcordModel.gameArea isEqualToString:@"1"]) {
        self.gameArea = @"QQ区";
    }else{
        self.gameArea = @"微信区";
    }
    if ([playRcordModel.roomMode isEqualToString:@"1"]) {// 1、多人排位 2、五人排位 3、多人对战',
        self.roomMode = @"多人排位";
    }else if ([playRcordModel.roomMode isEqualToString:@"2"]){
        self.roomMode = @"五人排位";
    }else if ([playRcordModel.roomMode isEqualToString:@"3"]){
        self.roomMode = @"对战";
    }
    if ([playRcordModel.roomType isEqualToString:@"1"]) {// 1、多人排位 2、五人排位 3、多人对战',
        self.roomType = @"AA房间";
    }else if ([playRcordModel.roomType isEqualToString:@"2"]){
        self.roomType = @"撒币房";
    }else if ([playRcordModel.roomType isEqualToString:@"3"]){
        self.roomType = @"悬赏房";
    }
    
      self.roomTypeLb.text = [NSString stringWithFormat:@"%@|%@|%@",self.roomType,self.gameArea,self.roomMode];
    self.playTimeLb.text = playRcordModel.createTime;
    
    self.playStatusLb.backgroundColor = [SVGloble colorWithHexString:@"#606671"];
    self.playStatusLb.textColor = [UIColor whiteColor];
    self.chackBt.layer.borderColor = [SVGloble colorWithHexString:@"#999999"].CGColor;
    self.chackBt.layer.borderWidth = 0.5;
    self.chackBt.backgroundColor = [UIColor whiteColor];
    self.chackBt.selected = YES;
 
    if ([playRcordModel.status isEqualToString:@"1"]) {
         self.playStatusLb.text = @"游戏中";
    }else if ([playRcordModel.status isEqualToString:@"2"]){
         self.playStatusLb.text = @"战绩待汇报";
          self.chackBt.backgroundColor = yellowBoderColor;
        self.chackBt.selected = NO;;
           self.chackBt.layer.borderWidth = 0;
    }else if ([playRcordModel.status isEqualToString:@"4"]){
         self.playStatusLb.text = @"战绩审核中";
    }else if ([playRcordModel.status isEqualToString:@"5"]){
         self.playStatusLb.text = @"战绩待确认";
    }else if ([playRcordModel.status isEqualToString:@"201"]){
         self.playStatusLb.text = @"战绩已超时";
    }else if ([playRcordModel.status isEqualToString:@"101"]){
         self.playStatusLb.text = @"战绩已确认";
    }else if ([playRcordModel.status isEqualToString:@"102"]){
         self.playStatusLb.text = @"被驳回";
        self.playStatusLb.textColor = [SVGloble colorWithHexString:@"#242635"];
           self.playStatusLb.backgroundColor = yellowBoderColor;
    }else if ([playRcordModel.status isEqualToString:@"103"]){
         self.playStatusLb.text = @"已完成";
    }else if ([playRcordModel.status isEqualToString:@"202"]){
         self.playStatusLb.text = @"战绩已失效";
    }
   
}

@end
