//
//  SAWetChatWebViewController.h
//  SkinAssistant
//
//  Created by 蔡路飞 on 2017/7/10.
//  Copyright © 2017年 LeGame. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SAWetChatWebViewController : UIViewController
@property(nonatomic,strong)NSString * payResultUrl;
@property(nonatomic,copy)void(^payVerification)(void);
@end
