//
//  YWEnterGameThirdStepAlertView.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/23.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWEnterGameThirdStepAlertView.h"
@interface YWEnterGameThirdStepAlertView()
@property (weak, nonatomic) IBOutlet UIButton *closeBt;



@end
@implementation YWEnterGameThirdStepAlertView


-(void)awakeFromNib{
    [super awakeFromNib];
    [SVGloble gradientLayer:self.enterGameBt];
    //    [self.nextStepBt addTarget:self action:@selector(followBtClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.closeBt addTarget:self action:@selector(closeBtClick) forControlEvents:UIControlEventTouchUpInside];
     
    NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:@"已邀请但房客未进入游戏 >"];
    
    //设置下划线...
    /*
     NSUnderlineStyleNone                                    = 0x00, 无下划线
     NSUnderlineStyleSingle                                  = 0x01, 单行下划线
     NSUnderlineStyleThick NS_ENUM_AVAILABLE(10_0, 7_0)      = 0x02, 粗的下划线
     NSUnderlineStyleDouble NS_ENUM_AVAILABLE(10_0, 7_0)     = 0x09, 双下划线
     */
    [tncString addAttribute:NSUnderlineStyleAttributeName
                      value:@(NSUnderlineStyleSingle)
                      range:(NSRange){0,[tncString length]}];
    //此时如果设置字体颜色要这样
    [tncString addAttribute:NSForegroundColorAttributeName value:[SVGloble colorFromHexRGB:@"#414754"]  range:NSMakeRange(0,[tncString length])];
    
    //设置下划线颜色...
    [tncString addAttribute:NSUnderlineColorAttributeName value:[SVGloble colorFromHexRGB:@"#414754"] range:(NSRange){0,[tncString length]}];
    [self.wentiBt setAttributedTitle:tncString forState:UIControlStateNormal];
}
-(void)closeBtClick{
    [GKCover hideCover];
}
+(instancetype)loadNameEnterGameThirdStepAlertViewXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

@end
