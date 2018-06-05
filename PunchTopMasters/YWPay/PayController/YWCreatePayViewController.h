//
//  YWCreatePayViewController.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/5/2.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YWRoomModel.h"
@interface YWCreatePayViewController : UIViewController

@property(nonatomic,copy)void(^payVerificationS) (void) ;
@property(nonatomic,strong) YWRoomModel * createModel;
@property(nonatomic,strong) NSString * callbackType;
//@property(nonatomic,assign) BOOL isMaster;
@property(nonatomic,copy)NSString * segment;
@end
