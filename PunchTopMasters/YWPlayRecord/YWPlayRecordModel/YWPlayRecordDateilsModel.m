//
//  YWPlayRecordDateilsModel.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/5/7.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWPlayRecordDateilsModel.h"

@implementation YWPlayRecordDateilsModel
// person.m
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"vos":@"YWPvosModel"};
}
@end
@implementation YWRecordInfoModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"ID":@"id"};
}
@end
@implementation YWPvosModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"ID":@"id"};
}
@end
@implementation YWuserGameFLowModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"ID":@"id"};
}
@end
@implementation YWOrderModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"ID":@"id"};
}
-(NSString *)createTime{
    
    NSTimeInterval time = [_createTime doubleValue];
    
    NSDate *createDate = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000.0];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    
    
    fmt.dateFormat = @"yyyy-MM-dd HH:mm";
    return [fmt stringFromDate:createDate];
}
@end

@implementation YWOrderCouponInfoModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"ID":@"id"};
}
@end
