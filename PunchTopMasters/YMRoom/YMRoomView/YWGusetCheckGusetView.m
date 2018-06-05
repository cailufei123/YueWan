//
//  YWGusetCheckGusetView.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/18.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWGusetCheckGusetView.h"
@interface YWGusetCheckGusetView()
@property (weak, nonatomic) IBOutlet UIButton *userImgIcon;

@property (weak, nonatomic) IBOutlet UILabel *userNameLb;
@property (weak, nonatomic) IBOutlet UILabel *openNumberLb;
@property (weak, nonatomic) IBOutlet UILabel *winNumberLb;
@property (weak, nonatomic) IBOutlet UILabel *MVPnumber;

@property (weak, nonatomic) IBOutlet UIButton *followBt;

@property (weak, nonatomic) IBOutlet UIButton *privateChatBt;
@end
@implementation YWGusetCheckGusetView
-(void)awakeFromNib{
    [super awakeFromNib];
    [SVGloble gradientLayer:self.followBt];
    [SVGloble gradientLayer:self.privateChatBt];
    [self.followBt addTarget:self action:@selector(followBtClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.privateChatBt addTarget:self action:@selector(privateChatBtClick) forControlEvents:UIControlEventTouchUpInside];
  
   
    
}
-(void)followBtClick:(UIButton *)bt{
    if ([bt.titleLabel.text isEqualToString:@"已关注"]) {
        [MBManager showBriefAlert:@"已经关注"];
        return;
    }
    
    NSMutableDictionary * followDit = diction;
    followDit[@"token"] = loginToken;
    followDit[@"followUserId"] = _userHomePageModel.user.userId;
    [YWRequestData followUserDict:followDit success:^(id responseObj) {
        [MBManager showBriefAlert:@"关注成功"];
        [bt setTitle:@"已关注" forState:UIControlStateNormal];
    }];
}
-(void)privateChatBtClick{
    [GKCover hideCover];
    NSMutableDictionary * nterChatDit = diction;
    nterChatDit[@"name"] =  _userHomePageModel.user.name;
    nterChatDit[@"huanId"] =  _userHomePageModel.user.huanId;
    nterChatDit[@"icon"] =  _userHomePageModel.user.icon;
    [LFNSNOTI postNotificationName:enterChatPage object:_userHomePageModel.user.huanId userInfo:nterChatDit];
    
    
}
-(void)setUserHomePageModel:(YMMeModel *)userHomePageModel{
    _userHomePageModel = userHomePageModel;
    [self.userImgIcon sd_setImageWithURL:[NSURL URLWithString:userHomePageModel.user.icon] forState:UIControlStateNormal];
    self.openNumberLb.text =[NSString stringWithFormat:@"开黑数： %@",userHomePageModel.gameCount];
    self.winNumberLb.text =[NSString stringWithFormat:@"获赞数： %@",userHomePageModel.userStat.commentScore];
    self.MVPnumber.text =[NSString stringWithFormat:@"MVP： %@",userHomePageModel.mvpCount];
    self.userNameLb.text = userHomePageModel.user.name;
    NSMutableDictionary * followExtDit = diction;
    followExtDit[@"token"] = loginToken;
    followExtDit[@"followUserId"] = userHomePageModel.user.userId;
    [YWRequestData followExitDict:followExtDit success:^(id responseObj) {
        if ([responseObj[@"data"] isEqual:@(0)]) {
            [self.followBt setTitle:@"加关注" forState:UIControlStateNormal];
        }else{
            [self.followBt setTitle:@"已关注" forState:UIControlStateNormal];
        }
    }];
    
}
+(instancetype)loadNameGusetCheckGusetViewXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
@end
