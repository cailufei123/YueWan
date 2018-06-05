//
//  SAVourcherModel.m
//  SkinAssistant
//
//  Created by 蔡路飞 on 2017/8/18.
//  Copyright © 2017年 LeGame. All rights reserved.
//

#import "SAVourcherModel.h"

@implementation SAVourcherModel

-(NSString *)createTime{
    
    NSTimeInterval time = [_createTime doubleValue];
    
    NSDate *createDate = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000.0];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    
    
    fmt.dateFormat = @"yyyy-MM-dd HH:mm";
    return [fmt stringFromDate:createDate];
}
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"ID":@"id"};
}
//-(NSString *)use{
//    
//    return @"0";
//}

-(NSString *)startDate{
    if (!_startDate.length) {
        return @"";
    }
    NSTimeInterval time = [_startDate doubleValue];
    
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000.0];
    // 1.创建一个时间格式化对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // 2.格式化对象的样式/z大小写都行/格式必须严格和字符串时间一样
    formatter.dateFormat = @"yyyy.MM.dd";
    
    // 3.字符串转换成时间/自动转换0时区/东加西减
    NSString *timeStr = [formatter stringFromDate:date];
    return timeStr;
    
}
-(NSString *)latestTime{
    if (!_latestTime.length) {
        return @"";
    }
    
    NSTimeInterval time = [_latestTime doubleValue];
    
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000.0];
    // 1.创建一个时间格式化对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // 2.格式化对象的样式/z大小写都行/格式必须严格和字符串时间一样
    formatter.dateFormat = @"yyyy.MM.dd";
    
    // 3.字符串转换成时间/自动转换0时区/东加西减
    NSString *timeStr = [formatter stringFromDate:date];
    
    
    return timeStr;
    
}
-(NSString *)endDate{
   
    
    NSTimeInterval time = [_endDate doubleValue];
    
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000.0];
    // 1.创建一个时间格式化对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // 2.格式化对象的样式/z大小写都行/格式必须严格和字符串时间一样
    formatter.dateFormat = @"yyyy.MM.dd";
    
    // 3.字符串转换成时间/自动转换0时区/东加西减
    NSString *timeStr = [formatter stringFromDate:date];
    
    
    return timeStr;
    
}
@end
@implementation SACouponVourcherModel

@end
