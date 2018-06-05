//
//  YWSelectButton.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/3/29.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWSelectButton.h"

@implementation YWSelectButton

-(void)setup {
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"select_bt_image"] forState:UIControlStateSelected];
}
-(instancetype)init{
    
    self = [super init];
    if (self) {
        [self setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"select_bt_image"] forState:UIControlStateSelected];
        [self setup];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"select_bt_image"] forState:UIControlStateSelected];
        [self setup];
    }
    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

-(void)layoutSubviews {
    [super layoutSubviews];
        //调整图片
//        self.imageView.clf_x = 0;
//        self.imageView.clf_y = 10;
        self.imageView.clf_width = 14;
        self.imageView.clf_height = 14;
        self.imageView.clf_bottom = self.clf_height;
        self.imageView.clf_right = self.clf_width;
//        //调整文字
//        self.titleLabel.clf_x = 0;
//        self.titleLabel.clf_y = self.imageView.clf_bottom;
//        self.titleLabel.clf_width = self.clf_width;
//        self.titleLabel.clf_height = 20;
        self.titleLabel.clf_centerX = self.clf_width/2;
//    CGSize titleSize = self.titleLabel.bounds.size;
//    CGSize imageSize = self.imageView.bounds.size;
//    CGFloat interval = 1.0;
//    self.imageEdgeInsets = UIEdgeInsetsMake(0,titleSize.width + interval, 0, -(titleSize.width + interval));
//    self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize.width + interval), 0, imageSize.width + interval);
}
@end
