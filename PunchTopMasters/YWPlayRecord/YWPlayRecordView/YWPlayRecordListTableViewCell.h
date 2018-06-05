//
//  YWPlayRecordListTableViewCell.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/5/4.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YWPlayRcordModel.h"
@interface YWPlayRecordListTableViewCell : UITableViewCell
@property(nonatomic,strong) YWPlayRcordModel * playRcordModel;
@property(nonatomic,strong) void (^enterDetails)(YWPlayRcordModel * playRcordModel);
@end
