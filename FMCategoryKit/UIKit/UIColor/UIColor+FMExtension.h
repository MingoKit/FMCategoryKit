//
//  UIColor+FMExtension.h
//  demo
//
//  Created by Mingo on 16/9/26.
//  Copyright © 2016年 袁凤鸣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (FMExtension)

/**
 渐变方式
 
 - FMGradientChangeDirectionLevel:              水平渐变
 - FMGradientChangeDirectionVertical:           竖直渐变
 - FMGradientChangeDirectionUpwardDiagonalLine: 向下对角线渐变
 - FMGradientChangeDirectionDownDiagonalLine:   向上对角线渐变
 */
typedef NS_ENUM(NSInteger, FMGradientChangeDirection) {
    FMGradientChangeDirectionLevel,
    FMGradientChangeDirectionVertical,
    FMGradientChangeDirectionUpwardDiagonalLine,
    FMGradientChangeDirectionDownDiagonalLine,
};

/**
 创建渐变颜色
 
 @param size       渐变的size
 @param direction  渐变方式
 @param startcolor 开始颜色
 @param endColor   结束颜色
 @return 创建的渐变颜色
 */
+ (instancetype)fm_colorGradientChangeWithSize:(CGSize)size
                                     direction:(FMGradientChangeDirection)direction
                                    startColor:(UIColor *)startcolor
                                      endColor:(UIColor *)endColor;



/**
 返回相片的主要颜色
 
 @param image 图片
 @return 返回的颜色色值
 */
+ (UIColor*)fm_mostColor:(UIImage *)image;


@end
