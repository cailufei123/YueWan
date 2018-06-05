//
//  YWHomeModel.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/3/28.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWHomeModel.h"

@implementation YWHomeModel
// person.m
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"headAds":@"RoomModel",@"roomTypeList":@"RoomModel"};
}

@end
@implementation RoomModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"ID":@"id"};
}
@end
