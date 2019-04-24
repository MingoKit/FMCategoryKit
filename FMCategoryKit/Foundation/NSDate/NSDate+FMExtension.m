//
//  NSDate+FMExtension.m
//  FupingElectricity
//
//  Created by mingo on 2018/9/9.
//  Copyright © 2018年 mingo. All rights reserved.
//

#import "NSDate+FMExtension.h"
#import "NSDate+Extension.h"
#import "NSDate+JYHandle.h"

@implementation NSDate (FMExtension)
+ (NSDate *)fm_getCustomDateWithHour:(NSInteger)hour
{
    
    //    获取当前时间
    NSDate *currentDate = [NSDate date];
    NSCalendar*currentCalendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *currentComps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    currentComps = [currentCalendar components:unitFlags fromDate:currentDate];
    NSLog(@"-----------weekday is %zd",[currentComps weekday]);//在这里需要注意的是：星期日是数字1，星期一时数字2，以此类推。。。
    
    //    设置当天的某个点
    NSDateComponents * resultComps = [[NSDateComponents alloc]init];
    [resultComps setYear:[currentComps year]];
    [resultComps setMonth:[currentComps month]];
    [resultComps setDay:[currentComps day]];
    [resultComps setHour:hour];
    NSCalendar*resultCalendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    return [resultCalendar dateFromComponents:resultComps];
}



+ (NSTimeInterval )fm_getPreviousCountTimeIntervalToHour:(NSInteger)toHour
{
    NSDate *toDate = [NSDate fm_getCustomDateWithHour:toHour];
    NSDate *currentDate = [NSDate date];
    
    
    //    NSDate *fromDate = [self getCustomDateWithHour:fromHour];
    //
    if ([currentDate compare:toDate] == NSOrderedAscending)
    {
        NSTimeInterval  timeInterval = [toDate timeIntervalSinceDate:currentDate];
        return timeInterval;
        //        NSLog(@"该时间在 %ld:00 之之前！", (long)toHour);
        //        return YES;
    }else{
        return 0;
    }
    //    return NO;
}

//+ (NSDate *)fm_getCustomDateWithTheTimeDayString:(NSString *)hour addDayCount:(NSInteger)dayCount
//{
//    
////    NSDate *nextDay = [NSDate dateWithTimeInterval:24*60*60 sinceDate:date];//后一天
//    //    获取当前时间
//    NSDate *currentDate = [NSDate date];
//    NSCalendar*currentCalendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
//    NSDateComponents *currentComps = [[NSDateComponents alloc] init];
//    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
//    currentComps = [currentCalendar components:unitFlags fromDate:currentDate];
//    NSLog(@"-----------weekday is %zd",[currentComps weekday]);//在这里需要注意的是：星期日是数字1，星期一时数字2，以此类推。。。
//    
//    //    设置当天的某个点
//    NSDateComponents * resultComps = [[NSDateComponents alloc]init];
//    [resultComps setYear:[currentComps year]];
//    [resultComps setMonth:[currentComps month]];
//    [resultComps setDay:[currentComps day]];
//    [resultComps setHour:hour];
//    NSCalendar*resultCalendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
//    return [resultCalendar dateFromComponents:resultComps];
//}

@end
