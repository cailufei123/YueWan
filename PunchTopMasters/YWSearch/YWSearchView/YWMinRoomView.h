//
//  YWMinRoomView.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/10.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YWRoomModel.h"
@interface YWMinRoomView : UIView
+(instancetype)loadNameMinRoomViewXib ;
@property(nonatomic,strong) YWMyRoomModel * myRoomModel;
@property(nonatomic,copy)void(^laveRoomHideView)();
@property(nonatomic,copy)void(^masterDissolutionRoom)(void);
@end
