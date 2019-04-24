//
//  NSDate+FMExtension.h
//  FupingElectricity
//
//  Created by mingo on 2018/9/9.
//  Copyright © 2018年 mingo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (FMExtension)
/// 输入一个数字小时，返回该时刻 的 太平洋时间
+ (NSDate *)fm_getCustomDateWithHour:(NSInteger)hour;
/// 获取当前时刻 到指定时间之间的相隔的秒数
+ (NSTimeInterval )fm_getPreviousCountTimeIntervalToHour:(NSInteger)toHour;
@end
