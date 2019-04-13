//
//  UIButton+FMExtension.h
//  MobileProject
//
//  Created by Mingo on 2017/7/20.
//  Copyright © 2017年 袁凤鸣. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CallBackBlock)(UIButton * button);

@interface UIButton (FMExtension)
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

/** 快速创建button，highlighted相关设置在对象方法： fm_highlightedTitleColor */
+ (UIButton *)fm_initButtonNormalTitleColor:(UIColor *)normalColor  backgroundColor:(UIColor *)BGColor font:(CGFloat)font normalImage:(UIImage *)normalImage cornerRadius:(CGFloat)cornerRadius  addToSuperView:(UIView *)superView addTarget:(id)controller action:(SEL)sel normalTitle:(NSString *)normalTitle;

/** 快速创建button，不包含点击事件。highlighted相关设置在对象方法： fm_highlightedTitleColor */
+ (UIButton *)fm_initButtonNormalTitleColor:(UIColor *)normalColor  backgroundColor:(UIColor *)BGColor font:(CGFloat)font normalImage:(UIImage *)normalImage cornerRadius:(CGFloat)cornerRadius addToSuperView:(UIView *)superView normalTitle:(NSString *)normalTitle;

/// 创建button，正常图片和高亮图片
+ (UIButton *)fm_createButtonFrame:(CGRect)frame normalImageName:(NSString *)normalImageName highlightedImageName:(NSString *)highlightedImageName;

/// 创建button，文字，字体，正常字体颜色，高亮字体颜色
+ (UIButton *)fm_createButtonFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font normalTitleColor:(UIColor *)normalTitleColor highlightedTitleColor:(UIColor *)highlightedTitleColor;

/// 创建button，正常图片和高亮图片，title文字，字体，正常字体颜色，高亮字体颜色
+ (UIButton *)fm_createButtonFrame:(CGRect)frame normalImageName:(NSString *)normalImageName highlightedImageName:(NSString *)highlightedImageName title:(NSString *)title font:(UIFont *)font normalTitleColor:(UIColor *)normalTitleColor highlightedTitleColor:(UIColor *)highlightedTitleColor;

/// 创建button，文字，字体，正常字体颜色，高亮字体颜色，正常底图，高亮底图
+ (UIButton *)fm_createButtonFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font normalTitleColor:(UIColor *)normalTitleColor highlightedTitleColor:(UIColor *)highlightedTitleColor normalBgImageName:(NSString *)normalImageName highlightedBgImageName:(NSString *)highlightedImageName;

/// 创建button，文字，字体，正常字体颜色，高亮字体颜色，正常背景色，高亮背景色，圆角cornerRadius
+ (UIButton *)fm_createButtonFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font normalTitleColor:(UIColor *)normalTitleColor highlightedTitleColor:(UIColor *)highlightedTitleColor normalBackgroundColor:(UIColor *)normalBackgroundColor highlightedBackgroundColor:(UIColor *)highlightedBackgroundColor cornerRadius:(CGFloat)cornerRadius;



#pragma mark - ---------------------- 实例方法在下面 ----------------------

/**  button，highlighted相关设置  */
- (void)fm_highlightedTitleColor:(UIColor *)highlightedTitleColor highlightedImage:(UIImage *)highlightedImage normalBackgroundImage:(UIImage *)normalBackgroundImage highlightedTitle:(NSString *)highlightedTitle;

//button添加事件block
- (void)addActionHandle:(CallBackBlock)block;

//设置button响应区域大小(小于此区域则放大，否则保持原大小不变，不赋值保持原大小不变，center相同)
- (void)setMinEventTouchSize:(CGSize)minSize;


@end
