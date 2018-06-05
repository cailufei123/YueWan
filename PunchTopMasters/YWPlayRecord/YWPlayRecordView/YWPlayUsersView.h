//
//  YWPlayUsersView.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/5/7.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YWPlayRecordDateilsModel.h"
@interface YWPlayUsersView : UIView
@property(nonatomic,strong) YWPvosModel * otherModel;
@property(nonatomic,strong) YWPlayRecordDateilsModel * playRecordDateilsModel;
+(instancetype)loadNamePlayUserView;
@end
