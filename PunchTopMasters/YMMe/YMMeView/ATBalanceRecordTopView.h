//
//  ATBalanceRecordTopView.h
//  Auction
//
//  Created by 蔡路飞 on 2017/11/1.
//  Copyright © 2017年 Cailufei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATBalanceRecordTopView : UIView
+(instancetype)balanceRecordTopView ;
@property (weak, nonatomic) IBOutlet UILabel *balanceLb;
@property (weak, nonatomic) IBOutlet UIButton *rechargeBt;
@property (weak, nonatomic) IBOutlet UIButton *costBt;
@end
