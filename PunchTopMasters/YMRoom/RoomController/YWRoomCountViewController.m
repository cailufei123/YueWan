//
//  YWRoomCountViewController.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/5/10.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWRoomCountViewController.h"
#import "YWRoomCountTableViewCell.h"
#import "YWRoomModel.h"

@interface YWRoomCountViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * datas;
@property(strong,nonatomic) YWRoomModel * roomModel;
@end

@implementation YWRoomCountViewController
static NSString * const cellidenfder  = @"YWRoomCountTableViewCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"房间人数";
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"邀请好友" color:[UIColor whiteColor] highlightColor:[UIColor whiteColor] target:self action:@selector(invatationFriend)];
    [self setTable];
    [self createRefresh];
}

-(void)invatationFriend{
    
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
-(void)loadNewData{
    NSMutableDictionary * dic = diction;dic[@"id"] =self.roomId;
    [YWRequestData getRoomDetailsDict:dic success:^(id responseObj) {
        
        [self.tableView.mj_header endRefreshing];
        self.roomModel = [YWRoomModel mj_objectWithKeyValues:responseObj[@"data"]];
        for (int i = 0; i< self.roomModel.roomPerson.count; i++) {
            YWRoomPersonModel * roomPersonModel = self.roomModel.roomPerson[i];
            roomPersonModel.queue_level = @"3";
            for (int j = 0; j< self.roomModel.gameQueue.count; j++) {
                YWGameQueueModel * gameQueueModel =  self.roomModel.gameQueue[j];

                if ([roomPersonModel.userId isEqualToString:gameQueueModel.userId]) {
                    roomPersonModel.queue_level = @"2";
                    if ([gameQueueModel.isMgt isEqualToString:@"1"]) {
                          roomPersonModel.queue_level = @"1";
                    }
                }
                
                
            }
        }
        [self.tableView reloadData];
//        
//        [self updataUI];
    }];
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
   
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
    }
    
    
}

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return  0.0;
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
    
    return  self.roomModel.roomPerson.count;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 82;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   YWRoomPersonModel * roomPersonModel = self.roomModel.roomPerson[indexPath.row];
    YWRoomCountTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellidenfder];
    WeakSelf(weakSelf)
    
    cell.kickguest = ^(YWRoomPersonModel *roomPersonModel) {
        [weakSelf kickuser:roomPersonModel];
    };
    cell.kickQueue = ^(YWRoomPersonModel *roomPersonModel) {
        [weakSelf kickuser:roomPersonModel];
    };
    cell.roomModel = self.roomModel;
    cell.roomPersonModel = roomPersonModel;
    return cell;
}

-(void)kickuser:(YWRoomPersonModel *)roomPersonModel{//操控的是房主
    if ([self.roomModel.roomInfo.gameStatus isEqualToString:@"1"]) {////0：未开始；1、启动中(房主点击唤起游戏) 2、游戏中(客服收到链接已开始游戏) 3、结算中，(房主手动点击结束游戏) 4、游戏结束；
        [MBManager showBriefAlert:@"启动中不能操控队列"];
        return ;
    }
    
    if ([self.roomModel.roomInfo.gameStatus isEqualToString:@"2"]) {////0：未开始；1、启动中(房主点击唤起游戏) 2、游戏中(客服收到链接已开始游戏) 3、结算中，(房主手动点击结束游戏) 4、游戏结束；
        [MBManager showBriefAlert:@"游戏中不能操控队列"];
        return ;
    }
    if ([self.roomModel.roomInfo.gameStatus isEqualToString:@"3"]) {////0：未开始；1、启动中(房主点击唤起游戏) 2、游戏中(客服收到链接已开始游戏) 3、结算中，(房主手动点击结束游戏) 4、游戏结束；
        [MBManager showBriefAlert:@"结算中不能操控队列"];
        return ;
    }
    if ([self.roomModel.roomInfo.gameStatus isEqualToString:@"4"]) {////0：未开始；1、启动中(房主点击唤起游戏) 2、游戏中(客服收到链接已开始游戏) 3、结算中，(房主手动点击结束游戏) 4、游戏结束；
        [MBManager showBriefAlert:@"游戏结束不能操控队列"];
        return ;
    }
    
 
    [self kickRoom:roomPersonModel];
        

    
}
-(void)kickRoom:(YWRoomPersonModel *)roomPersonModel{
    if ([roomPersonModel.queue_level isEqualToString:@"2"]) {
        NSMutableDictionary *delPersonDict = diction;
        delPersonDict[@"roomId"] =  self.roomModel.roomInfo.roomId;
        delPersonDict[@"userId"] =  roomPersonModel.userId;
        
        NSMutableDictionary *kickQueueDict = diction;
        kickQueueDict[@"roomId"] = self.roomModel.roomInfo.roomId;
        kickQueueDict[@"userId"] =  roomPersonModel.userId;
        kickQueueDict[@"gameId"] = self.roomModel.roomInfo.gameId;
        kickQueueDict[@"token"] = loginToken;
        [YWRequestData kickQueueDict:kickQueueDict success:^(id responseObj) {
            
            [YWRequestData delPersonRoomDict:delPersonDict success:^(id responseObj) {
                [[EMClient sharedClient].roomManager removeMembers:@[roomPersonModel.huanid] fromChatroom:self.roomModel.roomInfo.huanChatId completion:^(EMChatroom *aChatroom, EMError *aError) {
                    NSMutableDictionary *userInfo = diction;
                    userInfo[@"userId"] = roomPersonModel.userId;
                    [LFNSNOTI postNotificationName:enterQueueRefresh object:kickRoom userInfo:userInfo];
                    [GKCover hideCover];
                }];
                
            }];
        }];
    }else if ([roomPersonModel.queue_level isEqualToString:@"3"]){
        NSMutableDictionary *delPersonDict = diction;
        delPersonDict[@"roomId"] =  self.roomModel.roomInfo.roomId;
        delPersonDict[@"userId"] =  roomPersonModel.userId;
        [YWRequestData delPersonRoomDict:delPersonDict success:^(id responseObj) {
            [[EMClient sharedClient].roomManager removeMembers:@[roomPersonModel.huanid] fromChatroom:self.roomModel.roomInfo.huanChatId completion:^(EMChatroom *aChatroom, EMError *aError) {
                NSMutableDictionary *userInfo = diction;
                userInfo[@"userId"] = roomPersonModel.userId;
                [LFNSNOTI postNotificationName:enterQueueRefresh object:kickRoom userInfo:userInfo];
                [GKCover hideCover];
            }];
            
        }];
    }
   
    
}
@end
