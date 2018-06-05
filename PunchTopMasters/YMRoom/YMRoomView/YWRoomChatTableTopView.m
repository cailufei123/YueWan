//
//  YWRoomChatTableTopView.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/12.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWRoomChatTableTopView.h"

@implementation YWRoomChatTableTopView
-(void)awakeFromNib{
    
}
+(instancetype)loadNameRoomChatTableTopViewXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
@end
