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

@end
