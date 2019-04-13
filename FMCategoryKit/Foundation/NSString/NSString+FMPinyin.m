//
//  NSString+FMPinyin.m
//  Snowball
//
//  Created by croath on 11/11/13.
//  Copyright (c) 2013 Snowball. All rights reserved.
//

#import "NSString+FMPinyin.h"
#import "NSString+FMExtension.h"

@implementation NSString (FMPinyin)

- (NSString*)pinyinWithPhoneticSymbol {
    NSMutableString *pinyin = [NSMutableString stringWithString:self];
    CFStringTransform((__bridge CFMutableStringRef)(pinyin), NULL, kCFStringTransformMandarinLatin, NO);
    return pinyin;
}

- (NSString*)pinyin {
    NSMutableString *pinyin = [NSMutableString stringWithString:[self pinyinWithPhoneticSymbol]];
    CFStringTransform((__bridge CFMutableStringRef)(pinyin), NULL, kCFStringTransformStripCombiningMarks, NO);
    return pinyin;
}

- (NSArray*)pinyinArray {
    NSArray *array = [[self pinyin] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return array;
}

- (NSString*)pinyinWithoutBlank {
    NSMutableString *string = [NSMutableString stringWithString:@""];
    for (NSString *str in [self pinyinArray]) {
        [string appendString:str];
    }
    return string;
}

- (NSArray*)pinyinInitialsArray {
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *str in [self pinyinArray]) {
        if ([str length] > 0) {
            [array addObject:[str substringToIndex:1]];
        }
    }
    return array;
}

- (NSString*)pinyinInitialsString {
    NSMutableString *pinyin = [NSMutableString stringWithString:@""];
    for (NSString *str in [self pinyinArray]) {
        if ([str length] > 0) {
            [pinyin appendString:[str substringToIndex:1]];
        }
    }
    return pinyin;
}

#pragma mark - 返回一个字符串第一个字母拼音，例如A，不能识别的返回#
- (NSString *)fm_inyinFirstLetter:(NSString *)str {
    
    if (str.length == 0){
        return @"#";
    }
    str = [str substringToIndex:1];
    //转成了可变字符串
    NSMutableString *strC = [NSMutableString stringWithString:str];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)strC,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)strC,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [strC capitalizedString];
    if (pinYin.length == 0) {
        return @"#";
    }
    NSString *captalStr = [pinYin substringToIndex:1];
    char c = [captalStr characterAtIndex:0];
    
    if (!isalpha(c)){
        return @"#";
    }
    return captalStr;
}

#pragma mark - 获取字符串(或汉字)首字母
- (NSString *)fm_firstCharacter{
    NSMutableString *str = [NSMutableString stringWithString:self];
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *pingyin = [str capitalizedString];
    return [pingyin substringToIndex:1];
}


#pragma mark --- 汉字转拼音
- (NSString *)fm_chineseWordSwitchIntoPinyin
{
    //汉字转拼音
    NSMutableString *pinyin = [self mutableCopy];
    //转拼音
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    //去掉音标1234声
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    //转化后的拼音有空格
    //NSString中的stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]方法只是去掉左右两边的空格；
    // stringByReplacingOccurrencesOfString:@" " withString:@""];//可以去掉空格，注意此时生成的strEnd是autorelease属性的
    
    return [NSString fm_removeSpaceInString:pinyin];
}
@end
