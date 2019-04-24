//
//  UIColor+FMExtension.h
//  demo
//
//  Created by Mingo on 16/9/26.
//  Copyright © 2016年 袁凤鸣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (FMExtension)

/// 渐变颜色(开始颜色，结束颜色，渐变高度)
+ (UIColor *)fm_gradientColorFromColor:(UIColor*)c1 toColor:(UIColor*)c2 withHeight:(int)height;


/**
 返回相片的主要颜色
 
 @param image 图片
 @return 返回的颜色色值
 */
+ (UIColor*)fm_mostColor:(UIImage *)image;

@end
