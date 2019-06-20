//
//  UILabel+FMExtension.h
//  
//
//  Created by Mingo on 16/11/14.
//
//

#import <UIKit/UIKit.h>

@interface UILabel (FMExtension)

/** 快速创建UILabel */
+ (UILabel *)fm_initUIlabelWithTextColor:(UIColor *)color backColor:(UIColor *)backColor textAlignment_Left0_Center1_Right2:(NSInteger)styleNum font:(NSInteger)font cornerRadius:(CGFloat)cornerRadius  addToSuperView:(UIView *)superView title:(NSString *)title;

/** 创建一个label */
+(UILabel *)fm_createLabelFrame:(CGRect)frame withText:(NSString *)text withAlign:(NSTextAlignment)align withColor:(UIColor *)color withFont:(UIFont *)font;

/** 显示收益率文字颜色，以"."分隔，左边字体大小，右边字体大小 */
- (void)fm_showRateNumString:(NSString *)numString color:(UIColor *)color leftFont:(UIFont *)leftFont rightFont:(UIFont *)rightFont;

/** 设置lable的某些字符颜色 */
- (void)fm_attributedStringWithRangeColor:(UIColor *)rangeColor needUnderline:(BOOL)needUnderline rangeString:(NSString *)rangeStr;

/// 添加中划线
- (void)fm_addSingleLine;
@end
