//
//  NSString+FMObjMethods.m
//  MobileProject
//
//  Created by Mingo on 2017/7/9.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "NSString+FMObjMethods.h"

@implementation NSString (FMObjMethods)

#pragma mark 根据字体计算尺寸  需要传递一个固定宽度
- (CGSize)fm_sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW {
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    // 获得系统版本
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

#pragma mark 根据自己自动计算宽高
- (CGSize)fm_sizeWithFont:(UIFont *)font {
    return [self fm_sizeWithFont:font maxW:MAXFLOAT];
}

#pragma mark 动态计算文字最大高度
- (CGFloat)fm_getMaxHeightWithFont:(UIFont *)font fixedMaxWidth:(CGFloat)fixedWidth objString:(NSString *)objStr {

    NSDictionary *attrs = @{NSFontAttributeName : font};
    CGSize maxSize = CGSizeMake(fixedWidth, MAXFLOAT);
    // 计算文字占据的高度
    CGSize size = [objStr boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    return size.height;

}

#pragma mark - 字符串计算，固定宽度和字号大小，返回其所占高度
- (CGFloat)fm_getheightForTextString:(NSString *)textString fixedWidth:(CGFloat)fixedWidth font:(UIFont *)font {
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    
    CGSize detailSize = [textString boundingRectWithSize:CGSizeMake(fixedWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:style} context:nil].size;
    
    return detailSize.height;
}

#pragma mark - 字符串计算 固定高度度和字号大小，返回其所占宽度
- (CGFloat)fm_getWidthForTextString:(NSString *)textString fixedHeight:(CGFloat)fixedHeight font:(UIFont *)font {
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    
    CGSize detailSize = [textString boundingRectWithSize:CGSizeMake(MAXFLOAT, fixedHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:style} context:nil].size;
    
    return detailSize.width;
}

@end
