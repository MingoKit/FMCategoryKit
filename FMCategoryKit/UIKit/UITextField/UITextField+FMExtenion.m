//
//  UITextField+FMExtenion.m
//  zms
//
//  Created by Mingo on 17/2/24.
//  Copyright © 2017年 袁凤鸣. All rights reserved.
//

#import "UITextField+FMExtenion.h"

#define kScreenW ([UIScreen mainScreen].bounds.size.width)
#define kScreenH ([UIScreen mainScreen].bounds.size.hight)

@implementation UITextField (FMExtenion)

#pragma mark - 需要自己设置边框颜色，不设置就是无边框等等
/**  需要自己设置边框颜色，不设置就是无边框等等 */
+ (UITextField *)fm_initTextFieldTitleColor:(UIColor *)color backColor:(UIColor *)backColor font:(NSInteger)font textAlignment_Left0_Center1_Right2:(NSInteger)styleNum cornerRadius:(CGFloat)cornerRadius textBorderStyleColor:(UIColor *)textBorderStyleColor  distanceToLeft:(CGFloat)distanceToLeft addToSuperView:(UIView *)superView  placeholder:(NSString *)placeholder title:(NSString *)title {
    
    UITextField *field = [[UITextField alloc] init];
    if (color) [field setTextColor:color];
    
    if (backColor)  field.backgroundColor = backColor;
    if (font) field.font =  [UIFont systemFontOfSize:(font)];
    
    switch (styleNum) {
        case 0:
            field.textAlignment = NSTextAlignmentLeft;
            break;
        case 1:
            field.textAlignment = NSTextAlignmentCenter;
            break;
        case 2:
            field.textAlignment = NSTextAlignmentRight;
            break;
        default:
            break;
    }
    
    if (cornerRadius > 0.0) {
        field.layer.cornerRadius = cornerRadius;
        field.clipsToBounds = YES;
    }
    
    if (textBorderStyleColor) {
        field.layer.borderColor = textBorderStyleColor.CGColor;
        field.layer.borderWidth = 1.0f;
    }else{
        //  field.borderStyle = UITextBorderStyleNone;
        field.layer.borderColor = [UIColor grayColor].CGColor;
        field.layer.borderWidth = 1.0f;
    }
    
    if (distanceToLeft) {
        field.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, distanceToLeft, 0)];
        field.leftViewMode = UITextFieldViewModeAlways; //设置显示模式为永远显示(默认不显示)
    }
    
    [superView addSubview:field];
    if (placeholder) field.placeholder = placeholder;
    if (title) field.text = title;
    
    return field;
    
}

#pragma mark - //设置隐藏键盘按钮
- (void)AddHiddenButton {
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(30,30),NO,0);
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, 2);
    CGContextMoveToPoint(context, 5, 7);
    CGContextAddLineToPoint(context, 15, 18);
    CGContextAddLineToPoint(context, 25, 7);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextStrokePath(context);
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIButton *hiddenButton = [UIButton buttonWithType:UIButtonTypeCustom];
    hiddenButton.layer.masksToBounds=YES;
    hiddenButton.layer.cornerRadius = 5.0f;
    [hiddenButton setImage:image forState:UIControlStateNormal];
    [hiddenButton setBackgroundColor:[UIColor colorWithRed:189/255.0f green:192/255.0f blue:197/255.0f alpha:1.0f]];
    [hiddenButton setFrame:CGRectMake(kScreenW - 64, 0 , 55.0f, 35.0f)];
    [hiddenButton addTarget:self action:@selector(hiddenKeyboard) forControlEvents:UIControlEventTouchUpInside];
    if([[[UIDevice currentDevice] systemVersion] doubleValue] <= 5.2) {
        hiddenButton.layer.borderWidth=1.0f;
    }
    UIView * inputAccessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , kScreenW, 30.0f)];
    [inputAccessoryView addSubview:hiddenButton];
    inputAccessoryView.clipsToBounds = YES;
    self.inputAccessoryView = inputAccessoryView;
}


- (void)hiddenKeyboard {
    if ([self.delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        [self.delegate textFieldShouldReturn:self];
    }
}

/**
 创建textField
 */
+ (UITextField *)fm_createTextField:(CGRect)frame textColor:(UIColor *)textColor font:(UIFont *)font placeholder:(NSString *)placeholder{
    
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.backgroundColor = [UIColor clearColor];
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.textColor = textColor;
    textField.font = font;
    textField.placeholder = placeholder;
    textField.returnKeyType = UIReturnKeyDone;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    return textField;
}

//创建一个textFiled，左侧带一个图标，并且要指定图标宽高和左侧整个占据的距离
+ (UITextField *)fm_createTextFieldWithImageName:(CGRect)frame imageName:(NSString *)imageName imageWidth:(CGFloat)imageWidth imageHeight:(CGFloat)imageHeight leftAllWidth:(CGFloat)leftAllWidth font:(UIFont *)font textColor:(UIColor *)textColor placeholder:(NSString *)placeholder{
    
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.backgroundColor = [UIColor clearColor];
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.textColor = textColor;
    textField.font = font;
    textField.placeholder = placeholder;
    textField.returnKeyType = UIReturnKeyDone;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, leftAllWidth, CGRectGetHeight(frame))];
    
    
    UIImageView *leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(leftView.frame)/2 - imageWidth/2, CGRectGetHeight(leftView.frame)/2 - imageHeight/2, imageWidth, imageHeight)];
    leftImageView.image = [UIImage imageNamed:imageName];
    
    [leftView addSubview:leftImageView];
    
    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    return textField;
}


/**
 创建一个textFiled,左侧带文字，文字颜色，字体，leftSpace，leftAllWidth，输入框文字颜色，输入框文字字体，placeholder
 */
+ (UITextField *)fm_createTextFieldFrame:(CGRect)frame leftText:(NSString *)leftText leftTextColor:(UIColor *)leftTextColor leftTextfont:(UIFont *)leftTextfont leftSpace:(CGFloat)leftSpace leftAllWidth:(CGFloat)leftAllWidth inputTextColor:(UIColor *)inputTextColor inputTextfont:(UIFont *)inputTextfont placeholder:(NSString *)placeholder{
    
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.backgroundColor = [UIColor clearColor];
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.textColor = inputTextColor;
    textField.font = inputTextfont;
    textField.placeholder = placeholder;
    textField.returnKeyType = UIReturnKeyDone;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, leftAllWidth, CGRectGetHeight(frame))];
    
    UILabel *leftTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(leftSpace, 0, CGRectGetWidth(leftView.frame) - leftSpace, CGRectGetHeight(leftView.frame))];
    leftTextLabel.text = leftText;
    leftTextLabel.textAlignment = NSTextAlignmentLeft;
    leftTextLabel.textColor = leftTextColor;
    leftTextLabel.font = leftTextfont;
    leftTextLabel.backgroundColor = [UIColor clearColor];
    
    [leftView addSubview:leftTextLabel];
    
    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    return textField;
}

- (UITextField *)fm_leftViewImageName:(NSString *)name {
    UIImageView *ima =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
    UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, self.frame.size.height)];
    [back addSubview:ima];
    [ima setFrame:CGRectMake((back.frame.size.width - 5 *2)/2, (back.frame.size.height - 18)/2, 15, 18)];
    self.leftView = back;
    self.leftViewMode = UITextFieldViewModeAlways;
    return self;
}


@end
