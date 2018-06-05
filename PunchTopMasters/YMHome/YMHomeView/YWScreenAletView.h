//
//  YWScreenAletView.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/3/28.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YWScreenAletView : UIView
@property(nonatomic,strong)NSMutableArray * array;
@property(nonatomic,copy) void (^sureClickScreenAletView)(NSMutableDictionary * dict);
+(instancetype)loadNameYWScreenAletViewXib ;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@end
