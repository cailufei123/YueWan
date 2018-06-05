//
//  YWSelectlevelAlertView.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/3/22.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YWSelectlevelAlertView : UIView
+(instancetype)loadNameSelectlevelXib ;
@property(nonatomic,strong)NSMutableArray * array;
@property(nonatomic,copy) void (^sureClickSelectlevelAlertView)(NSMutableDictionary * dict);
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@end
