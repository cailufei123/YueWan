//
//  SAModifyNicknameViewController.h
//  SkinAssistant
//
//  Created by 蔡路飞 on 2017/7/21.
//  Copyright © 2017年 LeGame. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SAModifyNicknameViewController : UIViewController
@property(nonatomic,copy)void(^refreshMePage)();
@property(nonatomic,strong)NSString * nickName;
@end
