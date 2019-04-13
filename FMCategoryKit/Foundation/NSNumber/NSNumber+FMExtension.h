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

@end
