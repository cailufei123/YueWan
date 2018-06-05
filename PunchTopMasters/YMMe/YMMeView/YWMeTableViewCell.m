//
//  YWMeTableViewCell.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/27.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWMeTableViewCell.h"
@interface YWMeTableViewCell()
@property (weak, nonatomic) IBOutlet UIButton *iconBtimg;
@property (weak, nonatomic) IBOutlet UILabel *titlenameLb;

@end
@implementation YWMeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)setMeTitleItem:(YWMeTitleItem *)meTitleItem{
    [self.iconBtimg setImage:[UIImage imageNamed:meTitleItem.imageName] forState:UIControlStateNormal];
    self.titlenameLb.text = meTitleItem.title;
    
}

@end

