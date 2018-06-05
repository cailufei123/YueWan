//
//  YWPlayUsersView.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/5/7.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWPlayUsersView.h"
@interface YWPlayUsersView()
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UILabel *userNameLb;

@property (weak, nonatomic) IBOutlet UILabel *userStatusLb;
@property (weak, nonatomic) IBOutlet UIButton *zanBt;
@property (weak, nonatomic) IBOutlet UILabel *winMonyLb;
@end
@implementation YWPlayUsersView
-(void)awakeFromNib {
    [super awakeFromNib];
    
       self.autoresizesSubviews = NO;
       self.autoresizingMask = NO;
    [self.zanBt addTarget:self action:@selector(zanBtClick:) forControlEvents:UIControlEventTouchUpInside];
}

+(instancetype)loadNamePlayUserView{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
-(void)setOtherModel:(YWPvosModel *)otherModel{
    _otherModel = otherModel;
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:otherModel.userIcon]];
    self.userNameLb.text = otherModel.userName;
    
   
    if ([otherModel.isComment isEqualToString:@"0"]){
        self.zanBt.selected = NO;
    }else{
        self.zanBt.selected = YES;
    }
    
    if ([self.playRecordDateilsModel.roomInfo.rewardMode isEqualToString:@"1"] ) {
           self.userStatusLb.hidden = YES;
        
    }else{
        self.userStatusLb.hidden = NO;
    }
    
    
    if ([otherModel.userId isEqualToString:loginUid]){
        
        self.zanBt.hidden = YES;
    }else{
        self.zanBt.hidden = NO;
    }
    
    if ([otherModel.rewardMode isEqualToString:@"1"] ) {
        self.userStatusLb.hidden =YES;
    }else{
        if ([otherModel.shouqi isEqualToString:@"1"]) {
            self.userStatusLb.text = @"手气最佳";
            self.userStatusLb.hidden = NO;
            
        }else{
            self.userStatusLb.hidden = YES;
        }
      
    }
    
    self.winMonyLb.text = [NSString stringWithFormat:@"%0.1f元",[otherModel.winMoney doubleValue]];
    
    
    
    
    
    
    
    
}
-(void)zanBtClick:(UIButton * )bt{
    NSMutableDictionary * praiseDict = diction;
    praiseDict[@"token"] = loginToken;
    praiseDict[@"userGameFlowId"] = _otherModel.userGameFlowId;
    praiseDict[@"userId"] =  _otherModel.userId;
    if (bt.selected == YES) {
          praiseDict[@"c"] = @"0";
    }else{
          praiseDict[@"c"] = @"1";
    }
    [YWRequestData praiseDict:praiseDict success:^(id responseObj) {
        if (bt.selected == YES) {
            bt.selected = NO;
        }else{
              bt.selected = YES;
        }
    }];
    
}

@end
