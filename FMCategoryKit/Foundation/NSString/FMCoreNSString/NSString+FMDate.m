//
//  NSString+FMDate.m
//  zms
//
//  Created by Mingo on 17/3/6.
//  Copyright © 2017年 袁凤鸣. All rights reserved.
//

/*
 *!!!!!!!!!!!!! More brief format perseted below
 G: 公元时代，例如AD公元
 yy: 年的后2位
 yyyy: 完整年
 MM: 月，显示为1-12
 MMM: 月，显示为英文月份简写,如 Jan
 MMMM: 月，显示为英文月份全称，如 Janualy
 dd: 日，2位数表示，如02
 d: 日，1-2位显示，如 2
 EEE: 简写星期几，如Sun
 EEEE: 全写星期几，如Sunday
 aa: 上下午，AM/PM
 H: 时，24小时制，0-23
 K：时，12小时制，0-11
 m: 分，1-2位
 mm: 分，2位
 s: 秒，1-2位
 ss: 秒，2位
 S: 毫秒
 */


#import "NSString+FMDate.h"

@implementation NSString (FMDate)

    
//    NSDate *newdate = [self stringToDate:@"2016-01-18 15:13:12" withDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSString *str = [self dateToString:newdate withDateFormat:@"MM-dd HH:mm"];
//    [_time setText:str];

- (NSString *)fm_currentDateFormatStringToOtherDateFormatString:(NSString *)currentDateString timeFormat:(TimeFormat)timeFormat {

    NSString *objcStr;
    
    NSDate *newdate = [self stringToDate:currentDateString withDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    switch (timeFormat) {
        case TimeFormatyyyy_MM_dd_HH_mm_ss:
            objcStr = [self dateToString:newdate withDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            break;
        case TimeFormatyyyy_MM_dd_HH_mm:
            objcStr = [self dateToString:newdate withDateFormat:@"yyyy-MM-dd HH:mm"];
            break;
        case TimeFormatyyyy_MM_dd:
            objcStr = [self dateToString:newdate withDateFormat:@"yyyy-MM-dd"];
            break;
        case TimeFormatMM_dd_HH_mm:
            objcStr = [self dateToString:newdate withDateFormat:@"MM-dd HH:mm"];
            break;
        case TimeFormatMM_dd_HH_mm_ss:
            objcStr = [self dateToString:newdate withDateFormat:@"MM-dd HH:mm:ss"];
            break;
        case TimeFormatMM_dd:
            objcStr = [self dateToString:newdate withDateFormat:@"MM-dd"];
            break;
        case TimeFormatMMYear_MMMonth_ddDay:
            objcStr = [self dateToString:newdate withDateFormat:@"yyyy年MM月dd日"];
            break;
        case TimeFormatMMDot_MMDot_ddDot:
            objcStr = [self dateToString:newdate withDateFormat:@"yyyy.MM.dd"];
            break;
        default:
            break;
    }
    return objcStr;
}

#pragma mark - 日期格式转字符串
- (NSString *)dateToString:(NSDate *)date withDateFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}


#pragma mark - 字符串转日期格式
- (NSDate *)stringToDate:(NSString *)dateString withDateFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    
    NSDate *date = [dateFormatter dateFromString:dateString];
//    return [self worldTimeToChinaTime:date]; //如果后台给的就是中国时间则不用转换
    
    return date;
    
}

#pragma mark - 将世界时间转化为中国区时间
+ (NSDate *)worldTimeToChinaTime:(NSDate *)date
{
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSInteger interval = [timeZone secondsFromGMTForDate:date];
    NSDate *localeDate = [date  dateByAddingTimeInterval:interval];
    return localeDate;
}

#pragma mark - 字符串NSString 转 日期NSDate
+ (NSDate *)fm_getDateFromString:(NSString *)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MMMM-dd HH:mm:ss";
    [dateFormatter setMonthSymbols:[NSArray arrayWithObjects:@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12", nil]];
    NSDate * ValueDate = [dateFormatter dateFromString:sender];
    return ValueDate;
}

#pragma mark - 日期NSDate 转 字符串NSString
+ (NSString *)fm_getStringFromDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return [dateFormatter stringFromDate:date];
}

#pragma mark - 一个时间（2018-11-10）相隔当前时间多去天。
+ (NSInteger )fm_differenceValueoATimeToCurrentTime:(NSString *)dateString {
    
    //现在的时间
    NSDate * nowDate = [NSDate date];
    nowDate = [NSString worldTimeToChinaTime:nowDate];
    //要转换的字符串
//    NSString * dateString = @"2016-08-30";
    //字符串转NSDate格式的方法
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *ValueDate = [dateFormatter dateFromString:dateString];
//    NSDate *ValueDate = [[NSString new] stringToDate:dateString withDateFormat:TimeFormatyyyy_MM_dd_HH_mm_ss];
    
//    NSDate * ValueDate = [self fm_getDateFromString:dateString];
    //计算两个中间差值(秒)
    NSTimeInterval time = [ValueDate timeIntervalSinceDate:nowDate];
    //开始时间和结束时间的中间相差的时间
    int days;
    days = ((int)time)/(3600*24);  //一天是24小时*3600秒
    NSString * dateValue = [NSString stringWithFormat:@"%i",days];
    
    return [dateValue integerValue];
}

#pragma mark - 一个时间（yyyy-MM-dd HH:mm:ss）相隔 另外一个时间多少天。
+ (NSInteger )fm_differenceDayBigTime:(NSString *)dateString toSmallTime:(NSDate *)toTime {
    
//    nowDate = [NSString worldTimeToChinaTime:nowDate];
    //要转换的字符串
    //    NSString * dateString = @"2016-08-30";
    //字符串转NSDate格式的方法
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *ValueDate = [dateFormatter dateFromString:dateString];
    //    NSDate *ValueDate = [[NSString new] stringToDate:dateString withDateFormat:TimeFormatyyyy_MM_dd_HH_mm_ss];
    
    //    NSDate * ValueDate = [self fm_getDateFromString:dateString];
    //计算两个中间差值(秒)
    NSTimeInterval time = [ValueDate timeIntervalSinceDate:toTime];
    //开始时间和结束时间的中间相差的时间
    int days;
    days = ((int)time)/(3600*24);  //一天是24小时*3600秒
    NSString * dateValue = [NSString stringWithFormat:@"%i",days];
    
    return [dateValue integerValue];
}



#pragma mark - 计算上次日期距离现在多久
/*
 *  @param lastTime    上次日期(需要和格式对应)
 *  @param format1     上次日期格式
 *  @param currentTime 最近日期(需要和格式对应)
 *  @param format2     最近日期格式
 *
 *  @return xx分钟前、xx小时前、xx天前
 */
+ (NSString *)fm_timeIntervalFromLastTime:(NSString *)lastTime
                            lastTimeFormat:(NSString *)format1
                             ToCurrentTime:(NSString *)currentTime
                         currentTimeFormat:(NSString *)format2{
    //上次时间
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc]init];
    dateFormatter1.dateFormat = format1;
    NSDate *lastDate = [dateFormatter1 dateFromString:lastTime];
    //当前时间
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc]init];
    dateFormatter2.dateFormat = format2;
    NSDate *currentDate = [dateFormatter2 dateFromString:currentTime];
    return [NSString fm_timeIntervalFromLastTime:lastDate ToCurrentTime:currentDate];
}

+ (NSString *)fm_timeIntervalFromLastTime:(NSDate *)lastTime ToCurrentTime:(NSDate *)currentTime{
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    //上次时间
    NSDate *lastDate = [lastTime dateByAddingTimeInterval:[timeZone secondsFromGMTForDate:lastTime]];
    //当前时间
    NSDate *currentDate = [currentTime dateByAddingTimeInterval:[timeZone secondsFromGMTForDate:currentTime]];
    //时间间隔
    NSInteger intevalTime = [currentDate timeIntervalSinceReferenceDate] - [lastDate timeIntervalSinceReferenceDate];
    
    //秒、分、小时、天、月、年
    NSInteger minutes = intevalTime / 60;
    NSInteger hours = intevalTime / 60 / 60;
    NSInteger day = intevalTime / 60 / 60 / 24;
    NSInteger month = intevalTime / 60 / 60 / 24 / 30;
    NSInteger yers = intevalTime / 60 / 60 / 24 / 365;
    
    if (minutes <= 10) {
        return  @"刚刚";
    }else if (minutes < 60){
        return [NSString stringWithFormat: @"%ld分钟前",(long)minutes];
    }else if (hours < 24){
        return [NSString stringWithFormat: @"%ld小时前",(long)hours];
    }else if (day < 30){
        return [NSString stringWithFormat: @"%ld天前",(long)day];
    }else if (month < 12){
        NSDateFormatter * df =[[NSDateFormatter alloc]init];
        df.dateFormat = @"M月d日";
        NSString * time = [df stringFromDate:lastDate];
        return time;
    }else if (yers >= 1){
        NSDateFormatter * df =[[NSDateFormatter alloc]init];
        df.dateFormat = @"yyyy年M月d日";
        NSString * time = [df stringFromDate:lastDate];
        return time;
    }
    return @"";
}

#pragma mark - === 时间格式化处理 ===
#pragma mark --- 根据时间戳生成--时间-----秒(北京时间)
+ (NSString*)fm_switchTimeStampToTimeBySecond:(NSString*) timeStampStr
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timeStampStr floatValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

+ (NSString*)fm_switchTimeStampToTimeByMin:(NSString*) timeStampStr
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timeStampStr floatValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}


#pragma mark ---根据时间戳生成--时间-----天(北京时间)
+ (NSString *)fm_switchTimeStamptoTimeByDay:(NSString *)timeStampStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timeStampStr floatValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

#pragma mark ---根据时间字符(北京时间)串生成时间戳-------秒
+ (NSString*)fm_switchTimeStrToTimeStamp:(NSString*) timeStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSDate *date = [formatter dateFromString:timeStr]; //------------将字符串按formatter转成nsdate
    //----------将nsdate按formatter格式转成nsstring
    //时间转时间戳的方法:
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    NSLog(@"timeSp:%@",timeSp); //时间戳的值
    return timeSp;
}

#pragma mark ---生成当前时间的时间字符串---------秒
+ (NSString*)fm_creatrTimeStrCurrentWithSecond
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *dateCurrent = [NSDate date];
    NSString *dateStr = [formatter stringFromDate:dateCurrent];
    NSLog(@"timeSp:%@",dateStr);
    return dateStr;
}
#pragma mark ---生成当前时间的时间字符串---------天
+ (NSString*)fm_creatrTimeStrCurrentWithDay
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *dateCurrent = [NSDate date];
    NSString *dateStr = [formatter stringFromDate:dateCurrent];
    NSLog(@"timeSp:%@",dateStr);
    return dateStr;
    
}


#pragma mark - 一个日期和本地时间比较 【返回 1 目标时间大。返回-1 本地时间大  日期格式为2016-08-14 08：46：20 】
+ (NSInteger)fm_compareDateWithTheLocalDate:(NSString*)aDate {
    
    //1. 获取当前系统的准确事件(+8小时)
    NSDate *date = [NSDate date]; // 获得时间对象
    NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得系统的时区
    NSTimeInterval time = [zone secondsFromGMTForDate:date];// 以秒为单位返回当前时间与系统格林尼治时间的差
    NSDate *dateNow = [date dateByAddingTimeInterval:time];// 然后把差的时间加上,就是当前系统准确的时间
    
    //    //2. 获取当前系统事件并设置格式
    //    NSDate *date = [NSDate date]; // 获得时间对象
    //    NSDateFormatter *forMatter = [[NSDateFormatter alloc] init];
    //    [forMatter setDateFormat:@"HH-mm-ss yyyy-MM-dd"];
    //    NSString *dateStr = [forMatter stringFromDate:date];
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateTime=[formatter stringFromDate:dateNow];
    NSDate *dateLocal = [formatter dateFromString:dateTime];
    
    NSInteger aa = 0;
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateObj = [[NSDate alloc] init];
    
    dateObj = [dateformater dateFromString:aDate];
    NSComparisonResult result = [dateLocal compare:dateObj];
    
    if (result == NSOrderedSame) {
        aa = 0; // 相等
    }else if (result == NSOrderedAscending) {
        aa = 1;   //dateLocal获取的时间 比 本地时间dateLocal  大
    }else if (result == NSOrderedDescending) {
        aa = -1;  //dateLocal获取的时间 比 本地时间dateLocal 小
    }
    return aa;
}

#pragma mark - 返回当前时间与给定时间字符串相差的秒数
+ (NSTimeInterval)fm_productRemainAllTimes:(NSString *)timeStr{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //设定时间格式,这里可以设置成自己需要的格式
//    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    NSTimeInterval time = [NSString fm_timeDifference:timeStr toDateStr:currentDateStr];
    
    return time;
    
}

#pragma mark - 获取当天时间的字符
+ (NSString *)fm_nowTimeDateAllString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    return currentDateStr;
    
}

#pragma mark - 把两个时期相差的秒数
+ (NSTimeInterval)fm_timeDifference:(NSString *)fromDateStr toDateStr:(NSString *)toDateStr {
    
    NSDate *fromDate = [NSString fm_getDateFromString:fromDateStr];
    NSDate *toDate = [NSString fm_getDateFromString:toDateStr];
    
    NSTimeInterval  timeInterval = [fromDate timeIntervalSinceDate:toDate];
    return timeInterval;
}

#pragma mark - 获取时间戳
+ (NSString *)fm_nowTimeSp{
    NSDate *localDate = [NSDate date]; //获取当前时间
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[localDate timeIntervalSince1970]];
    return timeSp;
}

#pragma mark - 获取明天的日期
+ (NSString *)fm_getTomorrowDay{
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:[NSDate date]];
    [components setDay:([components day]+1)];
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"yyyy-MM-dd"];
    return [dateday stringFromDate:beginningOfWeek];
}

+ (NSString*)fm_getTimeString:(NSTimeInterval)seconds{
    
    NSInteger day = seconds/86400;
    NSInteger hour = (seconds-(day*86400))/3600;
    NSInteger minus = (seconds-(day*86400)-(hour*3600))/60;
    NSInteger second = (seconds-(day*86400)-(hour*3600)-minus*60);
    
    if (day) {
        return [NSString stringWithFormat:@"%0.3zd :%0.2zd : %0.2zd : %0.2zd", day,hour,minus,second];
    }else {
        if (hour) {
            return [NSString stringWithFormat:@"%0.2zd : %0.2zd : %0.2zd", hour,minus,second];
        }else {
            if (minus) {
                return [NSString stringWithFormat:@"%0.2zd : %0.2zd",minus,second];
            }else{
                return [NSString stringWithFormat:@"%0.2zd秒",second];
            }
        }
    }
    
    return [NSString stringWithFormat:@"%0.3zd :%0.2zd : %0.2zd : %0.2zd", day,hour,minus,second];
}

/// 把服务器给的13位时间戳字符串 格式化到分钟
+ (NSString *)fm_switchLongTimeStrToTimeStampByMinutes:(NSString *)timeStamp {
    // timeStampString 是服务器返回的13位时间戳
//    NSString *timeStampString  = @"1495453213000";
    
    if ([timeStamp containsString:@"-"] && [timeStamp containsString:@":"] && [timeStamp containsString:@" "]) {
        NSString *time = [timeStamp fm_currentDateFormatStringToOtherDateFormatString:timeStamp timeFormat:TimeFormatyyyy_MM_dd_HH_mm];
        return time;
    }
    if ([timeStamp containsString:@"T"] && [timeStamp containsString:@".000+0000"]) {
        NSString *strt = [timeStamp stringByReplacingOccurrencesOfString:@"T" withString:@" "];
        strt = [strt stringByReplacingOccurrencesOfString:@".000+0000" withString:@""];
        NSString *time = [timeStamp fm_currentDateFormatStringToOtherDateFormatString:strt timeFormat:TimeFormatyyyy_MM_dd_HH_mm];
        return time;
    }
    // iOS 生成的时间戳是10位
    NSTimeInterval interval    =[timeStamp doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString       = [formatter stringFromDate: date];
//    NSLog(@"服务器返回的时间戳对应的时间是:%@",dateString);
    return dateString;
}

/// 把服务器给的13位时间戳字符串 格式化到天
+ (NSString *)fm_switchLongTimeStrToTimeStampByDay:(NSString *)timeStamp {
    
    if ([timeStamp containsString:@"-"] && [timeStamp containsString:@":"] && [timeStamp containsString:@" "]) {
        NSString *time = [timeStamp fm_currentDateFormatStringToOtherDateFormatString:timeStamp timeFormat:TimeFormatyyyy_MM_dd];
        return time;
    }
    
    if ([timeStamp containsString:@"T"] && [timeStamp containsString:@".000+0000"]) {
        NSString *strt = [timeStamp stringByReplacingOccurrencesOfString:@"T" withString:@" "];
        strt = [strt stringByReplacingOccurrencesOfString:@".000+0000" withString:@""];
        NSString *time = [timeStamp fm_currentDateFormatStringToOtherDateFormatString:strt timeFormat:TimeFormatyyyy_MM_dd];
        return time;
    }
    
    // timeStampString 是服务器返回的13位时间戳
    //    NSString *timeStampString  = @"1495453213000";
    
    // iOS 生成的时间戳是10位
    NSTimeInterval interval    =[timeStamp doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString       = [formatter stringFromDate: date];
    //    NSLog(@"服务器返回的时间戳对应的时间是:%@",dateString);
    return dateString;
}

/// 把服务器给的13位时间戳字符串 格式化到秒
+ (NSString *)fm_switchLongTimeStrToTimeStampBySeconds:(NSString *)timeStamp {
    // timeStampString 是服务器返回的13位时间戳
    //    NSString *timeStampString  = @"1495453213000";
    
    if ([timeStamp containsString:@"-"] && [timeStamp containsString:@":"] && [timeStamp containsString:@" "]) {
        NSString *time = [timeStamp fm_currentDateFormatStringToOtherDateFormatString:timeStamp timeFormat:TimeFormatyyyy_MM_dd_HH_mm_ss];
        return time;
    }
    
    if ([timeStamp containsString:@"T"] && [timeStamp containsString:@".000+0000"]) {
        NSString *strt = [timeStamp stringByReplacingOccurrencesOfString:@"T" withString:@" "];
        strt = [strt stringByReplacingOccurrencesOfString:@".000+0000" withString:@""];
        NSString *time = [timeStamp fm_currentDateFormatStringToOtherDateFormatString:strt timeFormat:TimeFormatyyyy_MM_dd_HH_mm_ss];
        return time;
    }
    
    // iOS 生成的时间戳是10位
    NSTimeInterval interval    =[timeStamp doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString       = [formatter stringFromDate: date];
    //    NSLog(@"服务器返回的时间戳对应的时间是:%@",dateString);
    return dateString;
}

/// 把服务器给的13位时间戳字符串 格式化到NSDate
+ (NSDate *)fm_switchLongTimeStrToNSDateBySeconds:(NSString *)timeStamp {
    // timeStampString 是服务器返回的13位时间戳
    //    NSString *timeStampString  = @"1495453213000";
//                                       1540177701000
//    if ([timeStamp containsString:@"-"] && [timeStamp containsString:@":"] && [timeStamp containsString:@" "]) {
//        NSString *time = [timeStamp fm_currentDateFormatStringToOtherDateFormatString:timeStamp timeFormat:TimeFormatyyyy_MM_dd_HH_mm_ss];
//        return time;
//    }
    // iOS 生成的时间戳是10位
    NSTimeInterval interval    =[timeStamp doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    return date;
}

@end
