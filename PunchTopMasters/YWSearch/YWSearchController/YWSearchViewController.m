//
//  YWSearchViewController.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/2.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWSearchViewController.h"
#import "YWSearchCell.h"
#import "YWSearchTabar.h"
#import "YWSearchScreenAlertView.h"
#import "YWSearchModel.h"
#import "WMSearchBar.h"
#import "YWRoomModel.h"
#import "YMRoomViewController.h"
#import "YWMinRoomView.h"
#import "YWDeleRoomAlertView.h"
#import "YWCreatePrasswordAlertView.h"

@interface YWSearchViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate,UISearchBarDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property (assign, nonatomic) BOOL  isStart;
@property (strong, nonatomic)YWSearchTabar * searchTabar ;
@property (strong, nonatomic)YWSearchScreenAlertView * screenAlertView ;
@property (strong, nonatomic)UIView * v;
@property (strong, nonatomic)YWSearchModel * searchModel;
@property (strong, nonatomic)NSMutableArray * searchModels;
@property (strong, nonatomic)ATHomeFavButton * lastBt ;
@property (strong, nonatomic)WMSearchBar * search ;
@property(nonatomic,strong)WMSearchBar *searchBar;

@property(nonatomic,strong)NSString * gameArea;
@property(nonatomic,strong)NSString * roomMode;
@property(nonatomic,strong)NSString * roomType;
@property(nonatomic,strong)NSString * segMatch;
@property(nonatomic,strong)YWRoomModel * roomModel;
@property(nonatomic,strong)YWMyRoomModel * myRoomModel;
@property(nonatomic,strong)YWMinRoomView * minRoomView;
/** 任务管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;
/** 页码*/
@property (nonatomic, assign) NSInteger page;

@property(nonatomic,strong)YWDeleRoomAlertView *deleRoomAlertView;
@property(nonatomic,strong)YWMyRoomModel * meRoomModel;
@property(nonatomic,strong) NSIndexPath * indexPath;
@end
static NSString * const cellidenfder = @"YWSearchCell";
@implementation YWSearchViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
    [self getmyRoom];
    [self loadNewData ];
}
-(void)getmyRoom{
      NSMutableDictionary *  myRoomDict = diction;myRoomDict[@"token"] =  loginToken;
    [YWRequestData myRoomDict:myRoomDict success:^(id responseObj) {
        self.myRoomModel = [YWMyRoomModel mj_objectWithKeyValues:responseObj[@"data"]];
        if (self.myRoomModel.roomId.length) {
            self.minRoomView.hidden = NO;
            self.minRoomView.myRoomModel = self.myRoomModel;
        }else{
            self.minRoomView.hidden = YES;
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
 self.v = [[UIView alloc] initWithFrame:CGRectMake(0, kTopHeight+40, LFscreenW, self.view.clf_height)];
    [self.view addSubview:self.v];self.v.backgroundColor = [UIColor blueColor];
   self.navigationItem.rightBarButtonItem =  [UIBarButtonItem itemWithText:@"搜索" target:self action:@selector(searchData)];
    [self setTable ];
    [self createRefresh ];
    self.searchTabar = [YWSearchTabar loadNameSearchTabarXib];
    self.searchTabar.searchViewController = self;
    self.searchTabar.frame = CGRectMake(0, kTopHeight, LFscreenW, 40);
    [self.view addSubview:self.searchTabar];
    WeakSelf(weakSelf)
    self.screenAlertView = [YWSearchScreenAlertView loadNameSearchScreenAlertViewXib];
    LFLog(@"%@",self.gameAreadict);
    if ([self.gameAreadict count] > 0) {
        self.gameArea = self.gameAreadict[@"number"];
          [self.searchTabar.gameAreabt setTitle:self.gameAreadict[@"name"] forState:UIControlStateNormal];
    }else{
        self.gameArea = @"0";
          [self.searchTabar.gameAreabt setTitle:@"游戏大区" forState:UIControlStateNormal];
    }
    if ([self.roomTypedict count] > 0) {
        self.roomType = self.roomTypedict[@"number"];
          [self.searchTabar.roomtypeBt setTitle:self.roomTypedict[@"name"] forState:UIControlStateNormal];
    }else{
        self.roomType = @"0";
          [self.searchTabar.roomtypeBt setTitle:@"房间类型" forState:UIControlStateNormal];
    }
    if ([self.segMatchdict count] >0) {
        self.segMatch = self.segMatchdict[@"number"];
          [self.searchTabar.segmentBt setTitle:self.segMatchdict[@"name"] forState:UIControlStateNormal];
    }else{
        self.segMatch = @"";
          [self.searchTabar.segmentBt setTitle:@"段位要求" forState:UIControlStateNormal];
    }
    self.roomMode = @"0";
   

    self.screenAlertView.sureClick = ^(NSMutableDictionary *dict ,NSInteger index) {
          [GKCover hideCover];
        if (index == 1) {
        weakSelf.segMatch = dict[@"number"];
        }else if (index == 2){
        weakSelf.gameArea = dict[@"number"];
        }else if (index == 3){
        weakSelf.roomType = dict[@"number"];
        }
        [weakSelf.lastBt setTitle:dict[@"name"] forState:UIControlStateNormal];
        [weakSelf loadNewData ];
    };
    
//    self.screenAlertView.gk_size = CGSizeMake(LFscreenW, 260);
    
   
    self.searchTabar.sureClickSearchTabar = ^(ATHomeFavButton *selectMatchBt) {
           weakSelf.screenAlertView.str = [NSString stringWithFormat:@"%ld",selectMatchBt.tag];
        weakSelf.lastBt = selectMatchBt;
        if (selectMatchBt.selected) {
//          [GKCover layoutSubViews];
            [GKCover coverFrom:  weakSelf.v   contentView:weakSelf.screenAlertView style:GKCoverStyleTransparent showStyle:GKCoverShowStyleTop showAnimStyle:GKCoverShowAnimStyleTop hideAnimStyle:GKCoverHideAnimStyleTop notClick:NO showBlock:^{
            } hideBlock:^{
                weakSelf.searchTabar.selectMatchBt.selected  = NO;
            }];
            weakSelf.screenAlertView.gk_y =0;           [GKCover layoutSubViews];
        }else{
          [GKCover hideCover];
        }

        
    };
    
    
    
//    _searchBar = [self addSearchBarWithFrame:CGRectMake(0, 0, kScreenWidth - 2 * 44 - 2 * 15, 44)];
  
    
    
      self.definesPresentationContext = YES;
     self.search = [[WMSearchBar alloc] initWithFrame:CGRectMake(0, 0, LFscreenW - 2 * 44 - 2 * 15, 20)];
    
   
 
    self.navigationItem.titleView =  self.search;
    
    
  

    self.search.translucent = YES;
    
    self.search.tintColor = [SVGloble colorWithHexString:@"#8E8E93"];
    self.search. placeholder = @"房间号";
//     self.search.searchFieldBackgroundPositionAdjustment = UIOffsetMake(50, 0); //设置textField里面文字在field中的位置
//     self.search.searchTextPositionAdjustment = UIOffsetMake(50, 0); //设置textField里面文字在field中的位置
    self.search.searchBarStyle =  UISearchBarStyleMinimal ;
//     self.bottom.backgroundColor = [SVGloble colorFromHexString:@"#323445"];
//     self. search.t
    UITextField * searchField = [self.search valueForKey:@"_searchField"];
    searchField.font = [UIFont systemFontOfSize:14];
    searchField.textColor = [UIColor whiteColor];
//    [searchField setValue: self.search.tintColor forKeyPath:@"_placeholderLabel.textColor"];
    [searchField setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    searchField.keyboardType = UIKeyboardTypeNumberPad;
     searchField.layer.cornerRadius = 20.0f;

    
    searchField.layer.masksToBounds = YES;
//    self.navigationItem.titleView =  self.search;
//    UIView* backgroundView = [self.search subViewOfClassName:@"_UISearchBarSearchFieldBackgroundView"];
//    backgroundView.layer.cornerRadius = 20.0f;
//    backgroundView.clipsToBounds = YES;
  
    
    
//    CGFloat height = self.search.bounds.size.height;
//    CGFloat top = (height - 20.0) / 2.0;
//    CGFloat bottom = top;
//
//    self.search.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
//    //自定义搜索框放大镜的图标
//    [_searchBar setImage:[UIImage imageNamed:@"1"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
//
//    //设置bookMark图标的设置
//    [_searchBar setImage:[UIImage imageNamed:@"2"] forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateNormal];


    if (@available(iOS 11.0, *)) {
        [[self.search.heightAnchor constraintEqualToConstant:44.0] setActive:YES];
    }
    [self createMinRoom];

}
//创建最小化的房间进入房间
-(void)createMinRoom{
    WeakSelf(weakSelf)
    self.minRoomView = [YWMinRoomView loadNameMinRoomViewXib];
    self.minRoomView.masterDissolutionRoom = ^{
        [weakSelf loadNewData];
    };
    [self.view addSubview:self.minRoomView];
    self.minRoomView .frame = CGRectMake(20, LFscreenH-80, LFscreenW-40, 66);
      self.minRoomView.hidden = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTipcEnterRoom)];
    [self.minRoomView addGestureRecognizer:tap];
}
//点击最小化的房间进入房间
-(void)tapTipcEnterRoom{
    NSMutableDictionary *  getRoomDict = diction;getRoomDict[@"id"] =  self.myRoomModel.roomId;
    [YWRequestData getRoomDetailsDict:getRoomDict success:^(id responseObj) {
        
        YWRoomModel * roomModel = [YWRoomModel mj_objectWithKeyValues:responseObj[@"data"]];
        if ([roomModel.roomInfo.status isEqualToString:@"-1"]) {
            [MBManager showBriefAlert:@"房间已近解散"];
              self.minRoomView.hidden = YES;
            return ;
        }
        YMRoomViewController * roomViewC = [[YMRoomViewController alloc] init];
        roomViewC.roomId = self.myRoomModel.roomId;
        LFLog(@"%@", roomViewC.roomId);
        [self.navigationController pushViewController:roomViewC animated:YES];
      
    }];
    
}

//点击搜索房间
-(void)searchData{
     [self.search resignFirstResponder];
     UITextField * searchField = [self.search valueForKey:@"_searchField"];
    if ( searchField.text.length){
        
        NSMutableDictionary * dict = diction;dict[@"id"] = searchField.text;

        [YWRequestData getRoomDetailsDict:dict success:^(id responseObj) {
            LFLog(@"%@",responseObj);
            self.roomModel = [YWRoomModel mj_objectWithKeyValues:responseObj[@"data"]];
            
            if ( self.roomModel.result.length) {
                YMRoomViewController * roomViewC = [[YMRoomViewController alloc] init];
                roomViewC.roomId =  searchField.text;
                [self.navigationController pushViewController:roomViewC animated:YES];
            }else{
                [MBManager showBriefAlert:@"没有此房间"];
            }
        }];
        return;
    }
    [self  loadNewData];
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
    self.page = 1;
    NSMutableDictionary * dict = diction;
    dict[@"gameArea"] = self.gameArea;
    dict[@"roomMode"] = @"0";
    dict[@"roomType"] = self.roomType;
    dict[@"segMatch"] = self.segMatch;
    dict[@"page"] =@(self.page);
    dict[@"size"] =@"20";
    LFLog(@"%@",dict);
    [YWRequestData fastEnterRoomDict:dict success:^(id responseObject) {
         [self.tableView.mj_header endRefreshing];
        LFLog(@"%@",responseObject);
        self.searchModels = [YWSearchModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.tableView reloadData];
        if ( self.searchModels.count<20) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        self.isStart = self.searchModels.count>0?NO:YES;
        [self.tableView reloadEmptyDataSet];
    } failed:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
   
}
-(void)loadMoreData{
    self.page +=1;
    NSMutableDictionary * dict = diction;
    dict[@"gameArea"] = self.gameArea;
    dict[@"roomMode"] = @"0";
    dict[@"roomType"] = self.roomType;
    dict[@"segMatch"] = self.segMatch;
    dict[@"page"] =@(self.page);
    dict[@"size"] =@"20";
    LFLog(@"%@",dict);
    [YWRequestData fastEnterRoomDict:dict success:^(id responseObject) {
        [self.tableView.mj_header endRefreshing];
         [self.tableView.mj_footer endRefreshing];
        LFLog(@"%@",responseObject);
        NSMutableArray * array = [YWSearchModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.searchModels addObjectsFromArray:array];
        if (array.count<=0) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
      
        [self.tableView reloadData];
    } failed:^(NSError *error) {
         self.page -=1;
        [self.tableView.mj_header endRefreshing];
    }];
    
    
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"无搜索结果"];
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"无搜索结果";
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
-(void)setTable{
   
 self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 0, LFscreenW, LFscreenH-kTopHeight-40) style:UITableViewStylePlain];
    [self.v  addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor  =bagColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:cellidenfder bundle:nil] forCellReuseIdentifier:cellidenfder];
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    if (@available(iOS 11.0, *)) {
        [[self.search.heightAnchor constraintEqualToConstant:44.0] setActive:YES];
    
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
    
    return     self.searchModels.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 130;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.indexPath = indexPath;
    YWSearchModel * searchModel =  self.searchModels[indexPath.row];
    YWSearchCell * cell = [tableView dequeueReusableCellWithIdentifier:cellidenfder];
    cell.searchModel = searchModel;
    cell.backgroundColor = [UIColor redColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YWSearchModel * searchModel =  self.searchModels[indexPath.row];
    self.searchModel = searchModel;
    NSMutableDictionary * dict = diction;dict[@"token"] =  loginToken;
    [YWRequestData isEnterRoomWhitUserId:searchModel.roomId enterSuccess:^(BOOL isEnter, BOOL isMe,YWMyRoomModel * myRoomModel) {
        if (![searchModel.roomId isEqualToString:myRoomModel.roomId]) {
        
            if (!([searchModel.roomPass isEqualToString:@"null"]||searchModel.roomPass.length<=0) ) {
                WeakSelf(weakSelf)
                YWCreatePrasswordAlertView * createPrasswordView = [YWCreatePrasswordAlertView loadNameCreatePrasswordAlertViewXib];
                createPrasswordView.surepassword = ^(NSString *password) {
                    
                   
                    if ([password isEqualToString:searchModel.roomPass]) {
                        YMRoomViewController * roomViewC = [[YMRoomViewController alloc] init];
                        roomViewC.roomId =  searchModel.roomId;
                        [weakSelf.navigationController pushViewController:roomViewC animated:YES];
                    }else{
                         [MBManager showBriefAlert:@"密码不正确"];
                    }
                };
                createPrasswordView.clf_size = CGSizeMake(LFscreenW-40, 250);
                [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:createPrasswordView style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleCenter showAnimStyle:GKCoverShowAnimStyleBottom hideAnimStyle:GKCoverHideAnimStyleNone notClick:NO];
                
                return ;
            }
        }
       
        
        if (isEnter) {
          
            
            YMRoomViewController * roomViewC = [[YMRoomViewController alloc] init];
                             roomViewC.roomId =  searchModel.roomId;
                             [self.navigationController pushViewController:roomViewC animated:YES];
            
        }
        
        if (isMe) {
            self. meRoomModel = myRoomModel;
            self.deleRoomAlertView = [YWDeleRoomAlertView loadNameDeleRoomAlertViewXib];
            [self.deleRoomAlertView.alertImg setImage:[UIImage imageNamed:@"sure_alert_icon"]];
            self.deleRoomAlertView.messageLb.text = @"您加入新房间，将会解散原来的房间";
              [self.deleRoomAlertView.sureBt addTarget:self action:@selector(sureBtClick) forControlEvents:UIControlEventTouchUpInside];
            self.deleRoomAlertView.gk_size = CGSizeMake(LFscreenW-40, 250);
            [GKCover coverFrom:[UIApplication sharedApplication].keyWindow contentView:self.deleRoomAlertView style:GKCoverStyleTranslucent showStyle:GKCoverShowStyleCenter showAnimStyle:GKCoverShowAnimStyleCenter hideAnimStyle:GKCoverHideAnimStyleCenter notClick:NO showBlock:^{
            } hideBlock:^{
                
            }];
            
        }
    }];

    
}
-(void)sureBtClick{
    
  
   
    NSMutableDictionary * deledict = diction;
    deledict[@"roomId"] =  self. meRoomModel.roomId;
    [YWRequestData deleRoomDict:deledict success:^(id responseObj) {
        [GKCover hideCover];
          NSMutableDictionary *  myRoomDict = diction;myRoomDict[@"token"] =  loginToken;
        [YWRequestData myRoomDict:myRoomDict success:^(id responseObj) {
            self.myRoomModel = [YWMyRoomModel mj_objectWithKeyValues:responseObj[@"data"]];
            if (self.myRoomModel.roomId.length) {
                self.minRoomView.hidden = NO;
                self.minRoomView.myRoomModel = self.myRoomModel;
            }else{
                for (int i = 0; i< self.searchModels.count; i++) {
                    YWSearchModel * searchModel = self.searchModels[i];
                    if ([searchModel.roomId isEqualToString:self. meRoomModel.roomId]) {
                        [self.searchModels removeObject:searchModel];
                       [self.tableView deleteRow:i inSection:0 withRowAnimation:UITableViewRowAnimationNone];
                      
                    }
                   
                }
             
                
                self.minRoomView.hidden = YES;
                YMRoomViewController * roomViewC = [[YMRoomViewController alloc] init];
                roomViewC.roomId =   self.searchModel.roomId;
                [self.navigationController pushViewController:roomViewC animated:YES];
            }
        }];
        
    }];
}






-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self.search resignFirstResponder];
}
@end
