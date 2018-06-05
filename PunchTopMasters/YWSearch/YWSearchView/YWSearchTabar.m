//
//  YWSearchTabar.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/3.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWSearchTabar.h"

@interface YWSearchTabar()

@property(nonatomic,strong) NSMutableArray * segMatchs;

@end
@implementation YWSearchTabar
-(void)awakeFromNib{
    [super awakeFromNib];
    self.segMatchs = [NSMutableArray arrayWithObjects:self.segmentBt,self.gameAreabt,self.roomtypeBt, nil];
    for (int i = 0; i<self.segMatchs.count; i++) {
        YWSelectButton *button = self.segMatchs[i];
        button.tag = i+1;
        [button addTarget:self action:@selector(gameMatchClick:) forControlEvents:UIControlEventTouchUpInside];
    }
  
}

-(void)gameMatchClick:(ATHomeFavButton *)bt{

    if ( self.selectMatchBt == bt) {
        if (bt.selected) {
            bt.selected = NO;
        }else{
            bt.selected = YES;
        }
    }else{
         self.selectMatchBt.selected = NO;
         bt.selected = YES;
         self.selectMatchBt = bt;
    }
    if (self.sureClickSearchTabar) {
        self.sureClickSearchTabar(bt);
    }
    
}

+(instancetype)loadNameSearchTabarXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
@end
