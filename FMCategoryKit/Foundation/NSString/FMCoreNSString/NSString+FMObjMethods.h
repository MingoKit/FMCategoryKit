//
//  NSString+FMObjMethods.h
//  MobileProject
//
//  Created by Mingo on 2017/7/9.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FMObjMethods)

///** 根据字体计算尺寸  需要传递一个固定宽度 */
//- (CGSize)fm_sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
//
///** 根据自己自动计算宽高 */
//- (CGSize)fm_sizeWithFont:(UIFont *)font;

/** 动态计算文字最大高度  优先使用*/
- (CGFloat)fm_getMaxHeightWithFont:(UIFont *)font fixedMaxWidth:(CGFloat)fixedWidth objString:(NSString *)objStr;

/** 字符串计算，固定宽度和字号大小，返回其所占高度 */
- (CGFloat)fm_getheightForTextString:(NSString *)textString fixedWidth:(CGFloat)fixedWidth font:(UIFont *)font;

/** 字符串计算 固定高度度和字号大小，返回其所占宽度 */
- (CGFloat)fm_getWidthForTextString:(NSString *)textString fixedHeight:(CGFloat)fixedHeight font:(UIFont *)font;

@end
