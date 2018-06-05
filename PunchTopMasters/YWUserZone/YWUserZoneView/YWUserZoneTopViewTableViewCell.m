//
//  YWUserZoneTopViewTableViewCell.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/5/8.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWUserZoneTopViewTableViewCell.h"
@interface YWUserZoneTopViewTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *agmentimgIcon;
@property (weak, nonatomic) IBOutlet UILabel *segmentNameLb;
@property (weak, nonatomic) IBOutlet UILabel *playRecordLb;

@end
@implementation YWUserZoneTopViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setUserGameFlowStatM:(YMUserGameFlowStatM *)userGameFlowStatM{
   
    [self.agmentimgIcon setImage:[UIImage imageNamed:[NSString stringWithFormat:@"segment_%@",userGameFlowStatM.stat]]];
    NSMutableDictionary *datas = [[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"searchDatas" ofType:@"plist"]];
    NSArray * array = datas[@"createSegMatchs"];
    NSDictionary * dict = array[[userGameFlowStatM.stat integerValue]-1];
    self.segmentNameLb.text = dict[@"name"];
    
    self.playRecordLb.text = [NSString stringWithFormat:@"我在约玩APP开黑%@局，拿过%@个MVP",userGameFlowStatM.count,userGameFlowStatM.mvp] ;
    if (userGameFlowStatM.playmode) {
        
        if ([userGameFlowStatM.stat isEqualToString:@"1"]) {
              [self.agmentimgIcon setImage:[UIImage imageNamed:@"wupai"]];
             self.segmentNameLb.text = @"五排";
        } else if ([userGameFlowStatM.stat isEqualToString:@"2"]){
               self.segmentNameLb.text = @"多排";
              [self.agmentimgIcon setImage:[UIImage imageNamed:@"duopai"]];
        }else if ([userGameFlowStatM.stat isEqualToString:@"3"]){
               self.segmentNameLb.text = @"对战";
              [self.agmentimgIcon setImage:[UIImage imageNamed:@"duizhan"]];
        }
        
      
    }
    
}
@end
