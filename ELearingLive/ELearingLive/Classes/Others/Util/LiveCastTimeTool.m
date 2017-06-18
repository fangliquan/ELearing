//
//  LiveCastTimeTool.h
//
//
//  Created by leo on 16/6/23.
//  Copyright © 2016年 AlexiChen. All rights reserved.
//

#import "LiveCastTimeTool.h"


@implementation LiveCastTimeTool


+(NSArray *)daysFromNowToSevenDay{
    NSMutableArray *dayArray = [NSMutableArray array];
    for (int i = 0; i <= 7; i++) {
        NSTimeInterval  iDay = 24*60*60*i;  //1天的长度
        NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:iDay];
        [dayArray addObject:[self summaryTimeUsingDate1:date]];
    }
    return dayArray;
}

+(NSArray *)daysStrFromNowToSevenDay{
    NSMutableArray *dayArray = [NSMutableArray array];
    for (int i = 0; i <= 7; i++) {
        NSTimeInterval  iDay = 24*60*60*i;  //1天的长度
        NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:iDay];
        NSString *dateStr = [self monthAndDayTimeUsingDate:date];
        NSString *weekdayStr = [self weakDayTimeUsingDate:date];
        
        NSString *dayStr = i == 0?@"今天" : [NSString stringWithFormat:@"%@  %@",dateStr,weekdayStr];
        [dayArray addObject:dayStr];
    }
    return dayArray;
}

+(NSInteger)currentDateHour{

    return [self dateComponents].hour;
}

+(NSInteger)currentDateMinute{
 
    return [self dateComponents].minute;
}

+(NSDateComponents *)dateComponents{
    NSDate *currentDate = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:currentDate];
    return dateComponent;
}

+(NSString *)monthAndDayTimeUsingDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM月dd日"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

+(NSString *)weakDayTimeUsingDate:(NSDate *)date
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *dComponents = [cal components:NSCalendarUnitWeekday fromDate:date];
    NSString *weekday = @"";
    switch (dComponents.weekday) {
        case 2:
            weekday = @"星期一";
            break;
        case 3:
            weekday = @"星期二";
            break;
        case 4:
            weekday = @"星期三";
            break;
        case 5:
            weekday = @"星期四";
            break;
        case 6:
            weekday = @"星期五";
            break;
        case 7:
            weekday = @"星期六";
            break;
        case 1:
            weekday = @"星期日";
            break;
            
        default:
            break;
    }

    return weekday;
}

+(NSString *)summaryTimeUsingDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

+(NSString *)summaryTimeUsingDate1:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

+(NSString *)displayedSummaryTimeUsingString:(NSString *)string
{
    
    NSMutableString *result = [[NSMutableString alloc] initWithString:[string substringWithRange:NSMakeRange(0, 4)]];
    [result appendString:@"-"];
    [result appendString:[string substringWithRange:NSMakeRange(4, 2)]];
    [result appendString:@"-"];
    [result appendString:[string substringWithRange:NSMakeRange(6, 2)]];
    return result;
}

@end
