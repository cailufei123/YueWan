//
//  LFTitleButton.m
//  LF百思不得姐
//
//  Created by 蔡路飞 on 16/6/27.
//  Copyright © 2016年 pecoo. All rights reserved.
//

#import "LFTitleButton.h"

@implementation LFTitleButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置按钮颜色
        // self.selected = NO;
        [self setTitleColor:[SVGloble colorWithHexString:@"#515661"] forState:UIControlStateNormal];
        // self.selected = YES;
        [self setTitleColor:[SVGloble colorWithHexString:@"#515661"]  forState:UIControlStateSelected];
        self.titleLabel.font = [UIFont systemFontOfSize:14];

    }
    return self;
}
@end
