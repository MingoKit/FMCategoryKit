//
//  NSString+FMNumberFormat.h
//  FupingElectricity
//
//  Created by mingo on 2018/11/9.
//  Copyright © 2018年 Fleeming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FMNumberFormat)
/*!
 @brief 修正浮点型精度丢失
 @param str 传入接口取到的数据
 @return 修正精度后的数据
 */
+ (NSString *)fm_reviseString:(NSString *)str;
- (NSString *)fm_reviseString;
/**
 textField 输入数字时候要求多长，保留多少位小数。超过输入无反应。

 @param textField textField
 @param maxIntegerLength 最大的整数位数
 @param maxFloatLength 保留几位小数
 */
+ (void)fm_textFieldInputFormat:(UITextField *)textField maxIntegerLength:(NSInteger)maxIntegerLength maxFloatLength:(NSInteger)maxFloatLength;

-(NSString *)fm_pointNum2;
-(NSString *)fm_pointNum4;
-(NSString *)fm_pointNum6;
-(NSString *)fm_pointNum8;
-(NSString *)fm_pointNum4NotFillZero;

/// 保留几位小数。不足的是否补全位0
-(NSString *)fm_pointNum:(NSInteger)pointNum fillnum:(BOOL)fillnum;
@end
