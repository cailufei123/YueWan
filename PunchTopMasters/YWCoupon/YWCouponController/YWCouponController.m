//
//  YWCouponController.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/5/3.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWCouponController.h"
#import "YWCouponTopView.h"
#import "YWCouponTableViewCell.h"
#import "SAVourcherModel.h"
#import "YWMeItemGroups.h"
#import "SAVourcherHeartView.h"
@interface YWCouponController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * vourchers;
@property(nonatomic,strong)NSMutableArray * alreadyUsevourchers;
@property(nonatomic,strong)NSMutableArray * notUsedvourchers;
@property(nonatomic,strong)NSMutableArray * allVourchers;
@property(nonatomic,strong)YWCouponTopView * couponTopView;
@property (assign, nonatomic) BOOL  isStart;
@end
static NSString *const cellidenfder = @"YWCouponTableViewCell";
@implementation YWCouponController
-(NSMutableArray *)alreadyUsevourchers{
    if (!_alreadyUsevourchers) {
        _alreadyUsevourchers = [NSMutableArray array];
    }
    return _alreadyUsevourchers;
}
-(NSMutableArray *)allVourchers{
    if (!_allVourchers) {
        _allVourchers = [NSMutableArray array];
    }
    return _allVourchers;
}
-(NSMutableArray *)notUsedvourchers{
    if (!_notUsedvourchers) {
        _notUsedvourchers = [NSMutableArray array];
    }
    return _notUsedvourchers;
}
- (void)viewDidLoad {
    [super viewDidLoad];
      self.navigationItem.title = @"代金券";
      self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"使用规则" color:[UIColor whiteColor] highlightColor:[UIColor whiteColor] target:self action:@selector(usedrule)];
    [self setTable];
    [self createRefresh];
    YWCouponTopView * couponTopView = [YWCouponTopView loadNameCouponTopViewXib];
    self.couponTopView = couponTopView;
//    self.tableView.tableHeaderView =  couponTopView;
}
-(void)usedrule{
    ATServiceAgreementController * serviceAgreementVc = [[ATServiceAgreementController alloc] init];
    serviceAgreementVc.htmlurl = COUPOON_SERVER;
    serviceAgreementVc.htmltitle = @"使用规则";
    [self.navigationController pushViewController:serviceAgreementVc animated:YES];
    
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
//    self.tableView.mj_footer = footer;
}

-(void)setTable{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, kTopHeight, LFscreenW, LFscreenH-kTopHeight) style:UITableViewStylePlain];
    [self.view  addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor  =bagColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:cellidenfder bundle:nil] forCellReuseIdentifier:cellidenfder];
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
    }
  
    
}

-(void)loadNewData{
    [MBManager showWaitingWithTitle:@"稍后.."];
    [self.notUsedvourchers removeAllObjects];
    [self.alreadyUsevourchers removeAllObjects];
    [self.allVourchers removeAllObjects];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"token"] = loginToken;
    dict[@"status"] = @"-1";
    [LFHttpTool post:COUPON_USER params:dict progress:^(id downloadProgress) {
        
    } success:^(id responseObj) {
        LFLog(@"%@",responseObj);
        [MBManager hideAlert];
        [self.tableView.mj_header endRefreshing];
        if ([responseObj[@"status"]isEqual:@(0)]) {
            self.vourchers =[SAVourcherModel mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
            self.isStart = self.vourchers.count>0?NO:YES;
            [self.tableView reloadEmptyDataSet];
            if (self.vourchers>0) {
                for (SAVourcherModel * vourcherModel  in self.vourchers) {
                    if ([vourcherModel.status isEqualToString:@"0"]) {
                        [self.notUsedvourchers addObject:vourcherModel];
                    }else{
                        [self.alreadyUsevourchers addObject:vourcherModel];
                    }
                }
            }
            if (self.notUsedvourchers.count>0) {
                // 1.创建组
                YWMeItemGroups * group = [YWMeItemGroups group];
                group.items = self.notUsedvourchers;
                group.header = [NSString stringWithFormat:@"可用代金券(%ld张)",self.notUsedvourchers.count];
                [self.allVourchers addObject:group];
                
            }
            if (self.alreadyUsevourchers.count>0) {
                YWMeItemGroups * group = [YWMeItemGroups group];
                group.items = self.alreadyUsevourchers;
                group.header = [NSString stringWithFormat:@"不可用代金券(%ld张)",self.alreadyUsevourchers.count];
                [self.allVourchers addObject:group];
            }
            
        }
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [MBManager hideAlert];
        [MBManager showBriefAlert:@"网络不给力"];
    }];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SAVourcherHeartView * vourcherHeartView = [SAVourcherHeartView vourcherHeartView];
    YWMeItemGroups * group = self.allVourchers[section];
    vourcherHeartView.titlelable.text = group.header;
    return vourcherHeartView;
    
    
    
}

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return  50;
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.allVourchers.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    YWMeItemGroups * group = self.allVourchers[section];
    
    return group.items.count;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YWMeItemGroups * group = self.allVourchers[indexPath.section];
    SAVourcherModel * selectVourcherModel = group.items[indexPath.row];
    YWCouponTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellidenfder];
        cell.selectVourcherModel = selectVourcherModel;
    return cell;
}
@end
