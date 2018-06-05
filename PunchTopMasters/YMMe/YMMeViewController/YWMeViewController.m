//
//  YWMeViewController.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/3/15.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWMeViewController.h"
#import "YWChatViewController.h"
#import "YWMeSetViewController.h"
#import "YWMeTableViewCell.h"
#import "YWMeTopView.h"
#import "YWMeItemGroups.h"
#import "YWMeTitleItem.h"
#import "YMMeModel.h"
#import "ImagePicker.h"
#import "LKHTTPSessionManager.h"
#import "YWCouponController.h"
#import "YWPlayRecordController.h"
#import "YWUserZoneController.h"
#import "SAModifyNicknameViewController.h"
#import "ATPresentCionsViewController.h"
#import "ATServiceAgreementController.h"
#import "YWFollowFansViewController.h"
#import <UShareUI/UShareUI.h>
#import "YWUserZoneController.h"

@interface YWMeViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
{
    
    ImagePicker *imagePicker;
    
}
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)YWMeTopView * meTopView;
@property (nonatomic, strong) NSMutableArray *groups;
@property (nonatomic, strong) YMMeModel * meModel;
/** 任务管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) NSMutableDictionary *skipShareDic;
@end

static NSString * cellidenfder = @"YWMeTableViewCell";
@implementation YWMeViewController
static UIWindow *window_;
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadUserPage];
}
-(void)loadUserPage{
    NSMutableDictionary * dict = diction;
    dict[@"userId"] = loginUid;
    dict[@"isStat"] = @"1";
    [YWRequestData userHomePageDict:dict success:^(id responseObj) {
        YMMeModel * meModel = [YMMeModel mj_objectWithKeyValues:responseObj[@"data"]];
         [USER_DEFAULT setObject:meModel.user.icon forKey:loginToken];
        self.meModel = meModel;
        self.meTopView.meModel = meModel;
    }];
    NSMutableDictionary * getCoinDict1 = diction;
    getCoinDict1[@"token"] = loginToken;
    [YWRequestData getCoinDict:getCoinDict1 success:^(id responseObj) {
        self.meTopView.makeMoneyLb.text = [NSString stringWithFormat:@"在[约玩]赚了%@元",responseObj[@"data"][@"mobileCoin"]];

    }];
    
    
}

- (NSMutableArray *)groups
{
    if (_groups == nil) {
        self.groups = [NSMutableArray array];
    }
    return _groups;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
  
//self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"me_set_icon" selectImage:@"me_set_icon" target:self action:@selector(setClick)];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"me_set_icon" highImage:@"me_set_icon" target:self action:@selector(setClick)];
    [self setTable];
    [self setupGroups];
      imagePicker = [ImagePicker sharedManager];
    [self.meTopView.userIcon addTarget:self action:@selector(userIconBtClick) forControlEvents:UIControlEventTouchUpInside];
      [self.meTopView.fanctBt addTarget:self action:@selector(fanctBtClick) forControlEvents:UIControlEventTouchUpInside];
      [self.meTopView.followbt addTarget:self action:@selector(followbtBtClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)followbtBtClick{
    YWFollowFansViewController * followFansVc = [[YWFollowFansViewController alloc] init];
    followFansVc.selectedSegmentIndex = 0;
    [self.navigationController pushViewController:followFansVc animated:YES];
}
-(void)fanctBtClick{
    
    YWFollowFansViewController * followFansVc = [[YWFollowFansViewController alloc] init];
    followFansVc.selectedSegmentIndex = 1;
    [self.navigationController pushViewController:followFansVc animated:YES];

}
-(void)userIconBtClick{
    [self show];
}
-(void)setClick{
    YWMeSetViewController * setVc = [[YWMeSetViewController alloc] init];
    [self.navigationController pushViewController:setVc animated:YES];
  
}
/**
 *  初始化模型数据
 */
- (void)setupGroups
{
    [self.groups removeAllObjects];
    [self setupGroup];
    [self.tableView reloadData];
}


- (void)setupGroup
{
    
    // 1.创建组
    YWMeItemGroups *group = [YWMeItemGroups group];
    [self.groups addObject:group];
    
    YWMeTitleItem * playgameRecord = [YWMeTitleItem itemWithTitle:@"开黑记录" subtitle:@"" mosaicBool:NO];
    playgameRecord.imageName = @"me_playagame_record";
      playgameRecord.controllerName = @"YWPlayRecordController";

    
//
//    YWMeTitleItem * bindMobileItem = [YWMeTitleItem itemWithTitle:@"邀请好友得现金" subtitle:@"" mosaicBool:NO];
//    bindMobileItem.imageName = @"me_invitation_friend";
//
    
    
   
    YWMeTitleItem * modifyPasswordItem = [YWMeTitleItem itemWithTitle:@"帮助中心" subtitle:@"" mosaicBool:NO];
    modifyPasswordItem.imageName = @"me_help_centre";
     modifyPasswordItem.controllerName = @"ATServiceAgreementController";
    
    YWMeTitleItem * meCollectionItem = [YWMeTitleItem itemWithTitle:@"问题反馈" subtitle:@"" mosaicBool:NO];
    meCollectionItem.imageName = @"me_problem_feedback";
       meCollectionItem.controllerName = @"YWProblemFeedbackViewController";
    
   
    
    group.groupItems = @[playgameRecord,modifyPasswordItem,meCollectionItem];
}

-(void)setTable{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, kTopHeight, LFscreenW, LFscreenH-kTopHeight-kTabBarHeight) style:UITableViewStylePlain];
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
    WeakSelf(weakSelf)
    YWMeTopView * meTopView = [YWMeTopView loadNameMeTopViewXib];
    self.meTopView = meTopView;
    [meTopView.goToXy addTarget:self action:@selector(goToXyBtClick) forControlEvents:UIControlEventTouchUpInside];
    meTopView.followClick = ^{
        ATPresentCionsViewController * couponVc = [[ATPresentCionsViewController alloc] init];
        [weakSelf.navigationController pushViewController:couponVc animated:YES];
    };
    [meTopView.modifyBt addTarget:self action:@selector(modifyBtClick) forControlEvents:UIControlEventTouchUpInside];
    meTopView.couponClick = ^{
        YWCouponController * couponVc = [[YWCouponController alloc] init];
        [weakSelf.navigationController pushViewController:couponVc animated:YES];
        
        
     
    };
    [meTopView.goToPresonCnter addTarget:self action:@selector(goToPresonCnterBtClick) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableHeaderView = meTopView;
}
-(void)goToPresonCnterBtClick{
    
  
    YWUserZoneController * userZoneVc = [[YWUserZoneController alloc] init];
    userZoneVc.userId =    self.meModel.user .userId;
    [self.navigationController pushViewController:userZoneVc animated:YES];
}
-(void)goToXyBtClick{
    
  
   
    LFLog(@"%@",URL_CONFIGS);
        
        [LFHttpTool post:URL_CONFIGS params:nil progress:^(id downloadProgress) {
            
        } success:^(id responseObj) {
            LFLog(@"%@",responseObj);
            if ([responseObj[@"status"] isEqual:@(0)]) {
               self.skipShareDic = responseObj[@"data"][@"SHARE_INVITE_IOS"];
                [self skipShare ];
            }
            
            
        } failure:^(NSError *error) {
            
        }];
    
}

-(void)skipShare{
    if (!loginTokenlength) {
        [ATSKIPTOOl loginAction:self];
        return;
    }
    
    //配置上面需求的参数
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),]];
    [UMSocialShareUIConfig shareInstance].shareTitleViewConfig.isShow = YES;
    [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageMaxRowCountForLandscapeAndBottom = 1;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageMaxColumnCountForLandscapeAndBottom = 1;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageMaxRowCountForPortraitAndBottom = 1;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageMaxColumnCountForLandscapeAndBottom = 3;
     [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageMaxColumnCountForPortraitAndMid = 3;
     [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageMaxColumnCountForPortraitAndBottom = 3;
     [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageMaxColumnCountForLandscapeAndMid = 3;
    
    //    [UMSocialShareUIConfig shareInstance].shareCancelControlConfig.isShow = NO;
    //    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewBackgroundColor = [UIColor redColor];
    //    //每页的背景颜色为黄色
    //    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageBGColor = [UIColor yellowColor];
    //去掉毛玻璃效果
    [UMSocialShareUIConfig shareInstance].shareContainerConfig.isShareContainerHaveGradient = NO;
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        [self shareImageAndTextToPlatformType:platformType];
    }];
    
    
}
- (void)shareImageAndTextToPlatformType:(UMSocialPlatformType)platformType
{
    
    UIImage *image = nil;
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    NSString * valueStr =  self.skipShareDic[@"value"];
//    NSString * tokenUrl = [valueStr stringByReplacingOccurrencesOfString:@"periodId={periodId}&goodId={goodId}&osType={osType}" withString:[NSString stringWithFormat:@"periodId=%@&goodId=%@&osType=%@", self.orderDateilsModel.orderVo.periodId, self.orderDateilsModel.orderVo.productId,@"2"]];
//
//    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:tokenUrl]];
    
    //    if(tokenUrl.length) {
    //        image = [UIImage imageWithData:data]; // 取得图片
    //    }else{
    //        NSDictionary *infoPlist = [[NSBundle mainBundle] infoDictionary];
    //        NSString *icon = [[infoPlist valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
    //        image = [UIImage imageNamed:icon];
    //    }
    NSDictionary *infoPlist = [[NSBundle mainBundle] infoDictionary];
    NSString *icon = [[infoPlist valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
    image = [UIImage imageNamed:icon];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle: self.skipShareDic[@"desc"] descr:@"" thumImage:image];
    //设置网页地址
    shareObject.webpageUrl =valueStr;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

-(void)modifyBtClick{
    
    SAModifyNicknameViewController * changageVc = [[SAModifyNicknameViewController alloc] init];
    changageVc.nickName = self.meModel.user.name;
    [self.navigationController pushViewController:changageVc animated:YES];
    
   
//    YWUserZoneController *  userZoneVc = [[YWUserZoneController alloc] init];
//    userZoneVc.userId = self.meModel.user.userId;
//    [self.navigationController pushViewController:userZoneVc animated:YES];
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
    
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
    YWMeItemGroups * group = self.groups[section];
    return    group.groupItems.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 54;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YWMeItemGroups * group = self.groups[indexPath.section];
    
   YWMeTitleItem * meTitleItem  = group.groupItems[indexPath.row];
    YWMeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellidenfder];
    cell.meTitleItem = meTitleItem;
 
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YWMeItemGroups * group = self.groups[indexPath.section];
    
    YWMeTitleItem * meTitleItem  = group.groupItems[indexPath.row];
    
    
    
    if ([meTitleItem.controllerName isEqualToString:@"ATServiceAgreementController"]) {
        ATServiceAgreementController * serviceAgreementVc = [[ATServiceAgreementController alloc] init];
        serviceAgreementVc.htmlurl = HELP_SERVER;
        serviceAgreementVc.htmltitle = @"帮助中心";
        [self.navigationController pushViewController:serviceAgreementVc animated:YES];
    }else{
         [self pushToViewControllerWithClassName:meTitleItem.controllerName];
    }
    
   
    
}
-(void)show {
    //1.创建窗口
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelWithCompletion)];
    window_ = [[UIWindow alloc] init];
    window_.frame = [UIScreen mainScreen].bounds;
    window_.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    window_.hidden = NO;
    UIView * bagView = [[UIView alloc] init];
    bagView.backgroundColor = [UIColor clearColor];
    bagView.frame = window_.bounds;
    [window_ addSubview:bagView];
    [self selectPickView:bagView];
    
    [bagView addGestureRecognizer:tap];
    
}

-(void)selectPickView:(UIView*)bagView{
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//    NSDictionary * userDic =  [user objectForKey:getuserMessage];
//    SAPresonMessageModel *  presonMessageModel=  [SAPresonMessageModel mj_objectWithKeyValues:userDic];
//
    
    
    
    //    [self assignmentData: userDic];
    UIImageView * iamgeVew = [[UIImageView alloc] initWithFrame:CGRectMake(0, 106, LFscreenW, LFscreenW)];
    [iamgeVew sd_setImageWithURL:[NSURL URLWithString: self.meModel .user.icon] placeholderImage:[UIImage imageNamed:@"上传照片头像-默认"]];
    [bagView addSubview:iamgeVew];
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, iamgeVew.clf_bottom+50, LFscreenW-22, 44)];
    button.centerX = LFscreenW/2;
    [button setTitle:@"更换头像" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    [button setTitleColor:bkColor forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor whiteColor]];
    [button layercornerRadius:3];
    [button addTarget:self action:@selector(updataImageBtC) forControlEvents:UIControlEventTouchUpInside];
    [bagView addSubview:button];
    UIButton * button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, button.clf_bottom+10, LFscreenW-22, 44)];
    button1.centerX = LFscreenW/2;
    [button1 setTitle:@"取消" forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont systemFontOfSize:18];
    [button1 setTitleColor:bkColor forState:UIControlStateNormal];
    [button1  setBackgroundColor:[UIColor whiteColor]];
    [button1 layercornerRadius:3];
    [bagView addSubview:button1];
    [button1 addTarget:self action:@selector(cancelWithCompletion) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)updataImageBtC{
    [self cancelWithCompletion];
    //设置主要参数
    [imagePicker dwSetPresentDelegateVC:self SheetShowInView:self.view InfoDictionaryKeys:(long)nil];
    
    //回调
    [imagePicker dwGetpickerTypeStr:^(NSString *pickerTypeStr) {
        
        NSLog(@"%@",pickerTypeStr);
        
    } pickerImagePic:^(UIImage *pickerImagePic) {
        
        
        [self updataImage:pickerImagePic];
        
    }];
    
    
}
/**上传图片*/
-(void)updataImage:(UIImage * )iconImage {
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    //1.创建网络管理者
    LKHTTPSessionManager *manager = [LKHTTPSessionManager manager];
    //立马显示进度值（防止因为网速，导致显示的是其他图片的下载进度）
    
    //[self.progressView setProgress:0 animated:NO];
    [MBManager showWaitingWithTitle:@"上传中.."];
    // 3.发送请求
    LFLog(@"%@",USER_IMG_UPLOAD);
    [manager POST:USER_IMG_UPLOAD  parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = UIImageJPEGRepresentation(iconImage, 0.8);//进行图片压缩
        // 使用日期生成图片名称
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg",[formatter stringFromDate:[NSDate date]]];
        // 任意的二进制数据MIMEType application/octet-stream
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //        LFLog(@"%lld  %lld",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
        //        //        //计算进度值
        //        self.progressView.hidden = NO;
        //        //计算进度值
        //        self.pictureProgress = (1.0 * uploadProgress.completedUnitCount) / (uploadProgress.totalUnitCount);
        //        //显示进度值
        //        [self.progressView setProgress:self.pictureProgress animated:NO];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSLog(@"%@",responseObject);
        [self modifyImage:responseObject[@"data"]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBManager hideAlert];
        [MBManager showBriefAlert:@"上传失败"];
        
    }];
    
}
-(void)modifyImage:(NSString *)imageUrl{
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"token"] = loginToken;
    dict[@"icon"] = imageUrl;
    
    [LFHttpTool post:USER_IMG_MODIFY params:dict progress:^(id downloadProgress) {
        
    } success:^(id responseObj) {
        [self loadUserPage];
        [MBManager hideAlert];
    } failure:^(NSError *error) {
        [MBManager hideAlert];
        [MBManager showBriefAlert:@"上传失败"];
    }];
    
    
}

-(void)cancelWithCompletion{
    window_.hidden = YES;
    window_ = nil;
    
    
}

-(void)pushToViewControllerWithClassName:(NSString *)className {
    if (className != nil) {
        id myObj = [[NSClassFromString(className) alloc] init];
        @try {
            [self.navigationController pushViewController:myObj animated:YES];
        }
        @catch (NSException *exception) {
            // 捕获到的异常exception
        }
        @finally {
            // 结果处理
        }
    }
}


@end
