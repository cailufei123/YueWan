//
//  YWMeTitleItem.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/27.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YWMeTitleItem : NSObject
@property (nonatomic, copy) NSString *title;
/** 子标题 */
@property (nonatomic, strong) NSString *subtitle;
/** 颜色 */
@property (nonatomic, copy) UIColor *textColor;
/** 是否显示文字 */
@property (nonatomic, assign) BOOL textHash;
/** 控制器的名字 */
@property (nonatomic, strong) NSString *controllerName;
/**左边图片的名字 */
@property (nonatomic, strong) NSString *imageName;
/** 上边阴影 */
@property (nonatomic, assign) BOOL topshadow;
/** 中间阴影 */
@property (nonatomic, assign) BOOL middleshadow;
/** 下边阴影 */
@property (nonatomic, assign) BOOL bottomshadow;
/** 第一个 */
@property (nonatomic, assign) BOOL topCell;
/** 第一个 */
@property (nonatomic, assign) BOOL clearCell;
/** 图片 */
@property (nonatomic, strong) NSString *icon;
+ (instancetype)itemWithTitle:(NSString *)title subtitle:(NSString *)subtitle mosaicBool:(BOOL )mosaicBool;
@end
