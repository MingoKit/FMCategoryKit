//
//  UITextView+FMExtension.h
//  MobileProject
//
//  Created by Mingo on 2017/7/14.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (FMExtension)
+ (UITextView *)fm_initTextViewTitleColor:(UIColor *)color backColor:(UIColor *)backColor font:(NSInteger)font textAlignment_Left0_Center1_Right2:(NSInteger)styleNum cornerRadius:(CGFloat)cornerRadius textBorderStyleColor:(UIColor *)textBorderStyleColor  addToSuperView:(UIView *)superView title:(NSString *)title;
@end
