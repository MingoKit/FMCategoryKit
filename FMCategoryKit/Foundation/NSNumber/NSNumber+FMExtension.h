//
//  NSNumber+FMExtension.h
//  MobileProject
//
//  Created by Mingo on 2017/9/1.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (FMExtension)

/// NSString转换为NSNumber
+ (NSNumber *)fm_numberWithString:(NSString *)string;

/// 判断NSNumber中存的到底是什么基本数据类型【int，float，double，BOOL】
+ (void)fm_valueTypeInNSNumber:(NSNumber *)value;


/** 对应的罗马数字 */
- (NSString *)romanNumeral;

/** 转换为百分比字符串 */
- (NSString*)toDisplayPercentageWithDigit:(NSInteger)digit;

/**
 四舍五入
 
 @param digit 限制最大位数
 @return 四舍五入后的结果
 */
- (NSNumber*)doRoundWithDigit:(NSUInteger)digit;

/**
 上取整
 
 @param digit 限制最大位数
 @return 上取整后的结果
 */
- (NSNumber*)doCeilWithDigit:(NSUInteger)digit;

/**
 下取整
 
 @param digit 限制最大位数
 @return 下取整后的结果
 */
- (NSNumber*)doFloorWithDigit:(NSUInteger)digit;

- (NSString*)toDisplayNumberWithDigit:(NSInteger)digit;


@end
