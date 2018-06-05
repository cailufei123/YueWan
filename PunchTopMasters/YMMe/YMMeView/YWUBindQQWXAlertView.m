//
//  YWUBindQQWXAlertView.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/23.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWUBindQQWXAlertView.h"
@interface YWUBindQQWXAlertView()
@property (weak, nonatomic) IBOutlet UIButton *bindBt;
@property (weak, nonatomic) IBOutlet UIButton *canleBt;
@property (weak, nonatomic) IBOutlet UIButton *colseBt;

@end
@implementation YWUBindQQWXAlertView

-(void)awakeFromNib{
    [super awakeFromNib];
    [self.bindBt addTarget:self action:@selector(bindBtClick) forControlEvents:UIControlEventTouchUpInside];
     [self.canleBt addTarget:self action:@selector(canleBtClick) forControlEvents:UIControlEventTouchUpInside];
      [self.colseBt addTarget:self action:@selector(canleBtClick) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)bindBtClick{
      [GKCover hideCover];
    self.bindqqWx();
}
-(void)canleBtClick{
    [GKCover hideCover];
}

+(instancetype)loadNameUBindQQWXAlertViewXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
@end
