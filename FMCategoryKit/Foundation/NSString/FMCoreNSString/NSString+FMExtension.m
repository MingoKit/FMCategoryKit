//
//  NSString+FMExtension.m
//  demo
//
//  Created by Mingo on 16/9/25.
//  Copyright © 2016年 袁凤鸣. All rights reserved.
//

#import "NSString+FMExtension.h"

@implementation NSString (FMExtension)


#pragma mark - 字符串反转——方法1
+ (NSString *)fm_reverseWordsInString_Method1:(NSString *)str
{
    NSMutableString *newString = [[NSMutableString alloc] initWithCapacity:str.length];
    for (NSInteger i = str.length - 1; i >= 0 ; i --)
    {
        unichar ch = [str characterAtIndex:i];
        [newString appendFormat:@"%c", ch];
    }
    return newString;
}

#pragma mark - 字符串反转——方法2
+ (NSString*)fm_reverseWordsInString_Method2:(NSString *)str
{
    NSMutableString *reverString = [NSMutableString stringWithCapacity:str.length];
    [str enumerateSubstringsInRange:NSMakeRange(0, str.length) options:NSStringEnumerationReverse | NSStringEnumerationByComposedCharacterSequences  usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        [reverString appendString:substring];
    }];
    return reverString;
}

#pragma mark - 对字符解码进行 URLDecodedString 解码
+ (NSString *)fm_decodedString:(NSString *)encodedString {
    //NSString *decodedString = [encodedString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)encodedString, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}

#pragma mark - 对手机号码进行*处理
+ (NSString *)fm_hiddenMiddleNumOfPhoneNum:(NSString *)mobileString{
    
    if (mobileString.length > 10) {
        
        return [mobileString stringByReplacingCharactersInRange:NSMakeRange(3,mobileString.length - 7) withString:@"****"];
    }
    return mobileString;
}

#pragma mark - 对邮箱进行*处理
+ (NSString *)fm_hiddenMiddleNumOfEmail:(NSString *)emailString{
    
    NSArray *emailStrArr = [emailString componentsSeparatedByString:@"@"];
    NSString *emailFirstObj = [emailStrArr firstObject];
    if (emailFirstObj.length >= 6) {
        
        return [emailString stringByReplacingCharactersInRange:NSMakeRange((emailFirstObj.length % 2) ? (emailFirstObj.length / 2 - 1 ): (emailFirstObj.length /2 - 2)  ,(emailFirstObj.length % 2) ? 3 : 4) withString:@"****"];
    }
    
    
    return emailString;
}

#pragma mark - 对过长字符串进行中间*处理 （string.length > 6 以上才处理）
+ (NSString *)fm_hiddenSomeStrForLongString:(NSString *)string{
    
    if (string.length > 6) {
        return [string stringByReplacingCharactersInRange:NSMakeRange(string.length/4,string.length/2) withString:@"**"];
    }
    return string;
}

#pragma mark - 去掉字符串中的特殊字符
+ (NSString *)fm_removeSpecialChar:(NSString *)string
{
    //这里随意添加想要过滤的字符,加多少都可以
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"、＇：∶；?‘’“”〝〞ˆˇ﹕︰﹔﹖﹑¨….¸;！´？！～—ˉ｜‖＂〃｀@﹫¡¿﹏﹋﹌︴﹟#﹩$﹠&﹪%*﹡﹢﹦﹤‐￣¯―﹨ˆ˜﹍﹎+=<＿_-~﹉﹊（）!^()〈〉‹›﹛﹜『』〖〗［］《》〔〕{}「」【】"];
    //
    NSString *trimmedString =  [[string componentsSeparatedByCharactersInSet:set]componentsJoinedByString:@""];
    return trimmedString;
}

#pragma mark --- 去掉字符串中间的空格
+ (NSString *)fm_removeSpaceInString:(NSString *)string
{
    //可以去掉空格，注意此时生成的strEnd是autorelease属性的
    return  [string stringByReplacingOccurrencesOfString:@" " withString:@""];
}

#pragma mark 大数字转换 【11000 -> 1.1万】
+ (NSString *)fm_switchBigNumIntoUnit:(int)count
{
    NSString *title = @"";
    if (count >= 10000)
    { // 上万
        CGFloat final = count / 10000.0;
        title = [NSString stringWithFormat:@"%.1f万",final];
        title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }else if (count >= 0)
    {
        title = [NSString stringWithFormat:@"%d",count];
    }
    return title;
}

#pragma mark - === 网页 ===
#pragma mark  增加html代码标签，适应webview
+ (NSString *)fm_adaptWebViewForHtml:(NSString *) htmlStr
{
    NSMutableString *headHtml = [[NSMutableString alloc] initWithCapacity:0];
    [headHtml appendString : @"<html>" ];
    
    [headHtml appendString : @"<head>" ];
    
    [headHtml appendString : @"<meta charset=\"utf-8\">" ];
    
    [headHtml appendString : @"<meta id=\"viewport\" name=\"viewport\" content=\"width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=false\" />" ];
    
    [headHtml appendString : @"<meta name=\"apple-mobile-web-app-capable\" content=\"yes\" />" ];
    
    [headHtml appendString : @"<meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\" />" ];
    
    [headHtml appendString : @"<meta name=\"black\" name=\"apple-mobile-web-app-status-bar-style\" />" ];
    
    [headHtml appendString : @"<style>img{width:100%;}</style>" ];
    
    [headHtml appendString : @"<style>table{width:100%;}</style>" ];
    
    //[headHtml appendString : @"<title>webview</title>" ];
    
    NSString *bodyHtml;
    bodyHtml = [NSString stringWithString:headHtml];
    bodyHtml = [bodyHtml stringByAppendingString:htmlStr];
    return bodyHtml;
    
}

+ (NSString *)fm_replaceOccurrencesOfString:(NSString *)originalStr withTheString:(NSString *)objStr replaceToString:(NSString *)toStr{
    
    if (originalStr.length != 0) {
        NSMutableString *outputStr = [NSMutableString stringWithString:originalStr];
        [outputStr replaceOccurrencesOfString:objStr withString:toStr options:NSLiteralSearch range:NSMakeRange(0, [outputStr length])];
        return [outputStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    } else {
        return nil;
    }
}

#pragma mark - 过滤掉表情 换成 【表情】
+ (NSString *)fm_disableEmoji:(NSString *)text {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@"【表情】"];
    return modifiedString;
}

#pragma mark - 把dictionary转成string
+ (NSString *)fm_dictionaryToJsonString:(NSDictionary *)dic{
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *string =  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return string;
}

#pragma mark - 把NSMutableArray转成string
+ (NSString *)fm_mutableArrayToJsonString:(NSMutableArray *)arrMut{
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arrMut options:NSJSONWritingPrettyPrinted error:&error];//此处dataArr参数的key为"data"的数组
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

#pragma mark - 格式化银行卡号 4个数就有1个空格
+ (NSString *)fm_changeBankCardNumber:(NSString *)bankCardNumber{
    if (bankCardNumber.length <= 4) {
        return bankCardNumber;
    }
    NSString *space = @" ";
    bankCardNumber = [bankCardNumber stringByReplacingOccurrencesOfString:space withString:@""];
    if (bankCardNumber.length>19) {
        bankCardNumber=[bankCardNumber substringToIndex:19];
    }
    NSMutableString *mutableString = [NSMutableString stringWithString:bankCardNumber];
    NSInteger numSpace = (mutableString.length - 1)/4;
    for (NSInteger i = 0; i < numSpace; i++) {
        [mutableString insertString:space atIndex:(i+1)*4 + i];
    }
    NSString *resultStr = [mutableString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return resultStr;
}

#pragma mark - 将一个CGFloat数值转化为金额字符串 【两位小数。如 111,220.29 】
+ (NSString *)fm_moneyStringFromDouble:(CGFloat)doubleValue{
    
    NSString *strNum = [NSString stringWithFormat:@"%.2f",doubleValue];
    NSMutableString *mutableString = [NSMutableString stringWithString:strNum];
    NSInteger startCommaIndex = [strNum rangeOfString:@"."].location;
    NSInteger numComma = (startCommaIndex - ((doubleValue >= 0)?1:2))/3;
    
    for (NSInteger i = 0; i < numComma; i++) {
        [mutableString insertString:@"," atIndex:startCommaIndex - (i+1)*3];
    }
    return mutableString;
}
#pragma mark - 将一个double数值转化为金额字符串（没有小数点部分 eg: 123,122,10）
+ (NSString *)fm_moneyShortIntStringFromDouble:(double)doubleValue{
    
    //[NSString stringWithFormat:@"%.0f",floatNum];
    NSString *strNum = [NSString stringWithFormat:@"%li",(long)doubleValue];
    NSMutableString *mutableString = [NSMutableString stringWithString:strNum];
    NSInteger startCommaIndex = mutableString.length;
    NSInteger numComma = (startCommaIndex - ((doubleValue >= 0)?1:2))/3;
    for (NSInteger i = 0; i < numComma; i++) {
        [mutableString insertString:@"," atIndex:startCommaIndex - (i+1)*3];
    }
    return mutableString;
}

+ (NSString *)fm_formatMoneyString:(NSString *)str
{
    @try
    {
        if (str.length < 3)
        {
            return str;
        }
        NSString *numStr = str;
        NSArray *array = [numStr componentsSeparatedByString:@"."];
        NSString *numInt = [array objectAtIndex:0];
        if (numInt.length <= 3)
        {
            return str;
        }
        NSString *suffixStr = @"";
        if ([array count] > 1)
        {
            suffixStr = [NSString stringWithFormat:@".%@",[array objectAtIndex:1]];
        }
        
        NSMutableArray *numArr = [[NSMutableArray alloc] init];
        while (numInt.length > 3)
        {
            NSString *temp = [numInt substringFromIndex:numInt.length - 3];
            numInt = [numInt substringToIndex:numInt.length - 3];
            [numArr addObject:[NSString stringWithFormat:@",%@",temp]];//得到的倒序的数据
        }
        NSInteger count = [numArr count];
        for (int i = 0; i < count; i++)
        {
            numInt = [numInt stringByAppendingFormat:@"%@",[numArr objectAtIndex:(count -1 -i)]];
        }
        numStr = [NSString stringWithFormat:@"%@%@",numInt,suffixStr];
        return numStr;
    }
    @catch (NSException *exception)
    {
        return str;
    }
    @finally
    {}
}

- (NSMutableArray *)fm_componentsSeparatedByStringSemicolon {
    if (!self.length) return @[].mutableCopy;
    NSString *str = self.copy;
    if ([[str substringFromIndex:str.length - 1] isEqualToString:@","]) {
        str = [str substringToIndex:str.length - 1];
    }
    
    NSMutableArray *arrend = NSMutableArray.array;
    NSMutableArray *arrtem  = [str componentsSeparatedByString:@","].mutableCopy;
    
    if (arrtem.count) {
        for (NSString *str in arrtem) {
            NSString *showStr = str;
            if ([str fm_isContainChinese] && [str containsString:@"http"]) {
                showStr = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            }
            [arrend addObject:showStr];
        }
    }else{
        if ([str fm_isContainChinese] && [str containsString:@"http"]) {
            str = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        }
        [arrend addObject:str];
    }
    return arrend;
}

- (BOOL)fm_isContainChinese {
    NSUInteger length = [self length];
    for (NSUInteger i = 0; i < length; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [self substringWithRange:range];
        const char *cString = [subString UTF8String];
        if (strlen(cString) == 3) {
            return YES;
        }
    }
    return NO;
}

@end
