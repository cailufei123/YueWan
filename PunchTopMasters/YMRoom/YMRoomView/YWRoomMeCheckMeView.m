//
//  YWRoomMeCheckMeView.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/18.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWRoomMeCheckMeView.h"


@interface YWRoomMeCheckMeView()
@property (weak, nonatomic) IBOutlet UIButton *userImgIcon;

@property (weak, nonatomic) IBOutlet UILabel *userNameLb;
@property (weak, nonatomic) IBOutlet UILabel *openNumberLb;
@property (weak, nonatomic) IBOutlet UILabel *winNumberLb;
@property (weak, nonatomic) IBOutlet UILabel *MVPnumber;



@end
@implementation YWRoomMeCheckMeView
-(void)awakeFromNib{
    [super awakeFromNib];
    [SVGloble gradientLayer:self.followBt];
   
    [self.followBt addTarget:self action:@selector(followBtClick:) forControlEvents:UIControlEventTouchUpInside];
  
    
    
    
}
-(void)followBtClick:(UIButton *)bt{
   
    if (self.isPointMaster) {
        self.kickRoom();
    }else{
        NSMutableDictionary * quitdic = diction;quitdic[@"token"] =  loginToken;quitdic[@"gameId"] =  _roomModel.roomInfo.gameId;quitdic[@"roomId"] =  _roomModel.roomInfo.roomId;
        [YWRequestData quitQueueeDict:quitdic success:^(id responseObj) {
            [GKCover hideCover];
            self.userQuitQueue();
            [LFNSNOTI postNotificationName:enterQueueRefresh object:quitQueue];
        }];
        
    }
    
   
    
}

-(void)setUserHomePageModel:(YMMeModel *)userHomePageModel{
    _userHomePageModel = userHomePageModel;
    [self.userImgIcon sd_setImageWithURL:[NSURL URLWithString:userHomePageModel.user.icon] forState:UIControlStateNormal];
    self.openNumberLb.text =[NSString stringWithFormat:@"开黑数： %@",userHomePageModel.gameCount];
    self.winNumberLb.text =[NSString stringWithFormat:@"获赞数： %@",userHomePageModel.userStat.commentScore];
    self.MVPnumber.text =[NSString stringWithFormat:@"MVP： %@",userHomePageModel.mvpCount];
    self.userNameLb.text = userHomePageModel.user.name;
  
  
   
}
+(instancetype)loadNameRoomMeCheckMeViewXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
@end
