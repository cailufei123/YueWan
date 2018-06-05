//
//  YWTxRecordListViewController.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/5/10.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWTxRecordListViewController.h"
#import "ATPresentCionViewCell.h"
#import "ATBalanceModel.h"
#import "YWTxRecordListTopView.h"
#import "YWTXViewController.h"
//#import "SAVoucherCenterController.h"
#import "ATServiceAgreementController.h"
@interface YWTxRecordListViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property(nonatomic,strong)UITableView * tableView;
//@property(nonatomic,strong)ATPresentCionView * presentCionView;
@property(nonatomic,strong)YWTxRecordListTopView * balanceRecordTopView;
@property (assign, nonatomic) BOOL  isStart;
@property(nonatomic,strong)NSMutableArray * datas;
/** 页码*/
@property (nonatomic, assign) NSInteger page;
@end
static NSString * const cellinfder  = @"ATPresentCionViewCell";
@implementation YWTxRecordListViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
  
    [self costCionRecord];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"提现记录";

    self.page = 0;
    [self setTable];
    [self createRefresh];
    YWTxRecordListTopView * balanceRecordTopView = [YWTxRecordListTopView balanceTxRecordListTopView];
    self.balanceRecordTopView = balanceRecordTopView;
    self.tableView.tableHeaderView = balanceRecordTopView;
    [self costCionRecord];
}
- (void)createRefresh
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    
    SARefreshGifHeader *header = [SARefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    SARefreshAutoGifFooter *footer = [SARefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // 马上进入刷新状态
    [header beginRefreshing];
    //    // 设置header
    self.tableView.mj_header = header;
    self.tableView.mj_footer = footer;
}
-(void)loadNewData{
    //    http://101.200.74.83:9011/api/esportsvc/service/cash/list
http://101.200.74.83:9011/api/esportsvc/service/cash/list
    LFLog(@"%@",USER_TXLIST);
    LFLog(@"%@",loginToken);
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"token"] =loginToken;
    dict[@"start"] =@(self.page);
    [YWRequestData userTxListDict:dict token:loginToken success:^(id responseObj) {
        [self.tableView.mj_header endRefreshing];
        self.datas = [BalanceModel mj_objectArrayWithKeyValuesArray:responseObj[@"data"][@"cashApplies"]];
        self.isStart = self.datas.count>0?NO:YES;
        if ( self.datas.count <10) {
              [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        self.balanceRecordTopView.totalCashLb.text = [NSString stringWithFormat:@"￥%@",responseObj[@"data"][@"totalCash"]];
        [self.tableView reloadData];
    }];
}
-(void)loadMoreData{
    self.page ++;
    //    http://101.200.74.83:9011/api/esportsvc/service/cash/list
http://101.200.74.83:9011/api/esportsvc/service/cash/list
    LFLog(@"%@",USER_TXLIST);
    LFLog(@"%@",loginToken);
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"token"] =loginToken;
     dict[@"start"] =@(self.page);
    [YWRequestData userTxListDict:dict token:loginToken success:^(id responseObj) {
          [self.tableView.mj_footer endRefreshing];
      NSArray * arr = [BalanceModel mj_objectArrayWithKeyValuesArray:responseObj[@"data"][@"cashApplies"]];
        [self.datas addObjectsFromArray:arr];
        if (arr.count <=0) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        self.balanceRecordTopView.totalCashLb.text = [NSString stringWithFormat:@"￥%@",responseObj[@"data"][@"totalCash"]];
        [self.tableView reloadData];
    }];
}
-(void)costCionRecord{
////    http://101.200.74.83:9011/api/esportsvc/service/cash/list
//      http://101.200.74.83:9011/api/esportsvc/service/cash/list
//    LFLog(@"%@",USER_TXLIST);
//      LFLog(@"%@",loginToken);
//    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
//    dict[@"token"] =loginToken;
//    dict[@"start"] =@"0";
//    [YWRequestData userTxListDict:dict token:loginToken success:^(id responseObj) {
//        self.datas = [BalanceModel mj_objectArrayWithKeyValuesArray:responseObj[@"data"][@"cashApplies"]];
//        self.isStart = self.datas.count>0?NO:YES;
//        self.balanceRecordTopView.totalCashLb.text = [NSString stringWithFormat:@"￥%@",responseObj[@"data"][@"totalCash"]];
//        [self.tableView reloadData];
//    }];
   
   

    
}


#pragma mark 空白页显示图片
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    // 默认静态图片
    return [UIImage imageNamed:@"no_coupon_data"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"积极参加活动会有优惠券~";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName:deepGrayColor
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    return 25.0f;
}

// 或者，返回固定值
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return -100;
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    [LFNSNOTI postNotificationName:skipHomeNotice object:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    
    UIButton * button = [[UIButton alloc] init];
    button.frame = CGRectMake(0, 0, 100, 30);
    button.layer.borderWidth = 1; button.layer.borderColor = assistColor.CGColor;
    [button setTitle:@"去看看" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:assistColor forState:UIControlStateNormal];
    [button layercornerRadius:15];
    
    return  [self convertViewToImage:button];
}
-(UIImage*)convertViewToImage:(UIView*)v{
    CGSize s = v.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    
    return self.isStart;
}
-(void)setTable{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, kTopHeight, LFscreenW, LFscreenH  - kTopHeight) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor  =bagColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:cellinfder bundle:nil] forCellReuseIdentifier:cellinfder];
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
    }
}


-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
    
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.datas.count;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 58;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BalanceModel * balanceModel = self.datas[indexPath.row];
    ATPresentCionViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellinfder];
    cell.recordListModel = balanceModel;
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
