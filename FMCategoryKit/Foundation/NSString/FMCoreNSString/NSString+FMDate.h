//
//  NSString+FMDate.h
//  zms
//
//  Created by Mingo on 17/3/6.
//  Copyright © 2017年 袁凤鸣. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TimeFormat) {
    TimeFormatyyyy_MM_dd_HH_mm_ss,      // yyyy-MM-dd HH:mm:ss
    TimeFormatyyyy_MM_dd_HH_mm,         // yyyy-MM-dd HH:mm
    TimeFormatyyyy_MM_dd,               // yyyy-MM-dd
    TimeFormatMM_dd_HH_mm,              // MM-dd HH:mm
    TimeFormatMM_dd_HH_mm_ss,              // MM-dd HH:mm:ss
    TimeFormatMM_dd,                    // MM-dd
    TimeFormatMMYear_MMMonth_ddDay,     // yyyy年MM月dd日
    TimeFormatMMDot_MMDot_ddDot,        // yyyy.MM.dd
};

@interface NSString (FMDate)
/** 将时间字符串：yyyy-MM-dd HH:mm:ss 格式化成其他时间只字符串 */
- (NSString *)fm_currentDateFormatStringToOtherDateFormatString:(NSString *)currentDateString timeFormat:(TimeFormat)timeFormat;

/** 字符串NSString 转 日期NSDate */
+ (NSDate *)fm_getDateFromString:(NSString *)sender;

/// 日期NSDate 转 字符串NSString 
+ (NSString *)fm_getStringFromDate:(NSDate *)date;

/** 一个时间（2018-11-10）相隔当前时间多少天。 */
+ (NSInteger )fm_differenceValueoATimeToCurrentTime:(NSString *)dateString;
/// 一个时间（yyyy-MM-dd HH:mm:ss）相隔 另外一个时间多少天。
+ (NSInteger )fm_differenceDayBigTime:(NSString *)dateString toSmallTime:(NSDate *)toTime;

/// 根据传入的时间获取格式化后的时间字符串
+ (NSString*)fm_getTimeString:(NSTimeInterval)seconds;

/**
 *  @brief 计算上次日期距离现在多久  &&例如：timeIntervalFromLastTime:@"2015年12月8日 15:50"
 lastTimeFormat:@"yyyy年MM月dd日 HH:mm"
 ToCurrentTime:@"2015/12/08 16:12"
 currentTimeFormat:@"yyyy/MM/dd HH:mm"]);
 *  @param lastTime    上次日期(需要和格式对应)
 *  @param format1     上次日期格式
 *  @param currentTime 最近日期(需要和格式对应)
 *  @param format2     最近日期格式
 *  @return xx分钟前、xx小时前、xx天前 */
+ (NSString *)fm_timeIntervalFromLastTime:(NSString *)lastTime
                            lastTimeFormat:(NSString *)format1
                             ToCurrentTime:(NSString *)currentTime
                         currentTimeFormat:(NSString *)format2;

/** 根据时间戳生成--时间-----秒(北京时间) */
+ (NSString*)fm_switchTimeStampToTimeBySecond:(NSString*) timeStampStr;
/** 根据时间戳生成--时间-----分钟(北京时间) */
+ (NSString*)fm_switchTimeStampToTimeByMin:(NSString*) timeStampStr;

/** 根据时间戳生成--时间-----天(北京时间) */
+ (NSString *)fm_switchTimeStamptoTimeByDay:(NSString *)timeStampStr;

/** 根据时间字符(北京时间)串生成时间戳-------秒 */
+ (NSString*)fm_switchTimeStrToTimeStamp:(NSString*) timeStr;

/** 生成当前时间的时间字符串---------秒 */
+ (NSString*)fm_creatrTimeStrCurrentWithSecond;

/** 生成当前时间的时间字符串---------天 */
+ (NSString*)fm_creatrTimeStrCurrentWithDay;

/** 一个日期和本地时间比较 【返回 1 目标时间大。返回-1 本地时间大  日期格式为2016-08-14 08：46：20 】 */
+ (NSInteger)fm_compareDateWithTheLocalDate:(NSString*)aDate;

/// 返回当前时间与给定时间字符串相差的秒数
+ (NSTimeInterval)fm_productRemainAllTimes:(NSString *)timeStr;

/// 获取当天时间的字符
+ (NSString *)fm_nowTimeDateAllString;

/// 把两个时期相差的秒数
+ (NSTimeInterval)fm_timeDifference:(NSString *)fromDateStr toDateStr:(NSString *)toDateStr;

/// 获取时间戳
+ (NSString *)fm_nowTimeSp;

/// 获取明天的日期
+ (NSString *)fm_getTomorrowDay;

/// 把服务器给的13位时间戳字符串 格式化到分钟
+ (NSString *)fm_switchLongTimeStrToTimeStampByMinutes:(NSString *)timeStamp ;
/// 把服务器给的13位时间戳字符串 格式化到天
+ (NSString *)fm_switchLongTimeStrToTimeStampByDay:(NSString *)timeStamp ;
/// 把服务器给的13位时间戳字符串 格式化到秒
+ (NSString *)fm_switchLongTimeStrToTimeStampBySeconds:(NSString *)timeStamp;
/// 把服务器给的13位时间戳字符串 格式化到NSDate
+ (NSDate *)fm_switchLongTimeStrToNSDateBySeconds:(NSString *)timeStamp;
@end
