//
//  YWCouponViewController.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/5/2.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWCouponViewController.h"
#import "YWCouponTableViewCell.h"

#import "YWMeItemGroups.h"
@interface YWCouponViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * vourchers;
@property(nonatomic,strong)NSMutableArray * alreadyUsevourchers;
@property(nonatomic,strong)NSMutableArray * notUsedvourchers;
@property(nonatomic,strong)NSMutableArray * allVourchers;

@property (assign, nonatomic) BOOL  isStart;
@end
static NSString *const vourcherID = @"YWCouponTableViewCell";
@implementation YWCouponViewController

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
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"使用规则" color:[UIColor whiteColor] highlightColor:[UIColor whiteColor] target:self action:@selector(usedrule)];
    self.navigationItem.title = @"使用代金券";
  
    [self setTable];
    [self tableViewcreateRefresh];
//    [self createButton];
}
-(void)createButton{
    UIButton * bt = [[UIButton alloc] init];
    bt.frame = CGRectMake(0, LFscreenH-48-kTopHeight, LFscreenW, 48);
    [bt setTitle:@"不使用代金券" forState:UIControlStateNormal];
    [bt setTitleColor:blackTextColor forState:UIControlStateNormal];
    bt.backgroundColor = [UIColor whiteColor];
    [bt addTarget:self action:@selector(notUsedvourcherClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bt];
}
-(void)notUsedvourcherClick{//不用代金券
    self.nousedVourcherPice();
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)usedrule{
    ATServiceAgreementController * serviceAgreementVc = [[ATServiceAgreementController alloc] init];
//    serviceAgreementVc.htmlurl = FREECOIN_SERVER;
    serviceAgreementVc.htmltitle = @"规则说明";
    [self.navigationController pushViewController:serviceAgreementVc animated:YES];
    
}
-(void)setTable{
    self.navigationItem.title = @"优惠券";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, kTopHeight, LFscreenW, LFscreenH  - kTopHeight) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = bagColor;
//    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:vourcherID bundle:nil] forCellReuseIdentifier:vourcherID];
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    
    
    
    
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
//    [LFNSNOTI postNotificationName:skipHomeNotice object:nil];
}
- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    return [UIImage imageNamed:@"go_look_iocn"];
}
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    
    return self.isStart;
}

- (void)tableViewcreateRefresh
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    SARefreshGifHeader *header = [SARefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 马上进入刷新状态
    [header beginRefreshing];
    // 设置header
    self.tableView.mj_header = header;
    
    
}

-(void)loadNewData{
    [MBManager showWaitingWithTitle:@"稍后.."];
    [self.notUsedvourchers removeAllObjects];
    [self.alreadyUsevourchers removeAllObjects];
    [self.allVourchers removeAllObjects];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"token"] = loginToken;
    LFLog(@"%@",self.totalPric);
    dict[@"orderPrice"] = self.totalPric;
    [LFHttpTool post:COUPON_GOOD params:dict progress:^(id downloadProgress) {
        
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
//
        }
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [MBManager hideAlert];
        [MBManager showBriefAlert:@"网络不给力"];
    }];
}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    SAVourcherHeartView * vourcherHeartView = [SAVourcherHeartView vourcherHeartView];
//    SAMeItemGroups * group = self.allVourchers[section];
//    vourcherHeartView.titlelable.text = group.header;
//    return vourcherHeartView;
//
//
//
//}

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
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   YWMeItemGroups * group = self.allVourchers[indexPath.section];
    SAVourcherModel * selectVourcherModel = group.items[indexPath.row];
    YWCouponTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:vourcherID];
    cell.selectVourcherModel = selectVourcherModel;
    return cell;
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    YWMeItemGroups * group = self.allVourchers[indexPath.section];
//    SAVourcherModel * selectVourcherModel = group.items[indexPath.row];
//    if ([selectVourcherModel.use isEqualToString:@"1"]) {
//        self.vourcherPice(selectVourcherModel);
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//}
@end

