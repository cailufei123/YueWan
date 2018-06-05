//
//  YWUserZoneController.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/5/8.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWUserZoneController.h"
#import "YWUserZoneTopView.h"
#import "YWUserZoneTopViewTableViewCell.h"
#import "YMMeModel.h"
#import "YWMeItemGroups.h"
#import "YWChatViewController.h"

#import "YWZoneFootView.h"
@interface YWUserZoneController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray *  recordArr;
@property(nonatomic,strong)YWUserZoneTopView *  userZoneTopView;
/** 任务管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;
/** 页码*/
@property (nonatomic, assign) NSInteger page;
@property (assign, nonatomic) BOOL  isStart;
@property (nonatomic, strong) NSMutableArray *groups;
@property (nonatomic, strong)YMMeModel * meModel;
@property (nonatomic, strong) UIButton * allowBt;
@end
static NSString * cellidenfder = @"YWUserZoneTopViewTableViewCell";
@implementation YWUserZoneController
- (void)viewWillAppear:(BOOL)animated{
    
    //    [LFNSNOTI addObserver:self selector:@selector(refreshPage:) name:@"roomType" object:nil];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //
}
-(void)refreshPage:(NSNotification*)nito{
//    self.roomType = nito.object;
    [self.tableView.mj_header beginRefreshing];
    
}
-(void)dealloc{
    [LFNSNOTI removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人空间";
    self.userZoneTopView = [YWUserZoneTopView loadNameUserZoneTopView];
    [self setTable];
    [self loadNewData];
    
    [LFNSNOTI addObserver:self selector:@selector(refreshPage:) name:@"roomType" object:nil];
    [self createBottomTabar];
}
-(void)createBottomTabar{
    
    UIView * bottomTar = [[UIView alloc] init];bottomTar.frame = CGRectMake(0, LFscreenH-kTabBarHeight, LFscreenW, 49);
     UIView * line = [[UIView alloc] init];line.frame = CGRectMake(LFscreenW/2, 9, 1, 30);   line.backgroundColor = [SVGloble colorWithHexString:@"#E5E7E9"];
    if ([self.userId isEqualToString:loginUid]) {
        bottomTar.hidden = YES;
    }else{
        bottomTar.hidden = NO;
    }
    
    bottomTar.backgroundColor = [SVGloble colorWithHexString:@"#FAFAFA"];
    UIButton * allowBt = [[UIButton alloc] init];allowBt.frame = CGRectMake(0, 0, LFscreenW/2-1, 49);allowBt.backgroundColor = [UIColor clearColor];
    self.allowBt = allowBt;
    [allowBt setImage:[UIImage imageNamed:@"no_follow"] forState:UIControlStateNormal];
    [allowBt setImage:[UIImage imageNamed:@"already_follow"] forState:UIControlStateSelected];
    [allowBt setTitle:@"关注" forState:UIControlStateNormal];
    allowBt.titleLabel.font = [UIFont systemFontOfSize:13];
    [allowBt setTitleColor:[SVGloble colorWithHexString:@"#222222"] forState:UIControlStateNormal];
    [allowBt setTitle:@"已关注" forState:UIControlStateSelected];
    UIButton * messageBt = [[UIButton alloc] init];messageBt.frame = CGRectMake( LFscreenW/2, 0, LFscreenW/2, 49);messageBt.backgroundColor = [UIColor clearColor];
    messageBt.titleLabel.font = [UIFont systemFontOfSize:13];
    [messageBt setTitleColor:[SVGloble colorWithHexString:@"#222222"] forState:UIControlStateNormal];
    [allowBt setImage:[UIImage imageNamed:@"私信"] forState:UIControlStateNormal];
    [messageBt setTitle:@"私信" forState:UIControlStateNormal];
    [allowBt addTarget:self action:@selector(allowBtClick:) forControlEvents:UIControlEventTouchUpInside];
    [messageBt addTarget:self action:@selector(messageBtClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomTar addSubview:allowBt];
    [bottomTar addSubview:messageBt];
    [bottomTar addSubview:line];
    [self.view addSubview:bottomTar];
    
    
  
    
    
}
-(void)allowBtClick:(UIButton * )bt{
    NSMutableDictionary * followDit = diction;
    followDit[@"token"] = loginToken;
    followDit[@"followUserId"] = self.meModel.user.userId;
    [YWRequestData followUserDict:followDit success:^(id responseObj) {
        bt.selected = YES;
    }];
    
}
-(void)messageBtClick:(UIButton * )bt{
    LFLog(@"%@",self.meModel.user.huanId);
    YWChatViewController *chatController = [[YWChatViewController alloc] initWithConversationChatter: self.meModel.user.huanId conversationType:EMConversationTypeChat];
    chatController.name =  self.meModel.user.name;
    chatController.icon =self.meModel.user.icon;
    [self.navigationController pushViewController:chatController animated:YES];
    
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
- (NSMutableArray *)groups
{
    if (_groups == nil) {
        self.groups = [NSMutableArray array];
    }
    return _groups;
}
-(void)loadNewData{
    NSMutableDictionary *  userHomePageDict = diction;
    userHomePageDict[@"userId"] = self.userId;
       userHomePageDict[@"isStat"] = @"1";
      [self.groups removeAllObjects];
    [YWRequestData userHomePageDict: userHomePageDict success:^(id responseObj) {
          YMMeModel * meModel = [YMMeModel mj_objectWithKeyValues:responseObj[@"data"]];
        self.meModel = meModel;
        NSMutableDictionary * followExtDit = diction;
        followExtDit[@"token"] = loginToken;
        followExtDit[@"followUserId"] = meModel.user.userId;
        [YWRequestData followExitDict:followExtDit success:^(id responseObj) {
            if ([responseObj[@"data"] isEqual:@(0)]) {
                self.allowBt.selected = NO;
            }else{
                self.allowBt.selected = YES;
            }
        }];
        
        
        
        
        
        
        self.userZoneTopView.meModel = meModel;
        self.tableView.tableHeaderView =   self.userZoneTopView;
        
        
        if ( meModel.userGradeStats.count>0) {
             YWMeItemGroups *group = [YWMeItemGroups group];
           
            group.groupItems = meModel.userGradeStats;
            [self.groups addObject: group];
        }
        if (meModel.roomModeStats.count>0) {
            for (int i = 0; i<meModel.roomModeStats.count; i++) {
                   YMUserGameFlowStatM * userGameFlowStatM = meModel.roomModeStats[i];
                userGameFlowStatM.playmode = YES;
            }
            

         
            
            YWMeItemGroups *group = [YWMeItemGroups group];
            
            group.groupItems = meModel.roomModeStats;
            [self.groups addObject: group];
        }
          [self.tableView reloadData];
    }];

   
    
}


-(void)setTable{
    if ([self.userId isEqualToString:loginUid]) {
        self.tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, kTopHeight, LFscreenW, LFscreenH-kTopHeight) style:UITableViewStyleGrouped];
    }else{
        self.tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, kTopHeight, LFscreenW, LFscreenH-kTopHeight-kTabBarHeight) style:UITableViewStyleGrouped];
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
  
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


-(UIView * )tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
      YWMeItemGroups *group = self.groups[section];
    if (group.groupItems.count<=2) {
        return nil;
    }
   
    UIButton * vourcherHeartView = [[UIButton alloc] init];
    [vourcherHeartView setBackgroundColor:[UIColor whiteColor]];
    [vourcherHeartView setTitle:@"点击展示全部" forState:UIControlStateNormal];
    [vourcherHeartView setTitle:@"点击收起" forState:UIControlStateSelected];
    vourcherHeartView.tag = section+100;
    vourcherHeartView.titleLabel.font = [UIFont systemFontOfSize:14];
    //    [vourcherHeartView setTitle: group.header forState:UIControlStateNormal];
    [vourcherHeartView setTitleColor:[SVGloble colorWithHexString:@"#484848"] forState:UIControlStateNormal];
    [vourcherHeartView addTarget:self action:@selector(refreshLoad:) forControlEvents:UIControlEventTouchUpInside];
    
    if (group.firstHeard) {
        vourcherHeartView.selected = YES;
    }else{
       vourcherHeartView.selected = NO;
    }
    return vourcherHeartView;
 
  
}
-(void)refreshLoad:(UIButton * )bt{
       YWMeItemGroups *group = self.groups[bt.tag-100];
    if (bt.selected == YES) {
        group.firstHeard = NO;
        bt.selected = NO;
    }else{
        group.firstHeard = YES;
          bt.selected = YES;
       
    }
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:bt.tag-100];
//    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView reloadData];
    NSIndexPath * dayOne = [NSIndexPath indexPathForRow:0 inSection:bt.tag-100];
    [self.tableView scrollToRowAtIndexPath:dayOne atScrollPosition:UITableViewScrollPositionTop animated:YES];
//    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    
 
//    [self.tableView reloadSection:bt.tag-100 withRowAnimation:UITableViewRowAnimationNone];
//
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
     YWMeItemGroups *group = self.groups[section];
    if (group.groupItems.count<=2) {
         return 0.01f;
    }else{
      
         return 50.01f;
    }
  
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    YWMeItemGroups * group = self.groups[section];

    
   
    if (group.groupItems.count<=2) {
        return group.groupItems.count;
    }else{
        if (group.firstHeard) {
              return group.groupItems.count;
            
        }else{
              return 2;
          
        }
      
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 84;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
      YWMeItemGroups * group = self.groups[indexPath.section];
   YMUserGameFlowStatM * userGameFlowStatM = group.groupItems[indexPath.row];
    
 
    YWUserZoneTopViewTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellidenfder];
    cell.userGameFlowStatM = userGameFlowStatM;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    YWPlayRcordModel * playRcordModel = self.recordArr[indexPath.row];
    //    YWPlayRecordDrtailsViewController * playRecordDrtailsVc = [[YWPlayRecordDrtailsViewController alloc] init];
    //    playRecordDrtailsVc.userGameFlowId = playRcordModel.userGameFlowId;
    //    [self.navigationController pushViewController:playRecordDrtailsVc animated:YES];
    
}

@end
