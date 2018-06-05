//
//  SAMessageViewController.m
//  SkinAssistant
//
//  Created by 蔡路飞 on 2017/6/28.
//  Copyright © 2017年 LeGame. All rights reserved.
//

#import "SAMessageViewController.h"
#import "DataBase.h"
#import "SAMessageModel.h"
#import "SAMessageContentController.h"
#import "ATMessageCell.h"
@interface SAMessageViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property(nonatomic,strong) UITableView * tableView;
@property (strong, nonatomic, nullable) NSArray *tags;
@property (assign, nonatomic) NSUInteger number;
@property (nonatomic, getter=isLoading) BOOL loading;
@property (strong, nonatomic)NSMutableArray * datas;
@property (strong, nonatomic)SAMessageModel * messageModel;
@property (strong, nonatomic)NSMutableArray * array1;
@property (strong, nonatomic)NSMutableArray *  array2;
@property (strong, nonatomic)NSMutableArray *  array3;
@property (assign, nonatomic) BOOL  isStart;
@end

static NSString * const atmessageID = @"ATMessageCell";
@implementation SAMessageViewController
- (void)setLoading:(BOOL)loading
{
    if (self.isLoading == loading) {
        return;
    }
    
    _loading = loading;
    
    [self.tableView reloadEmptyDataSet];
}
-(NSMutableArray *)datas{
    if (!_datas) {
        _datas = [[NSMutableArray alloc] init];
        
        
    }
    return _datas;

}
-(NSMutableArray *)array1{
    if (!_array1) {
        _array1 = [[NSMutableArray alloc] init];
        
        
    }
    return _array1;
    
}

-(NSMutableArray *)array2{
    if (!_array2) {
        _array2 = [[NSMutableArray alloc] init];
        
        
    }
    return _array2;
    
}
-(NSMutableArray *)array3{
    if (!_array3) {
        _array3 = [[NSMutableArray alloc] init];
        
        
    }
    return _array3;
    
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"无消息"];
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"目前没有任何内容";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName:blackTextColor
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    return 30.0f;
}

// 或者，返回固定值
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return -50;
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:skipHomeNotice object:nil];
}
- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    return [UIImage imageNamed:@"去逛逛"];
}
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    
    return self.isStart;
}
#pragma mark 空白页面被点击时刷新页面
//- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
//    // 空白页面被点击时开启动画，reloadEmptyDataSet
//    self.loading = YES;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        // 关闭动画，reloadEmptyDataSet
//        self.number = 20;
//         self.tableView.mj_footer.hidden = NO;
//        [self.tableView reloadData];
//        self.loading = NO;
//    });
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"清除消息" color:[UIColor whiteColor] highlightColor:[UIColor whiteColor] target:self action: @selector(cleanBtClick) ];
    self.navigationItem.title = @"消息";
    [self setTable];
    [self getmessageBageVlue];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getmessageBageVlu) name:pushRefresh object:nil];
//    [self creveBootomTabar];

}
-(void)creveBootomTabar{
    UIView * bootomTabar = [[UIView alloc] initWithFrame:CGRectMake(0, LFscreenH-kTopHeight-50, LFscreenW, 50)];
    bootomTabar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bootomTabar];
    UIButton * cleanBt = [UIButton buttonWithType:UIButtonTypeCustom];
    cleanBt.frame= CGRectMake(0, 0, 100, 50);
    cleanBt.clf_centerY = bootomTabar.clf_height/2;
    [cleanBt setTitleColor:bkColor forState:UIControlStateNormal];
    [cleanBt setTitle:@"清除消息" forState:UIControlStateNormal];
    cleanBt.titleLabel.font = [UIFont systemFontOfSize:16];
    [cleanBt addTarget:self action:@selector(cleanBtClick) forControlEvents:UIControlEventTouchUpInside];
    [bootomTabar addSubview:cleanBt];
    
    UIButton * readBt = [UIButton buttonWithType:UIButtonTypeCustom];
    readBt.frame= CGRectMake(LFscreenW-100, 0, 100, 50);
    readBt.clf_centerY = bootomTabar.clf_height/2;
    [readBt setTitleColor:bkColor forState:UIControlStateNormal];
    readBt.titleLabel.font = [UIFont systemFontOfSize:16];
    [readBt setTitle:@"全部已读" forState:UIControlStateNormal];
    [bootomTabar addSubview:readBt];
    [readBt addTarget:self action:@selector(readBtClick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)cleanBtClick{

    [[DataBase sharedDataBase] deleteAllMessage];
    [self getmessageBageVlue];
}
-(void)readBtClick{
[[DataBase sharedDataBase] readMessage];
[self getmessageBageVlue];
    
}
-(void)viewDidAppear:(BOOL)animated{
[self getmessageBageVlue];

}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}
-(void)getmessageBageVlu{
 [self getmessageBageVlue];

}
-(void)getmessageBageVlue{
    [self.datas removeAllObjects];
    [self.array1 removeAllObjects];
    [self.array2 removeAllObjects];
    [self.array3 removeAllObjects];
    
    NSMutableArray * datas1 = [[DataBase sharedDataBase] selectitemDream_desc:@"0"];
    NSMutableArray * datas2 = [[DataBase sharedDataBase] selectitemDream_desc:@"1"];
    NSMutableArray * datas3 = [[DataBase sharedDataBase] selectitemDream_desc:@"2"];
     LFLog(@"%@ ////%@ ///%@",datas1,datas2,datas3);
    if (datas1.count>0) {
        for (SAMessageModel * messageModel in datas1) {
            LFLog(@"%@",messageModel.extra1);
            if ([messageModel.extra1 isEqualToString:@"0"]) {
                [self.array1 addObject:messageModel];
            }
        }
        SAMessageModel * messageModel  = [datas1 lastObject];
        messageModel.arrary = datas1;
        messageModel.bageVlue = [NSString stringWithFormat:@"%ld",self.array1.count];
        [self.datas addObject:messageModel];
    }
    if (datas2.count>0) {
        for (SAMessageModel * messageModel in datas2) {
            if ([messageModel.extra1 isEqualToString:@"0"]) {
                [self.array2 addObject:messageModel];
            }
        }
        SAMessageModel * messageModel  = [datas2 lastObject];
         messageModel.arrary = datas2;
        LFLog(@"%@",[NSString stringWithFormat:@"%ld",self.array2.count]);
        messageModel.bageVlue = [NSString stringWithFormat:@"%ld",self.array2.count];
        [self.datas addObject:messageModel];
    }
    
    if (datas3.count>0) {
        for (SAMessageModel * messageModel in datas3) {
            if ([messageModel.extra1 isEqualToString:@"0"]) {
                [self.array3 addObject:messageModel];
            }
        }
        SAMessageModel * messageModel  = [datas3 lastObject];
        messageModel.arrary = [[DataBase sharedDataBase] getAllMessage];
        messageModel.bageVlue = [NSString stringWithFormat:@"%ld",self.array3.count];
        [self.datas addObject:messageModel];
    }
    self.isStart = datas1.count+datas3.count+datas2.count>0?NO:YES;
    [self.tableView reloadEmptyDataSet];
    [self.tableView reloadData];
}
-(void)setTable{
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopHeight, LFscreenW, LFscreenH-kTopHeight) style:UITableViewStylePlain];
   self. number = 0;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:atmessageID bundle:nil] forCellReuseIdentifier:atmessageID];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = bagColor;
  
//    [[LFDisplayView sharedManager ]  initNoNetworkView:self.view reloadData:^{
//        [weakSelf.tableView.mj_header beginRefreshing];
//        [[LFDisplayView sharedManager ]hideNoNetworkView];
//    }];
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    
    //这行代码必须加上，可以去除tableView的多余的线，否则会影响美观
    self.tableView.tableFooterView = [UIView new];
     self.tableView.mj_footer.hidden = YES;

}

#pragma mark 是否开启动画
//- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView {
////    if (self. number>0) {
////        return YES;
////    }else{
////    return YES;
////    }
//     return YES;
//}
#pragma mark 图片旋转动画
//- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
//{
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
//    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
//    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
//    animation.duration = 0.25;
//    animation.cumulative = YES;
//    animation.repeatCount = MAXFLOAT;
//    
//    return animation;
//}

-(void)loadNewData{
   
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

         [self.tableView.mj_footer endRefreshingWithNoMoreData];
        [self.tableView.mj_header endRefreshing ];
        [self.tableView.mj_footer endRefreshing ];
        self. number = 0;
        [self.tableView reloadData];
        [self.tableView reloadEmptyDataSet];
          self.tableView.mj_footer.hidden = YES;
         self.loading = NO;
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    });
    
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.datas.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
        return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SAMessageModel * messageModel  = self.datas[indexPath.row];
    ATMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:atmessageID ];
   cell.messageModel = messageModel;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 57;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SAMessageModel * messageModel  = self.datas[indexPath.row];
    SAMessageContentController *  messageContentVc = [[SAMessageContentController alloc] init];
    messageContentVc.refreshmianpage = ^{
        [self getmessageBageVlue];
//         [[NSNotificationCenter defaultCenter] postNotificationName:pushRefresh object:nil];
    };
    messageContentVc.type = messageModel.msg_type;
    [self.navigationController pushViewController:messageContentVc animated:YES];
    

}
@end
