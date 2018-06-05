//
//  YWPriceBgView.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/3/30.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YWPriceBgView : UIView
@property(nonatomic,strong)NSString * statusStr;
@property(nonatomic,copy)void(^pirceStr)(NSString *);
@end
