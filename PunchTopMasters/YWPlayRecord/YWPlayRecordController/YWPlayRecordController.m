//
//  YWPlayRecordController.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/5/4.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWPlayRecordController.h"
#import "YWPlayRecordListController.h"
#import "LFTitleButton.h"

@interface YWPlayRecordController ()<UIScrollViewDelegate>
/** 当前选中的标题按钮 */
@property (nonatomic, weak) LFTitleButton *selectedTitleButton;
/** 标题按钮底部的指示器 */
@property (nonatomic, weak) UIView *indicatorView;
/** UIScrollView */
@property (nonatomic, weak) UIScrollView *scrollView;
/** 标题栏 */
@property (nonatomic, strong) UIView *titlesView;
@property (nonatomic, copy) NSString *roomType;
@property (nonatomic, copy) NSMutableArray *lfTitleButtons;
@property (nonatomic, strong)   UIView * segmentBgView;

@property (nonatomic, strong)    NSArray * titles;

@end

@implementation YWPlayRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"开黑记录";
      self. roomType = @"1";
    [self setupChildViewControllers];
    
    [self setupScrollView];
    //
    [self setupTitlesView];
    //
    //    // 默认添加子控制器的view
    [self addChildVcView];

}
-(NSMutableArray *)lfTitleButtons{
    
    if (!_lfTitleButtons) {
        _lfTitleButtons = [NSMutableArray array];
    }
    return _lfTitleButtons;
}
-(void)setupChildViewControllers{
   
    for (int i = 0; i<3; i++) {
        YWPlayRecordListController * recordListVc = [[YWPlayRecordListController alloc] init];
        [self addChildViewController:recordListVc];
    }
    
    
}
- (void)setupScrollView{
    self.automaticallyAdjustsScrollViewInsets = NO; //不允许调整scrollView的内边距
    UIScrollView * scrollView = [[UIScrollView alloc] init];
//    scrollView.backgroundColor = CLFRandomColor;
    scrollView.frame = self.view.bounds;
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    scrollView.contentSize = CGSizeMake(self.childViewControllers.count * scrollView.clf_width, 0);
    scrollView.delegate = self;
    self.scrollView = scrollView;
    
}
- (void)setupTitlesView
{
    UIView * segmentBgView = [[UIView alloc] initWithFrame:CGRectMake(0, kTopHeight, LFscreenW, 49)];
    self.segmentBgView = segmentBgView;
    segmentBgView.backgroundColor = bagColor;
    //先生成存放标题的数据
    NSArray * array = [NSArray arrayWithObjects:@"AA房",@"悬赏房",@"撒币房", nil];
    //初始化UISegmentedControl
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:array];
    //设置frame
    segment.frame = CGRectMake(10, 100, self.view.frame.size.width-20, 30);
    segment.clf_centerY = segmentBgView.clf_height/2;
    //添加到视图
    [self.view addSubview:segmentBgView];
    
      [segmentBgView addSubview:segment];
    segment.selectedSegmentIndex = 0;
    segment.tintColor = [SVGloble colorWithHexString:@"#404652"];
    //添加事件
    [segment addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    
    
    
    UIView* titlesView =[[UIView alloc] init];
    self.titlesView = titlesView;
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.95];
    titlesView.frame = CGRectMake(0, self.segmentBgView.clf_bottom, self.view.clf_width, 35);
    [self.view addSubview:titlesView];
  
    
   
    NSArray *titles = @[@{@"name":@"全部",@"number":@"-1"},@{@"name":@"待汇报",@"number":@"2"},@{@"name":@"审核中",@"number":@"4"}];
      self.titles = titles;
    [self creteTitlesView:titles];
    
  
}

-(void)creteTitlesView:(NSArray * )titles{
  [self.titlesView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
   
    // 添加标题
    //开黑状态 游戏中1,战绩待汇报2，战绩审核中4，战绩待确认5，战绩已超时201，已确认101，被驳回102，已完成103，战绩已失效202 ,
   
    NSUInteger count = titles.count;
    CGFloat titleButtonW =  self.titlesView.clf_width / count;
    CGFloat titleButtonH =  self.titlesView.clf_height;
    for (NSInteger i = 0; i<count; i++) {
        LFTitleButton * titleButton =[LFTitleButton buttonWithType:UIButtonTypeCustom];
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [ self.titlesView addSubview:titleButton];
        titleButton.tag = i;
        // 设置数据
        [titleButton setTitle:titles[i][@"name"] forState:UIControlStateNormal];
        // 设置frame
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
        
        [self.lfTitleButtons addObject:titleButton];
    }
    LFTitleButton *firstTitleButton =  self.titlesView.subviews.firstObject;
    // 底部的指示器
    
    UIImageView * lineImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"order_tab_line"]];
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor clearColor];
    [indicatorView addSubview:lineImg];
    
    indicatorView.clf_height = 14;
    
    indicatorView.clf_y =   self.titlesView.clf_height-10;
    [self.titlesView addSubview:indicatorView];
    self.indicatorView = indicatorView;
    // 立刻根据文字内容计算label的宽度
    [firstTitleButton.titleLabel sizeToFit];
    indicatorView.clf_width = 62;
    indicatorView.clf_centerX = firstTitleButton.clf_centerX;
    firstTitleButton.selected = YES;
    self.selectedTitleButton = firstTitleButton;
    lineImg.frame = indicatorView.bounds;
//    [self titleClick:<#(LFTitleButton *)#>]
}
#pragma mark - 监听点击
- (void)titleClick:(LFTitleButton *)titleButton{
    self.selectedTitleButton.selected =NO;
    titleButton.selected = YES;
    self.selectedTitleButton = titleButton;
    [UIView animateWithDuration:0.25 animations:^{
//        self.indicatorView.clf_width = titleButton.titleLabel.clf_width;
          self.indicatorView.clf_width = 62;
        self.indicatorView.clf_centerX = titleButton.clf_centerX;
    }];
    
    // 让UIScrollView滚动到对应位置
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = titleButton.tag * self.scrollView.clf_width;
    [self.scrollView setContentOffset:offset animated:YES];
      [LFNSNOTI postNotificationName:@"roomType" object: self. roomType userInfo:self.titles [titleButton.tag]];
}
-(void)change:(UISegmentedControl *)sender{
  
   
    
    
    
    NSArray *titles =nil;
  
    if (sender.selectedSegmentIndex == 0) {
        titles = @[@{@"name":@"全部",@"number":@"-1"},@{@"name":@"待汇报",@"number":@"2"},@{@"name":@"审核中",@"number":@"4"}];
          [self creteTitlesView:titles];
        self. roomType = @"1";
    }else if (sender.selectedSegmentIndex == 2){
       titles = @[@{@"name":@"全部",@"number":@"-1"},@{@"name":@"待确认",@"number":@"5"},@{@"name":@"审核中",@"number":@"4"}];
        [self creteTitlesView:titles];
       self. roomType = @"2";
    }else if (sender.selectedSegmentIndex == 1){
     
       titles = @[@{@"name":@"全部",@"number":@"-1"},@{@"name":@"待确认",@"number":@"5"},@{@"name":@"待汇报",@"number":@"2"}];
        [self creteTitlesView:titles];
        self. roomType = @"3";
    }
      self.titles = titles;
    [LFNSNOTI postNotificationName:@"roomType" object: self. roomType userInfo:[titles firstObject]];
}

- (void)tagClick
{
//    LFLogFunc
}
#pragma mark - 添加子控制器的view
- (void)addChildVcView
{
    // 子控制器的索引
    NSUInteger index = self.scrollView.contentOffset.x / self.scrollView.clf_width;
    
    // 取出子控制器
    YWPlayRecordListController *childVc = self.childViewControllers[index];
    childVc.status = index;
      childVc.roomType =  self. roomType;
    if ([childVc isViewLoaded]) return;
    [self.scrollView addSubview:childVc.view];
    childVc.view.frame = self.scrollView.bounds;
//    CGRectMake(0, kTopHeight, LFscreenW, 49)
      [LFNSNOTI postNotificationName:@"roomType" object: self. roomType userInfo:self.titles [index]];
}

#pragma mark - <UIScrollViewDelegate>
/**
 * 在scrollView滚动动画结束时, 就会调用这个方法
 * 前提: 使用setContentOffset:animated:或者scrollRectVisible:animated:方法让scrollView产生滚动动画
 */
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self addChildVcView];
}
/**
 * 在scrollView滚动动画结束时, 就会调用这个方法
 * 前提: 人为拖拽scrollView产生的滚动动画
 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSUInteger index = scrollView.contentOffset.x / scrollView.clf_width;
    LFTitleButton * titleButton =self.titlesView.subviews[index];
    [self titleClick:titleButton];
    [self addChildVcView];
    
}
@end
