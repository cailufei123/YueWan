//
//  YWRoomChatModel.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/13.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EaseMessageModel.h"
//#import "IMessageModel.h"
@interface YWRoomChatExtModel : EaseMessageModel
@property(nonatomic,strong)NSString *userName;//扩展字段的名字
@property(nonatomic,strong)NSString *userIcon;//扩展字段的tou'xian
@property(nonatomic,strong)NSString *userId;//扩展字段的Uid
@end
@interface YWRoomChatModel : NSObject<IMessageModel>
@property(nonatomic,strong) YWRoomChatExtModel * easeMessageExtModel;
@end

