//
//  YWChatViewController.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/3/9.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWChatViewController.h"
#import <Hyphenate/Hyphenate.h>
 #import "EaseUI.h"

#import "YWCustomMessageCell.h"
//#import "EaseEmotionManager.h"
@interface YWChatViewController ()<UIAlertViewDelegate,EMClientDelegate,EaseMessageViewControllerDelegate,EaseMessageViewControllerDataSource>
@property (nonatomic) NSMutableDictionary *emotionDic;
@end
static NSString * const cellidenfder = @"YWCustomMessageCell";
@implementation YWChatViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = self.name;
     self.view.backgroundColor = bagColor1;
    self.tableView.backgroundColor = bagColor;
     self.showRefreshHeader = YES;
 
    self.delegate = self;
    self.dataSource = self;
  [[EaseMessageCell appearance] setMessageTextFont:[UIFont systemFontOfSize:9]];//消息
    
//    UIView *inputView = [[UIView alloc] init];//CustomerInputView用户自定义底部输入框
//    inputView.backgroundColor = [UIColor redColor];
//    [self setChatToolbar:inputView];
      [self.tableView registerNib:[UINib nibWithNibName:cellidenfder bundle:nil] forCellReuseIdentifier:cellidenfder];
//    self.view.clf_height = 100;
    
    [[EaseMessageCell appearance] setMessageTextFont:[UIFont systemFontOfSize:15]];//消息显示字体
    
    [[EaseMessageCell appearance] setMessageTextColor:[SVGloble colorWithHexString:@"#2A2A2A"]];//消息显示颜色
    
    [[EaseMessageCell appearance] setMessageLocationFont:[UIFont systemFontOfSize:5]];//位置消息显示字体
    
    [[EaseMessageCell appearance] setMessageLocationColor:[UIColor whiteColor]];//位置消息显示颜色
    [EaseBaseMessageCell appearance].messageNameIsHidden = YES;;//位置消息显示颜色
     [EaseBaseMessageCell appearance].avatarSize = 40;//位置消息显示颜色
    [EaseMessageCell appearance].bubbleMargin =  UIEdgeInsetsMake(5, 0, 5, 0);
    [EaseMessageCell appearance].hasRead.hidden = YES;
     [EaseMessageCell appearance].statusButton.hidden = YES;
   
//     [[EaseChatBarMoreView appearance] removeItematIndex:2];
//    [[EaseChatBarMoreView appearance] removeItematIndex:2];
    [EaseMessageTimeCell appearance].titleLabelColor = deepGrayColor;
      EaseChatToolbar *toolbar = (EaseChatToolbar*)self.chatToolbar;
   
    toolbar.inputTextView.backgroundColor = [UIColor whiteColor];
    toolbar.inputTextView.placeHolder = @"请输入文字";
//    toolbar.inputTextView.font = [UIFont systemFontOfSize:15];
    toolbar.inputTextView.placeHolderTextColor = deepGrayColor;
//    toolbar.toolbarBackgroundImageView.backgroundColor = [SVGloble colorFromHexString:@"#CCCCCC"];
//    [self.chatBarMoreView removeItematIndex:1];
//      [self.chatBarMoreView removeItematIndex:2];
//      [self.chatBarMoreView removeItematIndex:2];
   
      toolbar.toolbarBackgroundImageView.backgroundColor = bagColor1;
//  [EaseMessageCell appearance].rightBubbleMargin =  UIEdgeInsetsMake(0, 0, 0, 0);
//    hasRead
//    @property (nonatomic) UIEdgeInsets bubbleMargin UI_APPEARANCE_SELECTOR; //default UIEdgeInsetsMake(8, 0, 8, 0);
//
//    @property (nonatomic) UIEdgeInsets leftBubbleMargin UI_APPEARANCE_SELECTOR; //default UIEdgeInsetsMake(8, 15, 8, 10);
//
//    @property (nonatomic) UIEdgeInsets rightBubbleMargin UI_APPEARANCE_SELECTOR; //default UIEdgeInsetsMake(8, 10, 8, 15);
}
//- (void)tableViewDidTriggerHeaderRefresh {
//    //子类需要重写此方法
//
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}

- (NSArray*)emotionFormessageViewController:(EaseMessageViewController *)viewController
{
    NSMutableArray *emotions = [NSMutableArray array];
    for (NSString *name in [EaseEmoji allEmoji]) {
        EaseEmotion *emotion = [[EaseEmotion alloc] initWithName:@"" emotionId:name emotionThumbnail:name emotionOriginal:name emotionOriginalURL:@"" emotionType:EMEmotionDefault];
        [emotions addObject:emotion];
    }
    EaseEmotion *temp = [emotions objectAtIndex:0];
    EaseEmotionManager *managerDefault = [[EaseEmotionManager alloc] initWithType:EMEmotionDefault emotionRow:3 emotionCol:8 emotions:emotions tagImage:[UIImage imageNamed:temp.emotionId]];
    
    
    
    
    NSMutableArray *emotionGifs = [NSMutableArray array];
    _emotionDic = [NSMutableDictionary dictionary];
    NSArray *names = @[@"icon_002",@"icon_007",@"icon_010",@"icon_012",@"icon_013",@"icon_018",@"icon_019",@"icon_020",@"icon_021",@"icon_022",@"icon_024",@"icon_027",@"icon_029",@"icon_030",@"icon_035",@"icon_040"];
    int index = 0;
    for (NSString *name in names) {
        index++;
        EaseEmotion *emotion = [[EaseEmotion alloc] initWithName:[NSString stringWithFormat:@"[示例%d]",index] emotionId:[NSString stringWithFormat:@"em%d",(1000 + index)] emotionThumbnail:[NSString stringWithFormat:@"%@_cover",name] emotionOriginal:[NSString stringWithFormat:@"%@",name] emotionOriginalURL:@"" emotionType:EMEmotionGif];
        [emotionGifs addObject:emotion];
        [_emotionDic setObject:emotion forKey:[NSString stringWithFormat:@"em%d",(1000 + index)]];
    }
    EaseEmotionManager *managerGif= [[EaseEmotionManager alloc] initWithType:EMEmotionGif emotionRow:2 emotionCol:5 emotions:emotionGifs tagImage:[UIImage imageNamed:@"icon_002_cover"]];
    
    
    
    
    
    
    
    
    
    return @[managerDefault];
}
- (BOOL)isEmotionMessageFormessageViewController:(EaseMessageViewController *)viewController
                                    messageModel:(id<IMessageModel>)messageModel
{
    BOOL flag = NO;
    if ([messageModel.message.ext objectForKey:MESSAGE_ATTR_IS_BIG_EXPRESSION]) {
        return YES;
    }
    return flag;
}

- (EaseEmotion*)emotionURLFormessageViewController:(EaseMessageViewController *)viewController
                                      messageModel:(id<IMessageModel>)messageModel
{
    NSString *emotionId = [messageModel.message.ext objectForKey:MESSAGE_ATTR_EXPRESSION_ID];
    EaseEmotion *emotion = [_emotionDic objectForKey:emotionId];
    if (emotion == nil) {
        emotion = [[EaseEmotion alloc] initWithName:@"" emotionId:emotionId emotionThumbnail:@"" emotionOriginal:@"" emotionOriginalURL:@"" emotionType:EMEmotionGif];
    }
    return emotion;
}

- (NSDictionary*)emotionExtFormessageViewController:(EaseMessageViewController *)viewController
                                        easeEmotion:(EaseEmotion*)easeEmotion
{
    return @{MESSAGE_ATTR_EXPRESSION_ID:easeEmotion.emotionId,MESSAGE_ATTR_IS_BIG_EXPRESSION:@(YES)};
}
//- (void)tableViewDidTriggerFooterRefresh {
//    //子类需要重写此方法
//    
//}
//具体创建自定义Cell的样例：
//- (UITableViewCell *)messageViewController:(UITableView *)tableView cellForMessageModel:(id<IMessageModel>)model
//{
//    //样例为如果消息是文本消息显示用户自定义cell
//    if (model.bodyType == EMMessageBodyTypeText) {
//
//        // 收到的文字消息
//        EMTextMessageBody *textBody =(EMTextMessageBody *) model.message.body;
//        NSString *txt = textBody.text;
//        NSLog(@"收到的文字是 txt -- %@",txt);
//        //CustomMessageCell为用户自定义cell,继承了EaseBaseMessageCell
//         YWCustomMessageCell * cell = [tableView dequeueReusableCellWithIdentifier:cellidenfder];
//
//        return cell;
//    }
//    return nil;
//}
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    if ([text isEqualToString:@"\n"]){
//        if(self.delegate && [self.delegate respondsToSelector:@selector(didSendText:)]) {
//            [self.delegate didSendText:self.textView.text];
//        }
//        self.textView.text = @"";
//        self.placeholderLabel.text = @"说点什么吧...";
//        return NO;
//    }
//    return YES;
//}


//// 收到消息的回调，带有附件类型的消息可以用 SDK 提供的下载附件方法下载（后面会讲到）
//- (void)messagesDidReceive:(NSArray *)aMessages {
//    for (EMMessage *message in aMessages) {
//        EMMessageBody *msgBody = message.body;
//        switch (msgBody.type) {
//            case EMMessageBodyTypeText:
//            {
//                // 收到的文字消息
//                EMTextMessageBody *textBody = (EMTextMessageBody *)msgBody;
//                NSString *txt = textBody.text;
//                NSLog(@"收到的文字是 txt -- %@",txt);
//            }
//                break;
//            case EMMessageBodyTypeImage:
//            {
//                // 得到一个图片消息body
//                EMImageMessageBody *body = ((EMImageMessageBody *)msgBody);
//                NSLog(@"大图remote路径 -- %@"   ,body.remotePath);
//                NSLog(@"大图local路径 -- %@"    ,body.localPath); // // 需要使用sdk提供的下载方法后才会存在
//                NSLog(@"大图的secret -- %@"    ,body.secretKey);
//                NSLog(@"大图的W -- %f ,大图的H -- %f",body.size.width,body.size.height);
//                NSLog(@"大图的下载状态 -- %lu",body.downloadStatus);
//
//
//                // 缩略图sdk会自动下载
//                NSLog(@"小图remote路径 -- %@"   ,body.thumbnailRemotePath);
//                NSLog(@"小图local路径 -- %@"    ,body.thumbnailLocalPath);
//                NSLog(@"小图的secret -- %@"    ,body.thumbnailSecretKey);
//                NSLog(@"小图的W -- %f ,大图的H -- %f",body.thumbnailSize.width,body.thumbnailSize.height);
//                NSLog(@"小图的下载状态 -- %lu",body.thumbnailDownloadStatus);
//            }
//                break;
//            case EMMessageBodyTypeLocation:
//            {
//                EMLocationMessageBody *body = (EMLocationMessageBody *)msgBody;
//                NSLog(@"纬度-- %f",body.latitude);
//                NSLog(@"经度-- %f",body.longitude);
//                NSLog(@"地址-- %@",body.address);
//            }
//                break;
//            case EMMessageBodyTypeVoice:
//            {
//                // 音频sdk会自动下载
//                EMVoiceMessageBody *body = (EMVoiceMessageBody *)msgBody;
//                NSLog(@"音频remote路径 -- %@"      ,body.remotePath);
//                NSLog(@"音频local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在（音频会自动调用）
//                NSLog(@"音频的secret -- %@"        ,body.secretKey);
//                NSLog(@"音频文件大小 -- %lld"       ,body.fileLength);
//                NSLog(@"音频文件的下载状态 -- %lu"   ,body.downloadStatus);
//                NSLog(@"音频的时间长度 -- %lu"      ,body.duration);
//            }
//                break;
//            case EMMessageBodyTypeVideo:
//            {
//                EMVideoMessageBody *body = (EMVideoMessageBody *)msgBody;
//
//                NSLog(@"视频remote路径 -- %@"      ,body.remotePath);
//                NSLog(@"视频local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在
//                NSLog(@"视频的secret -- %@"        ,body.secretKey);
//                NSLog(@"视频文件大小 -- %lld"       ,body.fileLength);
//                NSLog(@"视频文件的下载状态 -- %lu"   ,body.downloadStatus);
//                NSLog(@"视频的时间长度 -- %lu"      ,body.duration);
//                NSLog(@"视频的W -- %f ,视频的H -- %f", body.thumbnailSize.width, body.thumbnailSize.height);
//
//                // 缩略图sdk会自动下载
//                NSLog(@"缩略图的remote路径 -- %@"     ,body.thumbnailRemotePath);
//                NSLog(@"缩略图的local路径 -- %@"      ,body.thumbnailLocalPath);
//                NSLog(@"缩略图的secret -- %@"        ,body.thumbnailSecretKey);
//                NSLog(@"缩略图的下载状态 -- %lu"      ,body.thumbnailDownloadStatus);
//            }
//                break;
//            case EMMessageBodyTypeFile:
//            {
//                EMFileMessageBody *body = (EMFileMessageBody *)msgBody;
//                NSLog(@"文件remote路径 -- %@"      ,body.remotePath);
//                NSLog(@"文件local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在
//                NSLog(@"文件的secret -- %@"        ,body.secretKey);
//                NSLog(@"文件文件大小 -- %lld"       ,body.fileLength);
//                NSLog(@"文件文件的下载状态 -- %lu"   ,body.downloadStatus);
//            }
//                break;
//
//            default:
//                break;
//        }
//    }
//}
// 数据源方法
- (id<IMessageModel>)messageViewController:(EaseMessageViewController *)viewController
                           modelForMessage:(EMMessage *)message{
    
    id<IMessageModel> model = nil;
    // 根据聊天消息生成一个数据源Model
    //NSLog(@"-======%@",message.from);
    //debugObj(message.ext);
    
    model = [[EaseMessageModel alloc] initWithMessage:message];
    NSDictionary * messageDic = message.ext;
    
//   UserInfoModel * userinfoModel = [ChatUserDataManagerHelper queryByuserEaseMobId:messageDic[CHATUSERID]];
//
//    if (userinfoModel != nil) {
//
//        model.nickname      = userinfoModel.usernickName;
//        model.avatarURLPath = userinfoModel.userHeaderImageUrl;
//    }
    // 默认头像
    
 
    
    model = [[EaseMessageModel alloc] initWithMessage:message];
    if (model.isSender) {
        NSLog(@"自己发送");
        
//        model.message.ext = @{@"avatar":@"http://7xrpiy.com1.z0.glb.clouddn.com/babyShow/1462945613-0",@"nick":@"自己本人的昵称"};
        //头像
        //NSLog(@"***++++**%@",model.message);
       model.avatarURLPath =  [USER_DEFAULT objectForKey: loginToken];;
        //NSLog(@"******%@",model.avatarURLPath);
        //昵称
        model.nickname = @"自己的名字";
        //头像占位图
        model.failImageName = @"sunlei.jpg";
        
    }else{
        NSLog(@"对方发送");
        //头像
        model.avatarURLPath = model.message.ext[@"avatar"];
        //NSLog(@"+++++++______+++%@",model.avatarURLPath);
        //昵称
//        model.nickname = model.message.ext[@"nick"];
           model.avatarURLPath = self.icon;
         model.nickname = @"他人的名字";
        //头像占位图
        model.failImageName = @"sunlei.jpg";
        
    }
    //NSLog(@"+++++++++++%@",model.message);
    return model;
    
 
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    if ([text isEqualToString:@"\n"]){
//        if(self.delegate && [self.delegate respondsToSelector:@selector(didSendText:)]) {
//            [self.delegate didSendText:self.textView.text];
//        }
//        self.textView.text = @"";
//        self.placeholderLabel.text = @"说点什么吧...";
//        return NO;
//    }
    return YES;
}

//- (void)loadLocalChatRecords
//{
////    [[EMClient sharedClient].chatManager
//  EMConversation *conversation = [[EMClient sharedClient].chatManager getConversation:@"001" type:EMConversationTypeChat createIfNotExist:YES];
//    NSArray *messages = [conversation loadAllMessages]; // 获取会话中的全部聊天记录。
//    NSArray *messages = [conversation loadAllMessages]; // 获取会话中的全部聊天记录。
//    NSArray *messages = [conversation loadMessagesWithIds:@[@"msgid1",@"msgid2",@"msgid3"]]; // 根据messageid获取消息
//    EMMessage *msg = [conve
//
////    EMConversation *conversation = [[EaseMob sharedInstance].chatManager conversationForChatter:self.buddy.username conversationType:eConversationTypeChat];
////    NSArray *messages = [conversation loadAllMessages];
////    // 加载与当前聊天用户的所有聊记录
////    NSArray *messages = [conversation loadAllMessages];
////
////    // 添加到数据源
////    [self.dataSources addObjectsFromArray:messages];
//}
@end
