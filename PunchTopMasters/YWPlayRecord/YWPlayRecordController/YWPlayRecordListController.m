//
//  YWPlayRecordListController.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/5/4.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWPlayRecordListController.h"
#import "YWPlayRecordListTableViewCell.h"
#import "YWPlayRcordModel.h"
#import "YWPlayRecordDrtailsViewController.h"
#import "YWXSPlayRecordDetailsViewController.h"
@interface YWPlayRecordListController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray *  recordArr;
/** 任务管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;
/** 页码*/
@property (nonatomic, assign) NSInteger page;
@property (assign, nonatomic) BOOL  isStart;
@property(nonatomic,strong)NSString *  recordSttus;

@end
static NSString * cellidenfder = @"YWPlayRecordListTableViewCell";
@implementation YWPlayRecordListController
- (void)viewWillAppear:(BOOL)animated{
    
//    [LFNSNOTI addObserver:self selector:@selector(refreshPage:) name:@"roomType" object:nil];
}
-(void)viewDidAppear:(BOOL)animated{
      [super viewDidAppear:animated];
//
}
-(void)refreshPage:(NSNotification*)nito{
    self.roomType = nito.object;
    NSDictionary *   dict = nito.userInfo;
    self. recordSttus = dict[@"number"];
    
    [self.tableView.mj_header beginRefreshing];
    
}
-(void)dealloc{
   [LFNSNOTI removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTable];
     [self createRefresh];
    [LFNSNOTI addObserver:self selector:@selector(refreshPage:) name:@"roomType" object:nil];
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
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"no_playrcord_data"];
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"目前没有任何内容";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName:blackTextColor
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    return 30.0f;
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
-(void)loadNewData{
    NSMutableDictionary * recordDict = diction;
     recordDict[@"token"] = loginToken;
     recordDict[@"roomType"] = self.roomType ;
     recordDict[@"lastId"] = @"0";

  
      recordDict[@"status"] =  self. recordSttus;
    
    
     recordDict[@"size"] = @(10);
    LFLog(@"%@",recordDict);
    [LFHttpTool post:PAYORDER_MYLIST params:recordDict progress:^(id downloadProgress) {
    } success:^(id responseObj) {
        LFLog(@"%@",responseObj);
        if ([responseObj[@"status"] isEqual:@(0)]) {
            
            [self.tableView.mj_header endRefreshing];
            self.recordArr = [YWPlayRcordModel mj_objectArrayWithKeyValuesArray:responseObj[@"data"]] ;
            [self.tableView reloadData];
            if ( self.recordArr.count<=10) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            self.isStart = self.recordArr.count>0?NO:YES;
            [self.tableView reloadEmptyDataSet];
        }else{
            [MBManager showBriefAlert:responseObj[@"message"]];}
    } failure:^(NSError *error) {
           [self.tableView.mj_header endRefreshing];
        [MBManager showBriefAlert:@"网络错误"];
        
    }];
    
  
}
-(void)loadMoreData{

    YWPlayRcordModel * playRcordModel =[self.recordArr lastObject];
    NSMutableDictionary * recordDict = diction;
    recordDict[@"token"] = loginToken;
    recordDict[@"roomType"] = @"1";
    recordDict[@"lastId"] = playRcordModel.userGameFlowId;
    recordDict[@"status"] = @"-1";
    recordDict[@"size"] = @(10);
    [YWRequestData playRecordListDict:recordDict success:^(id responseObj) {
        [self.tableView.mj_footer endRefreshing];
       NSMutableArray * arry = [YWPlayRcordModel mj_objectArrayWithKeyValuesArray:responseObj[@"data"]] ;
        [self.recordArr addObjectsFromArray:arry];
        [self.tableView reloadData];
        if (arry.count<=0) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        self.isStart = self.recordArr.count>0?NO:YES;
        [self.tableView reloadEmptyDataSet];
    }];
    
}

-(void)setTable{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, kTopHeight+90, LFscreenW, LFscreenH-kTopHeight-90) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
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

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return  0 ;
    }else{
        return 0.01f;
    }
    
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
   
    return    self.recordArr.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 84;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YWPlayRcordModel * playRcordModel = self.recordArr[indexPath.row];
    YWPlayRecordListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellidenfder];
    WeakSelf(weakSelf)
    cell.enterDetails = ^(YWPlayRcordModel *playRcordModel) {
        if ([playRcordModel.roomType isEqualToString:@"2"]) {
            YWPlayRecordDrtailsViewController * playRecordDrtailsVc = [[YWPlayRecordDrtailsViewController alloc] init];
            playRecordDrtailsVc.userGameFlowId = playRcordModel.userGameFlowId;
            [weakSelf.navigationController pushViewController:playRecordDrtailsVc animated:YES];
        }else{
         
            
            YWXSPlayRecordDetailsViewController * playRecordDrtailsVc = [[YWXSPlayRecordDetailsViewController alloc] init];
            playRecordDrtailsVc.userGameFlowId = playRcordModel.userGameFlowId;
            [weakSelf.navigationController pushViewController:playRecordDrtailsVc animated:YES];
            
        }
       
        
      
    };
    cell.playRcordModel = playRcordModel;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    YWPlayRcordModel * playRcordModel = self.recordArr[indexPath.row];
//    YWPlayRecordDrtailsViewController * playRecordDrtailsVc = [[YWPlayRecordDrtailsViewController alloc] init];
//    playRecordDrtailsVc.userGameFlowId = playRcordModel.userGameFlowId;
//    [self.navigationController pushViewController:playRecordDrtailsVc animated:YES];
    
}

@end
