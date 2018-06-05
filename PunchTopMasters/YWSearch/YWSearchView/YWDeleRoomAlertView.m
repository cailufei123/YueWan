//
//  YWDeleRoomAlertView.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/15.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWDeleRoomAlertView.h"
@interface YWDeleRoomAlertView()

@end
@implementation YWDeleRoomAlertView

-(void)awakeFromNib{
    
    [super awakeFromNib];
    [self.closeBt addTarget:self action:@selector(closeBtClick) forControlEvents:UIControlEventTouchUpInside];
     [self.cancelBt addTarget:self action:@selector(closeBtClick) forControlEvents:UIControlEventTouchUpInside];
  
}
+(instancetype)loadNameDeleRoomAlertViewXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

-(void)closeBtClick{
    [GKCover hideCover];
}

@end
