//
//  YWUpDownButton.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/17.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWUpDownButton.h"

@implementation YWUpDownButton
-(void)setup {
     self.imageView.backgroundColor = [SVGloble colorWithHexString:@"#404652"];
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
        //调整图片
        self.imageView.clf_x = 0;
        self.imageView.clf_y = 10;
        self.imageView.clf_width = 50;
        self.imageView.clf_height = 50;
        self.imageView.clf_centerX = self.clf_width/2;
//    self.imageView.clf_size =    self.imageView.size;
//     self.imageView.clf_centerX = self.clf_width/2;
   
        //调整文字
        self.titleLabel.clf_x = 0;
        self.titleLabel.clf_y = self.imageView.clf_bottom+5;
        self.titleLabel.clf_width = self.clf_width;
        self.titleLabel.clf_height = 20;
        self.titleLabel.clf_centerX = self.clf_width/2;
//    CGSize titleSize = self.titleLabel.bounds.size;
//    CGSize imageSize = self.imageView.bounds.size;
//    CGFloat interval = 1.0;
//    self.imageEdgeInsets = UIEdgeInsetsMake(0,titleSize.width + interval, 0, -(titleSize.width + interval));
//    self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize.width + interval), 0, imageSize.width + interval);
}

@end
