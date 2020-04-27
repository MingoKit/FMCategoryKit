//
//  UIImageView+FMExtension.h
//  MingoKit
//
//  Created by Mingo on 16/10/16.
//  Copyright © 2016年 袁凤鸣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (FMExtension)
 

/** 快速创建UIImageView  */
+ (UIImageView *)fm_initUIImageViewWithName:(NSString *)urlOrName ifHasPlaceholderImageName:(NSString *)placeholderImageName cornerRadius:(CGFloat)radius addTapGestureRecognizer:(id)object tapSel:(SEL)tapSel addToSuperView:(UIView *)superView ;

/// 创建imageView
+ (UIImageView *)fm_createImageView:(CGRect)frame addToSuperView:(UIView *)superView imageName:(NSString *)imageName;
/**
 *  @brief  倒影
 */
- (void)reflect;
/// 改变图片的颜色 图片颜色
- (void)fm_changeColor:(UIColor *)color;
@end
