//
//  UIImage+FMQrcodeBarcode.h
//  MobileProject
//
//  Created by Mingo on 2017/9/1.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (FMQrcodeBarcode)

/*生成二维码(黑白色)*/
+ (UIImage *)getQRWithString:(NSString *)string size:(CGFloat)size;

/*生成二维码(前景色)*/
+ (UIImage *)getQRWithString:(NSString *)string size:(CGFloat)size foreColor:(UIColor *)foreColor;

/*生成二维码(前景色、logo、logo的圆角大小)*/
+ (UIImage *)getQRWithString:(NSString *)string size:(CGFloat)size foreColor:(UIColor *)foreColor logoImage:(UIImage *)logo logoRadius:(CGFloat)radius;

/* 生成线性渐变二维码(渐变颜色数组)*/
+ (UIImage *)getLineGradientQRWithString:(NSString *)string size:(CGFloat)size gradientColor:(NSArray<UIColor *>*)colors;

/* 生成线性渐变二维码(渐变颜色数组、logo、logo的圆角大小)*/
+ (UIImage *)getLineGradientQRWithString:(NSString *)string size:(CGFloat)size gradientColor:(NSArray<UIColor *>*)colors logoImage:(UIImage *)logo logoRadius:(CGFloat)radius;

/* 生成圆形渐变二维码(渐变颜色数组)*/
+ (UIImage *)getRoundGradientQRWithString:(NSString *)string size:(CGFloat)size gradientColor:(NSArray<UIColor *>*)colors;

/* 生成圆形渐变二维码(渐变颜色数组、logo、logo的圆角大小)*/
+ (UIImage *)getRoundGradientQRWithString:(NSString *)string size:(CGFloat)size gradientColor:(NSArray<UIColor *>*)colors logoImage:(UIImage *)logo logoRadius:(CGFloat)radius;

/* 生成条形码*(iOS8.0以上适用)*/
+ (UIImage *)getBarWithString:(NSString *)string size:(CGSize)size;


@end
