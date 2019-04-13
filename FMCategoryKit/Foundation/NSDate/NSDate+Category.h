//
//  NSDate+Category.h
//  ESDS
//
//  Created by Eric on 16/1/12.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Category)

/**
 *  将当前日期按照指定格式转化成字符串
 *
 *  @param format 要转化成字符串的格式
 *
 *  @return 转化后的字符串
 */
-(NSString *)getDateStringWithFormat:(NSString *)format;


/**
 *  将字符串按照指定格式转化成一个日期类型
 *
 *  @param datestring 要被转化的字符串
 *  @param formate    被转化字符串的格式
 *
 *  @return 转化后的日期
 */
+(NSDate *) dateFromFomate:(NSString *)datestring formate:(NSString*)formate;

/**
 *  日期字符串 转化成另一种格式的字符串
 *
 *  @param datestring     即将被转化的日期字符串
 *  @param fromDataFormat 被转化字符串的格式 YYYY-DD-MM
 *  @param toDateFormat   需要转化成的字符串格式 YYYY年MM月DD日
 *
 *  @return 转化后的字符串
 */
+ (NSString *)fomateString:(NSString *)datestring WithFormDataFomate:(NSString *)fromDataFormat WithToFormath:(NSString *)toDateFormat;


/**
 *  获得当前日期的 天
 *
 *  @return 所在天
 */
- (NSInteger)day;



+ (NSString*) stringFromFomate:(NSDate*) date formate:(NSString*)formate;
/**
 *  获得当前日期所在月
 *
 *  @return 月
 */
- (NSInteger)month;


/**
 *  获得当前日期所在日
 *
 *  @return 日
 */
- (NSInteger)year;

- (NSInteger)hour;
- (NSInteger)minute;
-(NSString *)weekDay;


+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;

+(NSDate *)getDateTimeFromMilliSeconds:(long long) miliSeconds;
-(NSString *)convertCustomString;
@end
