//
//  YWSetModel.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/20.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWSetModel.h"

@implementation YWSetModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"botInfos":@"BotInfoModel"};
}
@end

@implementation BotInfoModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"ID":@"id"};
}
@end
