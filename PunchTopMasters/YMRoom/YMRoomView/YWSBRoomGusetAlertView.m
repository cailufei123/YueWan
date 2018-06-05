//
//  YWSBRoomGusetAlertView.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/25.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWSBRoomGusetAlertView.h"
@interface YWSBRoomGusetAlertView()
@property (weak, nonatomic) IBOutlet UIButton *closeBt;
@end
@implementation YWSBRoomGusetAlertView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self.closeBt addTarget:self action:@selector(closeBtClick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)closeBtClick{
    [GKCover hideCover];
}
+(instancetype)loadNameSBRoomGusetAlertViewXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
- (IBAction)chackPlayGameRecordBtClick:(id)sender {
}
@end
