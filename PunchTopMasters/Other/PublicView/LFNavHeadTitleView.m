
//
//  NavHeadTitleView.m
//  京师杏林
//
//  Created by sjt on 15/11/12.
//  Copyright © 2015年 MaNingbo. All rights reserved.
//

#import "LFNavHeadTitleView.h"
@interface LFNavHeadTitleView()
//设置中间的文字
@property(nonatomic,strong)UILabel *label;

//右边的按钮
@property(nonatomic,strong)UIButton * rightBtn;
@property (strong, nonatomic)  ATBagValueView *bageView;
@end
@implementation LFNavHeadTitleView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
        
        NSLog(@"frame.size.width%zd,%zd",frame.size.width,frame.size.height);
        
        self.headBgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.headBgView.backgroundColor=[UIColor clearColor];
        self.headBgView.userInteractionEnabled = YES;
//        self.headBgView.image = [UIImage imageNamed:@"nav－-bar"];
        //刚进去的时候隐藏自定义的View
        self.headBgView.alpha=0;
//        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 63.5, WIDTH, 0.5)];
//        label.backgroundColor=[UIColor grayColor];
//        [self.headBgView addSubview:label];
        [self addSubview:self.headBgView];
        
        //左边的按钮
        self.back=[UIButton buttonWithType:UIButtonTypeCustom];
        self.back.backgroundColor=[UIColor clearColor];
        self.back.frame=CGRectMake(5, 20, 44, 44);
        [self.back addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.back];
        
        //清空View的背景颜色
        self.backgroundColor=[UIColor clearColor];
        
        //设置中间的文字
        self.label=[[UILabel alloc]initWithFrame:CGRectMake(44, 20, frame.size.width-44-44, 44)];
        self.label.backgroundColor = [UIColor clearColor];
        self.label.textAlignment=NSTextAlignmentCenter;
        self.label.font = [UIFont systemFontOfSize:18];
        [self addSubview:self.label];
        
        //设置右边的按钮
        self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        self.rightBtn.backgroundColor = [UIColor clearColor];
        self.rightBtn.frame = CGRectMake(self.frame.size.width-46, 20, 44, 44);
        self.bageView.clf_x =  25;
        self.bageView.clf_y = 7;
        [self.rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.rightBtn];
        self.rightBtn.userInteractionEnabled = YES;
        
//        @weakify(self);
//        [self addColorChangedBlock:^{
//            @strongify(self);
//            self.headBgView.normalBackgroundColor = [UIColor purpleColor];
//            self.headBgView.nightBackgroundColor=RGB(1, 7, 38);
//            self.rightBtn.nightTitleColor=RGB(150, 150, 150);

//        }];
        
    }
    return self;
}
- (ATBagValueView *)bageView
{
    if (_bageView == nil) {
        self.bageView = [[ATBagValueView alloc] init];
        [self.rightBtn addSubview:self.bageView];
    }
    return _bageView;
}
-(void)setBadgeValueNumber:(NSString *)badgeValueNumber{
    self.bageView.badgeValue = badgeValueNumber;
    if ([badgeValueNumber doubleValue]<=0) {
        self.bageView.hidden = YES;
    }else{
        self.bageView.hidden = NO;
    }
}
-(void)setBackTitleImage:(NSString *)backTitleImage
{
    _backTitleImage=backTitleImage;
    [self.back setImage:[UIImage imageNamed:_backTitleImage] forState:UIControlStateNormal];
    self.back.size = [[UIImage imageNamed:_backTitleImage] size];
    self.back.clf_bottom = self.clf_bottom-10;
}
-(void)setRightImageView:(NSString *)rightImageView
{
    _rightImageView=rightImageView;
    [self.rightBtn setImage:[UIImage imageNamed:_rightImageView] forState:UIControlStateNormal];
    //[self.rightBtn setTitle:rightImageView forState:UIControlStateNormal];
}
-(void)setRightTitleImage:(NSString *)rightImageView
{
    _rightImageView=rightImageView;
    [self.rightBtn setImage:[UIImage imageNamed:_rightImageView] forState:UIControlStateNormal];
}

-(void)setTitle:(NSString *)title{
    _title=title;
    self.label.text=title;
    //self.label.textColor=[UIColor whiteColor];
    //[self jianBian];
    
}

-(void)setColor:(UIColor *)color{
    _color=color;
    self.label.textColor=color;
    //[self jianBian];
}

//返回按钮
-(void)backClick{
    if ([_delegate respondsToSelector:@selector(NavHeadback)] ) {
        [_delegate NavHeadback];
    }
}
//右边按钮
-(void)rightBtnClick{
    if ([_delegate respondsToSelector:@selector(NavHeadToRight)]) {
        [_delegate NavHeadToRight];
    }
}
-(void)jianBian{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame =self.label.frame;
    gradientLayer.colors = @[(id)[UIColor colorWithRed:222/225.0 green:98/255.0 blue:26/255.0 alpha:0.1].CGColor, (id)[UIColor colorWithRed:245/225.0 green:163/255.0 blue:17/255.0 alpha:1].CGColor];
    gradientLayer.mask = self.label.layer;
    [self.layer addSublayer:gradientLayer];
    self.label.frame = gradientLayer.bounds;
}

@end
