//
//  UITextView+FMExtension.m
//  MobileProject
//
//  Created by Mingo on 2017/7/14.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "UITextView+FMExtension.h"
#import "UITextView+PlaceHolder.h"

@implementation UITextView (FMExtension)
+ (UITextView *)fm_initTextViewTitleColor:(UIColor *)color backColor:(UIColor *)backColor font:(NSInteger)font textAlignment_Left0_Center1_Right2:(NSInteger)styleNum cornerRadius:(CGFloat)cornerRadius textBorderStyleColor:(UIColor *)textBorderStyleColor  addToSuperView:(UIView *)superView title:(NSString *)title {

    UITextView *objView = [[UITextView alloc] init];
    objView.contentInset = UIEdgeInsetsMake(10.f, 0.f, -10.f, 0.f); //文字内容和上下边框距离
    if (color) [objView setTextColor:color];
    
    if (backColor)  objView.backgroundColor = backColor;
    if (font) objView.font =  [UIFont systemFontOfSize:font];
    
    switch (styleNum) {
        case 0:
            objView.textAlignment = NSTextAlignmentLeft;
            break;
        case 1:
            objView.textAlignment = NSTextAlignmentCenter;
            break;
        case 2:
            objView.textAlignment = NSTextAlignmentRight;
            break;
        default:
            break;
    }
    
    if (cornerRadius > 0.0) {
        objView.layer.cornerRadius = cornerRadius;
        objView.clipsToBounds = YES;
    }
    
    if (textBorderStyleColor) {
        objView.layer.borderColor = textBorderStyleColor.CGColor;
        objView.layer.borderWidth = 1.0f;
    }else{
        //  objView.borderStyle = UITextBorderStyleNone;
//        objView.layer.borderColor = kGreyColor.CGColor;
//        objView.layer.borderWidth = 1.0f;
    }
 
    
    [superView addSubview:objView];
//    if (placeholder) objView.placeHolder = placeholder;
    if (title) objView.text = title;
    

    
    
    return objView;
}
@end
