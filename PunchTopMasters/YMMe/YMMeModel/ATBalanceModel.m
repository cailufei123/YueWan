//
//  ATBalanceModel.m
//  Auction
//
//  Created by 蔡路飞 on 2017/11/1.
//  Copyright © 2017年 Cailufei. All rights reserved.
//

#import "ATBalanceModel.h"

@implementation ATBalanceModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"ID" : @"id",
             };
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

@implementation BalanceModel

@end

