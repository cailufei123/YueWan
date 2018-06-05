//
//  ATBagValueView.m
//  Auction
//
//  Created by 蔡路飞 on 2017/11/7.
//  Copyright © 2017年 Cailufei. All rights reserved.
//

#import "ATBagValueView.h"
@implementation ATBagValueView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal] ;
        [self setBackgroundImage:[UIImage resizedImage:@"main_badge1"] forState:UIControlStateNormal];
        // 按钮的高度就是背景图片的高度
        self.height = self.currentBackgroundImage.size.height;
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = [badgeValue copy];
    
    // 设置文字
    [self setTitle:badgeValue forState:UIControlStateNormal];
    
    // 根据文字计算自己的尺寸self.titleLabel.font
    CGFloat titleW = [NSString textF:badgeValue textSizeH:15 textFont:11];
    CGFloat bgW = self.currentBackgroundImage.size.width;
    if (titleW < bgW) {
        self.width = bgW;
    } else {
        self.width = titleW + 10;
    }
}

@end

