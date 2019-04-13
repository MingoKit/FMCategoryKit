//
//  NSString+FMPinyin.h
//  Snowball
//
//  Created by croath on 11/11/13.
//  Copyright (c) 2013 Snowball. All rights reserved.
//
// https://github.com/croath/NSString-Pinyin
//  the Chinese Pinyin string of the nsstring

#import <Foundation/Foundation.h>

@interface NSString (FMPinyin)

- (NSString*)pinyinWithPhoneticSymbol;
- (NSString*)pinyin;
- (NSArray*)pinyinArray;
- (NSString*)pinyinWithoutBlank;
- (NSArray*)pinyinInitialsArray;
- (NSString*)pinyinInitialsString;

/// 返回一个字符串第一个字母拼音，例如A，不能识别的返回#
- (NSString *)fm_inyinFirstLetter:(NSString *)str;

/// 获取字符串(或汉字)首字母
- (NSString *)fm_firstCharacter;

/// 汉字转拼音 
- (NSString *)fm_chineseWordSwitchIntoPinyin;

@end
