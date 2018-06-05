//
//  PersonalHomeController.h
//  DailyRanking
//
//  Created by ymy on 15/11/12.
//  Copyright © 2015年 com.xianlaohu.multipeer. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NavHeadTitleViewDelegate <NSObject>
@optional
- (void)NavHeadback;
- (void)NavHeadToRight;
@end

//顶部View
@interface NavHeadTitleView : UIView
@property(nonatomic,assign)id<NavHeadTitleViewDelegate>delegate;
//自定义的导航栏上的View
@property(nonatomic,strong)UIImageView * headBgView;
@property(nonatomic,strong)NSString * title;
//设置label里面的文字
@property(nonatomic,strong)UIColor * color;
//左边的按钮的图片
@property(nonatomic,strong)NSString * backTitleImage;
//右边的按钮的图片
@property(nonatomic,strong)NSString * rightImageView;
@property(nonatomic,strong)NSString * rightTitleImage;
@end
