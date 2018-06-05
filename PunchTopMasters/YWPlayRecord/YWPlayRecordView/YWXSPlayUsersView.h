//
//  YWXSPlayUsersView.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/5/8.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YWPlayRecordDateilsModel.h"
@interface YWXSPlayUsersView : UIView
@property(nonatomic,strong) YWPvosModel * otherModel;
@property(nonatomic,strong) YWPvosModel * otherModel1;
@property(nonatomic,copy) void (^refreRecord)(void);
@property(nonatomic,strong) YWPlayRecordDateilsModel * playRecordDateilsModel;

+(instancetype)loadNameXSPlayUsersView;
@end
