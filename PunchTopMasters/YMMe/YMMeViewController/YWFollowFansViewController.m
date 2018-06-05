//
//  YWFollowFansViewController.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/5/11.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWFollowFansViewController.h"
#import "MJCSegmentInterface.h"
#import "YWFollowFansDateilsViewController.h"
@interface YWFollowFansViewController ()<MJCSegmentDelegate>
@property(nonatomic,strong) NSArray * modelArr;
@end

@implementation YWFollowFansViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //    -1:全部；0:进行中;2:待发货;4:待收货;5:待晒单6:已完结
    self.navigationItem.title = @"好友列表";
    NSArray *titlesArr = @[@"关注",@"粉丝"];
    self.modelArr = @[@"0",@"1"];
    
    NSMutableArray *vcArr = [NSMutableArray array];
    for (int i = 0 ; i < titlesArr.count; i++) {//循环创建控制器对象
        YWFollowFansDateilsViewController *vc = [[YWFollowFansDateilsViewController alloc]init];
        [vcArr addObject:vc];
    }
    
    [self setupBasicUIWithTitlesArr:titlesArr vcArr:vcArr];
}


-(void)setupBasicUIWithTitlesArr:(NSArray*)titlesArr vcArr:(NSArray*)vcArr
{

    MJCSegmentInterface *interface = [MJCSegmentInterface jc_initWithFrame:CGRectMake(0,kTopHeight,self.view.jc_width, self.view.jc_height-kTopHeight) interFaceStyleToolsBlock:^(MJCSegmentStylesTools *jc_tools) {
        jc_tools.jc_titleBarStyles(MJCTitlesScrollStyle).
        //          jc_itemSelectedSegmentIndex(self.selectedSegmentIndex).
        jc_titlesViewFrame(CGRectMake(0, 0, self.view.jc_width, 44)).
        jc_titlesViewBackColor([UIColor whiteColor]).
        
        jc_childScollEnabled(YES).
        jc_indicatorsAnimalsEnabled(YES).
        jc_itemTextNormalColor(blackTextColor).
        jc_itemTextSelectedColor(blackTextColor).
        jc_indicatorColor(blackTextColor).
        jc_itemTextGradientEnabled(YES).
        jc_tabItemSizeToFitIsEnabled(NO, NO, YES).
        jc_itemSelectedSegmentIndex(self.selectedSegmentIndex).
        jc_itemEdgeinsets(MJCEdgeInsetsMake(0,15, 0,15, 25)).
        
        jc_itemTextFontSize(15).
        jc_ItemDefaultShowCount(2).
        jc_indicatorFrame(CGRectMake(0, 40-3, self.view.jc_width/titlesArr.count - 15, 2)).
        jc_itemTextFontSize(15).
        jc_indicatorStyles(MJCIndicatorItemTextStyle).
        jc_indicatorFollowEnabled(YES);
        //        jc_childScollAnimalEnabled(YES);
        
        
    }];
    interface.delegate= self;
    [self.view addSubview:interface];
    [interface intoTitlesArray:titlesArr intoChildControllerArray:vcArr hostController:self];
    
    //    [self liebiaoUI:interface.jc_stylesTools];
    
}

-(void)mjc_ClickEventWithItem:(UIButton *)tabItem childsController:(UIViewController *)childsController segmentInterface:(MJCSegmentInterface *)segmentInterface
{
    LFLog(@"%ld",tabItem.tag);
    YWFollowFansDateilsViewController *vc = (YWFollowFansDateilsViewController *)childsController;
    vc.typeStr =  self.modelArr[tabItem.tag];
    
}

-(void)mjc_scrollDidEndDeceleratingWithItem:(UIButton *)tabItem childsController:(UIViewController *)childsController indexPage:(NSInteger)indexPage segmentInterface:(MJCSegmentInterface *)segmentInterface
{
    LFLog(@"%ld",indexPage);
    LFLog(@"%ld",tabItem.tag);
    YWFollowFansDateilsViewController *vc = (YWFollowFansDateilsViewController *)childsController;
    vc.typeStr =  self.modelArr[tabItem.tag];
//        [vc loadNewData ];
}

@end

