//
//  SAVoucherAlertView.h
//  SkinAssistant
//
//  Created by 蔡路飞 on 2017/8/18.
//  Copyright © 2017年 LeGame. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SAVourcherModel.h"
@interface SAVoucherAlertView : UIView
+(instancetype)voucherAlertView;
@property (weak, nonatomic) IBOutlet UILabel *moneyNumberLb;
@property (weak, nonatomic) IBOutlet UILabel *limitUseLb;
@property (weak, nonatomic) IBOutlet UILabel *effectiveDateLB;
@property (weak, nonatomic) IBOutlet UIButton *immediatelyUseBt;
@property (copy, nonatomic)  void(^hidenCover)();
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hLyout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *moneyLeftLyout;
@property (strong, nonatomic) SAVourcherModel * vourcherModel;
@property (strong, nonatomic)NSMutableArray * vourcherModels;
@property (strong, nonatomic) SAVourcherModel * firstVourcherModel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dataLeftLyout;
@property (strong, nonatomic)NSString * status;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
