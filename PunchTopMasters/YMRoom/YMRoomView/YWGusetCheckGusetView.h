//
//  YWGusetCheckGusetView.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/18.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMMeModel.h"
#import "YWRoomModel.h"
@interface YWGusetCheckGusetView : UIView
+(instancetype)loadNameGusetCheckGusetViewXib  ;
@property(nonatomic,strong)  YMMeModel *userHomePageModel;
@property (weak, nonatomic) IBOutlet UILabel *userSegmetLb;
@property(strong,nonatomic) YWRoomModel * roomModel;
@end
