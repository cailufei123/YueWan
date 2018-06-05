//
//  YWSearchTabar.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/3.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATHomeFavButton.h"
#import "YWSearchViewController.h"
@interface YWSearchTabar : UIView
+(instancetype)loadNameSearchTabarXib ;
@property(nonatomic,strong)ATHomeFavButton * selectMatchBt;
@property(nonatomic,copy) void (^sureClickSearchTabar)(ATHomeFavButton * selectMatchBt);
@property(nonatomic,strong)YWSearchViewController *searchViewController;
@property (weak, nonatomic) IBOutlet ATHomeFavButton *gameAreabt;
@property (weak, nonatomic) IBOutlet ATHomeFavButton *segmentBt;
@property (weak, nonatomic) IBOutlet ATHomeFavButton *roomtypeBt;
@end
