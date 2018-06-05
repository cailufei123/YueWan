//
//  YWCreteBtView.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/3/27.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YWRoomModel.h"
#import "YWEnterQueueAlertView.h"
@interface YWCreteBtView : UIView
+(instancetype)loadNameCreteBtViewXib;
@property(nonatomic,strong)  YWGameQueueModel *gameQueueModel;
@property(strong,nonatomic) YWRoomModel * roomModel;
@property (weak, nonatomic) IBOutlet UIButton *iocnBt;
@property(strong,nonatomic) YWRoomModel * is;
@property (weak, nonatomic) IBOutlet UIView *iocnBgView;

@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *danLb;
@end

