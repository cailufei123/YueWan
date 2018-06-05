//
//  YWRoomChatTableViewCell.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/12.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMessageModel.h"
@interface YWRoomChatTableViewCell : UITableViewCell

@property (strong, nonatomic) id<IMessageModel> model;
/*
 *
 *
 *  @param  消息model
 *
 *  @result cell高度
 */
+ (CGFloat)cellHeightWithModel:(id<IMessageModel>)model;
@end
