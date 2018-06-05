//
//  YWRoomCountTableViewCell.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/5/10.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YWRoomModel.h"
@interface YWRoomCountTableViewCell : UITableViewCell
@property(nonatomic,strong) YWRoomPersonModel * roomPersonModel;
@property(nonatomic,copy) void (^kickguest) (YWRoomPersonModel * roomPersonModel);
@property(nonatomic,copy) void (^kickQueue) (YWRoomPersonModel * roomPersonModel);
@property(strong,nonatomic) YWRoomModel * roomModel;
@end
