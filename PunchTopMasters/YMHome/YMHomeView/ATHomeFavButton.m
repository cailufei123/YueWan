//
//  ATHomeFavButton.m
//  Auction
//
//  Created by 蔡路飞 on 2017/9/22.
//  Copyright © 2017年 Cailufei. All rights reserved.
//

#import "ATHomeFavButton.h"

@implementation ATHomeFavButton

-(void)setup {
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
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
//    //调整图片
//    self.imageView.clf_x = 0;
//    self.imageView.clf_y = 10;
//    self.imageView.clf_width = 16;
//    self.imageView.clf_height = 16;
//    self.imageView.clf_centerX = self.clf_width/2;
//    //调整文字
//    self.titleLabel.clf_x = 0;
//    self.titleLabel.clf_y = self.imageView.clf_bottom;
//    self.titleLabel.clf_width = self.clf_width;
//    self.titleLabel.clf_height = 20;
//    self.titleLabel.clf_centerX = self.clf_width/2;
    CGSize titleSize = self.titleLabel.bounds.size;
    CGSize imageSize = self.imageView.bounds.size;
    CGFloat interval = 1.0;
    self.imageEdgeInsets = UIEdgeInsetsMake(0,titleSize.width + interval, 0, -(titleSize.width + interval));
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize.width + interval), 0, imageSize.width + interval);
}

@end
