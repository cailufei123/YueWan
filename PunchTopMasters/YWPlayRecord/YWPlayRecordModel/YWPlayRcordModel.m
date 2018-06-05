//
//  YWPlayRcordModel.m
//  PunchTopMasters
//
//  Created by 蔡路飞 on 2018/5/4.
//  Copyright © 2018年 蔡路飞. All rights reserved.
//

#import "YWPlayRcordModel.h"

@implementation YWPlayRcordModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"ID":@"id"};
}

-(NSString *)createTime{
    
    NSTimeInterval time = [_createTime doubleValue];
    
    NSDate *createDate = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000.0];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    
    
    fmt.dateFormat = @"MM-dd HH:mm";
    return [fmt stringFromDate:createDate];
}
@end
