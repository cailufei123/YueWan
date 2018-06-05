//
//  YWMeTitleItem.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/27.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWMeTitleItem.h"

@implementation YWMeTitleItem
+ (instancetype)itemWithTitle:(NSString *)title subtitle:(NSString *)subtitle mosaicBool:(BOOL)mosaicBool
{
    YWMeTitleItem *item = [[self alloc] init];
    item.title = title;
    item.textHash = mosaicBool;
    return item;
}

@end
