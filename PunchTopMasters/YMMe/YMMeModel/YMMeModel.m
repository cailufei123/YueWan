//
//  YMMeModel.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/12.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YMMeModel.h"

@implementation YMMeModel
// person.m
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"userGradeStats":@"YMUserGameFlowStatM",@"roomModeStats":@"YMUserGameFlowStatM"};
}
@end
@implementation YMUserStatModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"ID":@"id"};
}
@end
@implementation YMUserModel

@end
@implementation YMUserGameFlowStatM

@end


