//
//  YWMeItemGroups.h
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/27.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YWMeItemGroups : NSObject
/** 组头 */
@property (nonatomic, copy) NSString *header;
/** 组尾 */
@property (nonatomic, copy) NSString *footer;
/** 这组的所有行模型(数组中存放的都是HMCommonItem模型) */
@property (nonatomic, strong) NSMutableArray *items;

/** 这组的所有行模型(数组中存放的都是HMCommonItem模型) */
@property (nonatomic, strong) NSArray *groupItems;
@property (nonatomic, assign) BOOL heard;
@property (nonatomic, assign) BOOL firstHeard;
+ (instancetype)group;
@end
