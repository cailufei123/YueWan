//
//  YWRoomModel.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/4/10.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWRoomModel.h"

@implementation YWRoomModel
// person.m
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"gameQueue":@"YWGameQueueModel",@"roomPerson":@"YWRoomPersonModel"};
}
@end


@implementation YWGameQueueModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"ID":@"id"};
}
@end


@implementation YWRoomPersonModel

@end


@implementation YWRoomInfoModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
 
     return @{@"ID":@"id",@"currentQueueNum":@"currentQueueCount",@"requireQueueNum":@"requireQueueCount"};
}
@end
@implementation YWMyRoomModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"ID":@"id"};
}
@end


