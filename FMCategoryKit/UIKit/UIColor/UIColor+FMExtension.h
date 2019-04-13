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

@end
