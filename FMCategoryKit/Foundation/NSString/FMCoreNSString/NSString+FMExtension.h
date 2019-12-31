//
//  NSString+FMExtension.h
//  demo
//
//  Created by Mingo on 16/9/25.
//  Copyright © 2016年 袁凤鸣. All rights reserved.
//
//p.p1 {margin: 0.0px 0.0px 0.0px 0.0px; font: 14.0px Menlo; color: #ff4647}span.s1 {font-variant-ligatures: no-common-ligatures; color: #eb905a}span.s2 {font-variant-ligatures: no-common-ligatures}


#import <Foundation/Foundation.h>

@interface NSString (FMExtension)

/**  字符串反转——方法1 */
+ (NSString *)fm_reverseWordsInString_Method1:(NSString *)str;

/**  字符串反转——方法2 */
+ (NSString *)fm_reverseWordsInString_Method2:(NSString*)str;

/** 对字符解码进行 URLDecodedString 解码 */
+ (NSString *)fm_decodedString:(NSString *)encodedString;

/** 对手机号码进行*处理 */
+ (NSString *)fm_hiddenMiddleNumOfPhoneNum:(NSString *)mobileString;

/** 对邮箱进行*处理 */
+ (NSString *)fm_hiddenMiddleNumOfEmail:(NSString *)emailString;

/** 对过长字符串进行中间*处理 （string.length > 6 以上才处理） */ 
+ (NSString *)fm_hiddenSomeStrForLongString:(NSString *)string;

/** 去掉字符串中的特殊字符 */ 
+ (NSString *)fm_removeSpecialChar:(NSString *)string;

/** 去掉字符串中间的空格 */ 
+ (NSString *)fm_removeSpaceInString:(NSString *)string;

/** 大数字转换 【11000 -> 1.1万】 */ 
+ (NSString *)fm_switchBigNumIntoUnit:(int)count;

/** 增加html代码标签，适应webview */ 
+ (NSString *)fm_adaptWebViewForHtml:(NSString *) htmlStr;

/** 用某字符串替换其他字符串 */
+ (NSString *)fm_replaceOccurrencesOfString:(NSString *)originalStr withTheString:(NSString *)objStr replaceToString:(NSString *)toStr;

/** 过滤掉表情 换成 【表情】 */
+ (NSString *)fm_disableEmoji:(NSString *)text;

/// 把dictionary转成string
+ (NSString *)fm_dictionaryToJsonString:(NSDictionary *)dic;

/// 把NSMutableArray转成string
+ (NSString *)fm_mutableArrayToJsonString:(NSMutableArray *)arrMut;

/// 格式化银行卡号 4个数就有1个空格
+ (NSString *)fm_changeBankCardNumber:(NSString *)bankCardNumber;

/// 将一个CGFloat数值转化为金额字符串 【如 111,220.29 】
+ (NSString *)fm_moneyStringFromDouble:(CGFloat)doubleValue;

/// 将一个double数值转化为金额字符串（没有小数点部分 eg: 123,122,10）
+ (NSString *)fm_moneyShortIntStringFromDouble:(double)doubleValue;

/// 格式化金额为32,233.0这种格式
+(NSString*)fm_formatMoneyString:(NSString*)str;

/// 根据“,”分割字符串为数组
- (NSMutableArray *)fm_componentsSeparatedByStringSemicolon;
@end
