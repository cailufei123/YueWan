//
//  ATPresentCionViewCell.h
//  Auction
//
//  Created by 蔡路飞 on 2017/10/31.
//  Copyright © 2017年 Cailufei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATBalanceModel.h"
@interface ATPresentCionViewCell : UITableViewCell
@property(nonatomic,strong) ATBalanceModel * balanceModel;
@property(nonatomic,strong) BalanceModel * recordListModel;
@end
