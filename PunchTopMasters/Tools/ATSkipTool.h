//
//  ATSkipTool.h
//  Auction
//
//  Created by 蔡路飞 on 2017/11/3.
//  Copyright © 2017年 Cailufei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YWHomeModel.h"
//#import "SAWishPoolModel.h"

@interface ATSkipTool : NSObject
-(void)ViewController:(UIViewController * )controller message:(RoomModel *)adModel;
+ (instancetype)sharedInstance;
- (void)loginAction:(UIViewController * )controller;
-(void)QQtemporaryDialogue:(UIViewController * )controller;
-(void)pushToViewControllerWithClassName:(NSString *)className ViewController:(UIViewController * )controller ;
@end
