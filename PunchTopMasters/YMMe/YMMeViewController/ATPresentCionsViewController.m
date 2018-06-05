//
//  ATPresentCionsViewController.m
//  Auction
//
//  Created by 蔡路飞 on 2017/10/31.
//  Copyright © 2017年 Cailufei. All rights reserved.
//

#import "ATPresentCionsViewController.h"
#import "ATPresentCionViewCell.h"
#import "ATBalanceModel.h"
#import "ATBalanceRecordTopView.h"
#import "YWTXViewController.h"
//#import "SAVoucherCenterController.h"
#import "ATServiceAgreementController.h"

@interface ATPresentCionsViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property(nonatomic,strong)UITableView * tableView;
//@property(nonatomic,strong)ATPresentCionView * presentCionView;
@property(nonatomic,strong)ATBalanceRecordTopView * balanceRecordTopView;

@property(nonatomic,strong)NSMutableArray * datas;
/** 页码*/
@property (nonatomic, assign) NSInteger page;
@end
static NSString * const cellinfder  = @"ATPresentCionViewCell";
@implementation ATPresentCionsViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self getCoin];
    [self costCionRecord];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"零钱";
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"使用规则" color:[UIColor whiteColor] highlightColor:[UIColor whiteColor] target:self action:@selector(usedrule)];
    self.page = 0;
    [self setTable];
    ATBalanceRecordTopView * balanceRecordTopView = [ATBalanceRecordTopView balanceRecordTopView];
    self.balanceRecordTopView = balanceRecordTopView;
    self.tableView.tableHeaderView = balanceRecordTopView;
    [balanceRecordTopView.costBt addTarget:self action:@selector(costBtClick) forControlEvents:UIControlEventTouchUpInside];
   
    [self getCoin];
    [self costCionRecord];
}
-(void)usedrule{
    LFLog(@"%@",BALANCE_SERVER);
    ATServiceAgreementController * serviceAgreementVc = [[ATServiceAgreementController alloc] init];
    serviceAgreementVc.htmlurl = BALANCE_SERVER;
    serviceAgreementVc.htmltitle = @"使用规则";
    [self.navigationController pushViewController:serviceAgreementVc animated:YES];
    
}

-(void)costBtClick{//提现---------    
    YWTXViewController * serviceAgreementVc = [[YWTXViewController alloc] init];
    [self.navigationController pushViewController:serviceAgreementVc animated:YES];
    
    
}
#pragma mark----判断金币够不够---
-(void)getCoin{
    
    
    
    NSMutableDictionary * getCoinDict1 = diction;
    getCoinDict1[@"token"] = loginToken;
    [YWRequestData getCoinDict:getCoinDict1 success:^(id responseObj) {
    self.balanceRecordTopView.balanceLb.text =  [NSString stringWithFormat:@"%0.2lf",[responseObj[@"data"][@"mobileCoin"] doubleValue]];
      
    }];
    
   
    
}
-(void)costCionRecord{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"token"] = loginToken;
//    if (self.isFreeCion) {
//         dict[@"type"] = @"2";
//    }else{
//       dict[@"type"] = @"1";
//    }
   
    dict[@"start"] = @(self.page);
    dict[@"size"] = @"200";
    [LFHttpTool post:GET_PAY_HISTORY params:dict progress:^(id downloadProgress) {

    } success:^(id responseObj) {
        LFLog(@"%@",responseObj);
        [self.tableView.mj_header endRefreshing];
        if ([responseObj[@"status"] isEqual:@(0)]) {
            self.datas = [ATBalanceModel mj_objectArrayWithKeyValuesArray:responseObj[@"data"][@"records"]];
        }
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [MBManager showBriefAlert:@"网络不给力"];
        [self.tableView.mj_header endRefreshing];
    }];
    
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
    ATBalanceModel * balanceModel = self.datas[indexPath.row];
    ATPresentCionViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellinfder];
    cell.balanceModel = balanceModel;
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
