//
//  YWFollowFansDateilsViewController.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/5/11.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWFollowFansDateilsViewController.h"
#import "YWFollowFansTableViewCell.h"
#import "YWFanModel.h"
#import "YWUserZoneController.h"
@interface YWFollowFansDateilsViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property (assign, nonatomic) BOOL  isStart;
@property(nonatomic,strong)NSMutableArray * datas;
@end
static NSString * const cellidenfder = @"YWFollowFansTableViewCell";
@implementation YWFollowFansDateilsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self setTable];
    [self createRefresh];
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"无关注列表"];
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
//- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
//    NSString *buttonTitle = @"点点点我";
//    NSDictionary *attributes = @{
//                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0f],
//                                  NSStrokeColorAttributeName:[UIColor redColor], NSStrokeWidthAttributeName:@(3),
//
//                                 };
//
//    return [[NSAttributedString alloc] initWithString:buttonTitle attributes:attributes];
//}
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
    footer.refreshingTitleHidden = YES;
    footer.automaticallyHidden = YES;
    [footer setTitle:@"好友就这些了，赶快去提高人气吧~" forState:MJRefreshStateNoMoreData];
    [header beginRefreshing];
    //    // 设置header
    self.tableView.mj_header = header;
    self.tableView.mj_footer = footer;
}

-(void)setTable{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 0, LFscreenW-1, LFscreenH  - kTopHeight-45) style:UITableViewStylePlain];
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
-(void)loadNewData{
   
    LFLog(@"%@",self.typeStr );
    if ([self.typeStr isEqualToString:@"0"]) {
        NSMutableDictionary * followListDict = diction;
        followListDict[@"token"] = loginToken;
        followListDict[@"lastId"] = @"-1";
        followListDict[@"size"] = @"20";
        [YWRequestData followListDict:followListDict success:^(id responseObj) {
            [self.tableView.mj_header endRefreshing];
            
            self.datas = [YWFanModel mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
            self.isStart = self.datas.count>0?NO:YES;
            if (self.datas.count<20) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            [self.tableView reloadData];
        }];
    }else{
        NSMutableDictionary * fanListDict = diction;
        fanListDict[@"token"] = loginToken;
        fanListDict[@"lastId"] = @"-1";
        fanListDict[@"size"] = @"20";
        [YWRequestData fanListDict:fanListDict success:^(id responseObj) {
              [self.tableView.mj_header endRefreshing];
        self.datas = [YWFanModel mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
            if (self.datas.count<20) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        [self.tableView reloadData];
        }];
        
    }
}
-(void)loadMoreData{
    
    YWFanModel *  fanModel = [self.datas lastObject];
    LFLog(@"%@",self.typeStr );
    if ([self.typeStr isEqualToString:@"0"]) {
        NSMutableDictionary * followListDict = diction;
        followListDict[@"token"] = loginToken;
        followListDict[@"lastId"] = fanModel.ID;
        followListDict[@"size"] = @"20";
        [YWRequestData followListDict:followListDict success:^(id responseObj) {
             [self.tableView.mj_footer endRefreshing];
            
           NSMutableArray * arr = [YWFanModel mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
            [self.datas addObjectsFromArray:arr];
            if (arr.count<=0) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
              [self.tableView reloadData];
        }];
    }else{
        NSMutableDictionary * fanListDict = diction;
        fanListDict[@"token"] = loginToken;
       fanListDict[@"lastId"] = fanModel.ID;
        fanListDict[@"size"] = @"20";
        [YWRequestData fanListDict:fanListDict success:^(id responseObj) {
               [self.tableView.mj_footer endRefreshing];
            NSMutableArray * arr = [YWFanModel mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
            [self.datas addObjectsFromArray:arr];
            if (arr.count<=0) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
              [self.tableView reloadData];
        }];
        
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
    
    return   self.datas.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YWFanModel *  fanModel = self.datas[indexPath.row];
    YWFollowFansTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellidenfder];
    cell.fanModel = fanModel;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
       YWFanModel *  fanModel = self.datas[indexPath.row];
    YWUserZoneController * userZoneVc = [[YWUserZoneController alloc] init];
    userZoneVc.userId = fanModel.userId;
    [self.navigationController pushViewController:userZoneVc animated:YES];
}
@end
