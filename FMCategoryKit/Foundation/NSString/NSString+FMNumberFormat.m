//
//  NSString+FMNumberFormat.m
//  FupingElectricity
//
//  Created by mingo on 2018/11/9.
//  Copyright © 2018年 Fleeming. All rights reserved.
//

#import "NSString+FMNumberFormat.h"

@implementation NSString (FMNumberFormat)

/*!
 @brief 修正浮点型精度丢失
 @param str 传入接口取到的数据
 @return 修正精度后的数据
 */
+ (NSString *)fm_reviseString:(NSString *)str {
    //直接传入精度丢失有问题的Double类型
    double conversionValue = [str doubleValue];
    NSString *doubleString = [NSString stringWithFormat:@"%lf", conversionValue];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}


+ (void)fm_textFieldInputFormat:(UITextField *)textField maxIntegerLength:(NSInteger)maxIntegerLength maxFloatLength:(NSInteger)maxFloatLength {
    if (!maxIntegerLength) maxIntegerLength = 30 ;
    if (!maxFloatLength) maxFloatLength = 1;
    
    //    static NSInteger const maxIntegerLength=20;//最大整数位
    //    static NSInteger const maxFloatLength=4;//最大精确到小数位
    NSString *x = textField.text;
    if (x.length) {
//        if ([x isContainChinese]) {
//            [Tools fm_showHudText:@"含有非法字符！"];
//            return ;
//        }
        //第一个字符处理
        //第一个字符为0,且长度>1时
        if ([[x substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"0"]) {
            if (x.length>1) {
                if ([[x substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"0"]) {
                    //如果第二个字符还是0,即"00",则无效,改为"0"
                    textField.text = @"0";
                }else if (![[x substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"."]){
                    //如果第二个字符不是".",比如"03",清除首位的"0"
                    textField.text = [x substringFromIndex:1];
                }
            }
        }
        //第一个字符为"."时,改为"0."
        else if ([[x substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"."]){
            textField.text = @"0.";
        }
        
        //2个以上字符的处理
        NSRange pointRange = [x rangeOfString:@"."];
        NSRange pointsRange = [x rangeOfString:@".."];
        if (pointsRange.length>0) {
            //含有2个小数点
            textField.text = [x substringToIndex:x.length-1];
        }
        else if (pointRange.length>0){
            //含有1个小数点时,并且已经输入了数字,则不能再次输入小数点
            if ((pointRange.location != x.length-1) && ([[x substringFromIndex:x.length-1]isEqualToString:@"."])) {
                textField.text = [x substringToIndex:x.length-1];
            }
            if (pointRange.location + maxFloatLength < x.length) {
                //输入位数超出精确度限制,进行截取
                textField.text = [x substringToIndex:pointRange.location + maxFloatLength+1];
            }
        }
        else{
            if (x.length > maxIntegerLength) {
                textField.text = [x substringToIndex:maxIntegerLength];
            }
        }
    }
}
@end
