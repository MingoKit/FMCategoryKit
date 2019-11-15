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
    NSString *doubleString = [NSString stringWithFormat:@"%.8f", conversionValue];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}

- (NSString *)fm_reviseString {
   return  [NSString fm_reviseString:self];
}


+ (void)fm_textFieldInputFormat:(UITextField *)textField maxIntegerLength:(NSInteger)maxIntegerLength maxFloatLength:(NSInteger)maxFloatLength {
    if (!maxIntegerLength) maxIntegerLength = 30 ;
    if (!maxFloatLength) maxFloatLength = 1;
    
    //    static NSInteger const maxIntegerLength=20;//最大整数位
    //    static NSInteger const maxFloatLength=4;//最大精确到小数位
    NSString *x = textField.text;
    if (!x.length) return;

//    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"[ _`~!@#$%^&*×()-+=|{}':;',\\ [\\]<>/?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？]|\n|\r|\tabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"];
//    NSString *newStr = [[x componentsSeparatedByCharactersInSet:set] componentsJoinedByString:@""];
//    NSError *error = nil;
//    NSString *pattern = @"[\u4e00-\u9fa5]";//正则取反
//    NSRegularExpression *regularExpress = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];//这个正则可以去掉所有特殊字符和标点
//    NSString *string = [regularExpress stringByReplacingMatchesInString:newStr options:0 range:NSMakeRange(0, [newStr length]) withTemplate:@""];
//    x = string;
    
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

-(NSString *)fm_pointNum2 {
    NSString *str = [self fm_notRounding:self afterPoint:2 fillnum:YES];
    return str.length ? str : @"0.00";
}
-(NSString *)fm_pointNum4 {
    NSString *str = [self fm_notRounding:self afterPoint:4 fillnum:YES];
    return str.length ? str : @"0.0000";
}

-(NSString *)fm_pointNum6 {
    NSString *str = [self fm_notRounding:self afterPoint:6 fillnum:YES];
    return str.length ? str : @"0.000000";
}
-(NSString *)fm_pointNum8 {
    NSString *str = [self fm_notRounding:self afterPoint:8 fillnum:YES];
    return str.length ? str : @"0.00000000";
}

-(NSString *)fm_pointNum:(NSInteger)pointNum fillnum:(BOOL)fillnum {
    NSString *str = [self fm_notRounding:self afterPoint:pointNum fillnum:fillnum];
    return str;
}


-(NSString *)fm_notRounding:(id)price afterPoint:(NSInteger)position fillnum:(BOOL)fillnum{
    
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    if ([price isKindOfClass:NSNull.class]) {
        price = @"0.00";
    }
    if ([price isKindOfClass:[NSString class]]) {
        NSString *str = [((NSString *)(price)) fm_reviseString];
        ouncesDecimal = [[NSDecimalNumber alloc] initWithString:str];
    }else{
        ouncesDecimal = [[NSDecimalNumber alloc] initWithString:[price stringValue]];
    }
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    if (fillnum) {
        switch (position) {
            case 1:
                return [NSString stringWithFormat:@"%.1f",roundedOunces.doubleValue];
                
                break;
            case 2:
                return [NSString stringWithFormat:@"%.2f",roundedOunces.doubleValue];
                
                break;
            case 3:
                return [NSString stringWithFormat:@"%.3f",roundedOunces.doubleValue];
                
                break;
            case 4:
                return [NSString stringWithFormat:@"%.4f",roundedOunces.doubleValue];
                
                break;
            case 5:
                return [NSString stringWithFormat:@"%.5f",roundedOunces.doubleValue];
                
                break;
            case 6:
                return [NSString stringWithFormat:@"%.6f",roundedOunces.doubleValue];
                
                break;
            case 7:
                return [NSString stringWithFormat:@"%.7f",roundedOunces.doubleValue];
                
                break;
            case 8:
                return [NSString stringWithFormat:@"%.8f",roundedOunces.doubleValue];
                break;
            case 9:
                return [NSString stringWithFormat:@"%.9f",roundedOunces.doubleValue];
                break;
            case 10:
                return [NSString stringWithFormat:@"%.10f",roundedOunces.doubleValue];
                break;
            default:
                return [NSString stringWithFormat:@"%@",roundedOunces];
                break;
        }
    }else{
        return [NSString stringWithFormat:@"%@",roundedOunces];
    }
   
}

@end
