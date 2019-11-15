//
//  UITextField+FMExtenion.h
//  zms
//
//  Created by Mingo on 17/2/24.
//  Copyright © 2017年 袁凤鸣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (FMExtenion)


/** 快速创建TextField  边框颜色默认nil为灰色 */
+ (UITextField *)fm_initTextFieldTitleColor:(UIColor *)color backColor:(UIColor *)backColor font:(NSInteger)font textAlignment_Left0_Center1_Right2:(NSInteger)styleNum cornerRadius:(CGFloat)cornerRadius textBorderStyleColor:(UIColor *)textBorderStyleColor  distanceToLeft:(CGFloat)distanceToLeft addToSuperView:(UIView *)superView  placeholder:(NSString *)placeholder title:(NSString *)title;

/**  设置隐藏键盘按钮 */
- (void)AddHiddenButton;

/** 创建textField  */
+ (UITextField *)fm_createTextField:(CGRect)frame textColor:(UIColor *)textColor font:(UIFont *)font placeholder:(NSString *)placeholder;

/** 创建一个textFiled，左侧带一个图标，并且要指定图标宽高和左侧整个占据的距离 */
+ (UITextField *)fm_createTextFieldWithImageName:(CGRect)frame imageName:(NSString *)imageName imageWidth:(CGFloat)imageWidth imageHeight:(CGFloat)imageHeight leftAllWidth:(CGFloat)leftAllWidth font:(UIFont *)font textColor:(UIColor *)textColor placeholder:(NSString *)placeholder;

/** 创建一个textFiled,左侧带文字，文字颜色，字体，leftSpace，leftAllWidth，输入框文字颜色，输入框文字字体，placeholder */
+ (UITextField *)fm_createTextFieldFrame:(CGRect)frame leftText:(NSString *)leftText leftTextColor:(UIColor *)leftTextColor leftTextfont:(UIFont *)leftTextfont leftSpace:(CGFloat)leftSpace leftAllWidth:(CGFloat)leftAllWidth inputTextColor:(UIColor *)inputTextColor inputTextfont:(UIFont *)inputTextfont placeholder:(NSString *)placeholder;

- (UITextField *)fm_leftViewImageName:(NSString *)name;

/**
 最大长度
 */
@property (nonatomic, assign) NSInteger maxLength;

/**
 是否只可以输入数字
 */
@property (nonatomic, assign) BOOL canOnlyInputNumber;

#pragma mark - LeftView

/**
 *  设置leftview为图片
 *
 *  @param imageName 图片名称
 */
- (void)setLeftViewWithImageName:(NSString *)imageName;

/**
 *  设置leftView为文字
 *
 */
- (void)setLeftViewWithText:(NSString *)text;

/**
 *  设置leftView为文字
 *
 *  @param text  文字
 *  @param minWidth 最小宽度
 */
- (void)setLeftViewWithText:(NSString *)text minWidth:(CGFloat)minWidth;

/**
 *  设置leftView为文字
 *
 *  @param text  文字
 *  @param minWidth 最小宽度
 *  @param color 占位文字颜色
 */
- (void)setLeftViewWithText:(NSString *)text minWidth:(CGFloat)minWidth color:(UIColor *)color;

#pragma mark - RightView
/**
 *  设置rightView为文字
 *
 *  @param text 文字
 */
- (void)setRightViewWithText:(NSString *)text;

/**
 *  设置rightView为图片
 *
 *  @param imageName 图片名称
 */
- (void)setRightViewWithImageName:(NSString *)imageName;

/**
 *  设置rightView为button
 *
 *  @param imageName 图片名称
 */
- (void)setRightViewButtonWithImageName:(NSString *)imageName taget:(id)taget selector:(SEL)selector;

#pragma mark - Padding
/**
 *  设置UITextField左侧内边距
 *
 *  @param padding 距离
 */
- (void)setPaddingLeftSpace:(float)padding;

/**
 *  设置UITextField右侧内边距
 *
 *  @param padding 距离
 */
- (void)setPaddingRightSpace:(float)padding;

#pragma mark - UI显示
/**
 *  设置底部边框
 *
 *  @param lineColor 边框颜色
 */
- (void)setBottomBorderLineWithColor:(UIColor *)lineColor;

/**
 *  设置placeholder的颜色
 *
 */
- (void)fm_setPlaceholderColor:(UIColor *)color;
- (void)fm_setPlaceholderColor:(UIColor *)color font:(NSInteger )font;
/**
 *  设置下划线出去左边的文字
 */
- (void)setLeftViewWithText:(NSString *)text minWidth:(CGFloat)minWidth withOutTextBottomLineColor:(UIColor *)color;

@end
