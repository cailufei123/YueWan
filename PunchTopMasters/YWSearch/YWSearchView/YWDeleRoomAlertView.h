//
//  YWDeleRoomAlertView.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/15.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YWDeleRoomAlertView : UIView
+(instancetype)loadNameDeleRoomAlertViewXib ;
@property (weak, nonatomic) IBOutlet UIImageView *alertImg;
@property (weak, nonatomic) IBOutlet UIButton *closeBt;
@property (weak, nonatomic) IBOutlet UILabel *messageLb;
@property (weak, nonatomic) IBOutlet UIButton *sureBt;
@property (weak, nonatomic) IBOutlet UIButton *cancelBt;
@end
