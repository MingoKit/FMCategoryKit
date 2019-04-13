//
//  UIColor+FMExtension.m
//  demo
//
//  Created by Mingo on 16/9/26.
//  Copyright © 2016年 袁凤鸣. All rights reserved.
//

#import "UIColor+FMExtension.h"

@implementation UIColor (FMExtension)

#pragma mark - 渐变颜色(开始颜色，结束颜色，渐变高度)
+ (UIColor *)getJYGradientColorFromColor:(UIColor*)c1 toColor:(UIColor*)c2 withHeight:(int)height{
    CGSize size = CGSizeMake(1, height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    NSArray* colors = [NSArray arrayWithObjects:(id)c1.CGColor, (id)c2.CGColor, nil];
    CGGradientRef gradient = CGGradientCreateWithColors(colorspace, (__bridge CFArrayRef)colors, NULL);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(0, size.height), 0);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    UIGraphicsEndImageContext();
    
    return [UIColor colorWithPatternImage:image];
}
 


@end
