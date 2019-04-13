//
//  UIButton+FMExtension.m
//  MobileProject
//
//  Created by Mingo on 2017/7/6.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "UIButton+FMExtension.h"
#import "UIImage+FMExtension.h"
#import <objc/runtime.h>


@interface UIButton ()

@property (nonatomic, copy) CallBackBlock actionBlock;

//事件响应最小区域大小(小于此区域则放大，否则保持原大小不变，不赋值保持原大小不变，center相同)
@property (nonatomic, assign) CGSize eventFrame;

@end

@implementation UIButton (FMExtension)

#pragma mark - 快速创建button，highlighted相关设置在对象方法： fm_highlightedTitleColor
+ (UIButton *)fm_initButtonNormalTitleColor:(UIColor *)normalColor  backgroundColor:(UIColor *)BGColor font:(CGFloat)font normalImage:(UIImage *)normalImage cornerRadius:(CGFloat)cornerRadius  addToSuperView:(UIView *)superView addTarget:(id)controller action:(SEL)sel normalTitle:(NSString *)normalTitle {
    
    UIButton *but =  [[UIButton alloc] init];

    if (normalColor) [but setTitleColor:normalColor forState:UIControlStateNormal];
    if (BGColor) [but setBackgroundColor:BGColor];
    if (font) [but.titleLabel setFont:[UIFont systemFontOfSize:font]];
    if (normalImage) [but setImage:normalImage forState:UIControlStateNormal];
  
    if (cornerRadius>0.0) {
        but.layer.cornerRadius = cornerRadius;
        but.clipsToBounds  = YES;
    }
   
    if (superView) [superView addSubview:but];
    
    if (controller && sel) {
        [but addTarget:controller action:sel forControlEvents:UIControlEventTouchUpInside];
    }

    
    if (normalTitle) [but setTitle:normalTitle forState:UIControlStateNormal];
    
    
    //    [but setTitleEdgeInsets:UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
    //    [but setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, but.width/2)];
    //    [but setImageEdgeInsets:UIEdgeInsetsMake(0, but.width/6, 0, 0)];
    
    return but;
    
}

#pragma mark - 快速创建button，不包含点击事件。highlighted相关设置在对象方法： fm_highlightedTitleColor
+ (UIButton *)fm_initButtonNormalTitleColor:(UIColor *)normalColor  backgroundColor:(UIColor *)BGColor font:(CGFloat)font normalImage:(UIImage *)normalImage cornerRadius:(CGFloat)cornerRadius addToSuperView:(UIView *)superView normalTitle:(NSString *)normalTitle {
    
    UIButton *but =  [[UIButton alloc] init];
    if (normalColor) [but setTitleColor:normalColor forState:UIControlStateNormal];
    if (BGColor) [but setBackgroundColor:BGColor];
    if (font) [but.titleLabel setFont:[UIFont systemFontOfSize:font]];
    if (normalImage) [but setImage:normalImage forState:UIControlStateNormal];
    
    if (cornerRadius>0.0) {
        but.layer.cornerRadius = cornerRadius;
        but.clipsToBounds  = YES;
    }
    
    if (superView) [superView addSubview:but];
    
   
    if (normalTitle) [but setTitle:normalTitle forState:UIControlStateNormal];
    
    return but;
    
}


#pragma mark - 创建button，正常图片和高亮图片
+ (UIButton *)fm_createButtonFrame:(CGRect)frame normalImageName:(NSString *)normalImageName highlightedImageName:(NSString *)highlightedImageName{
    
    UIButton *btn = [[UIButton alloc]initWithFrame:frame];
    [btn setImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal];
    
    if (highlightedImageName != nil) {
        [btn setImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    }
    
    return btn;
    
}

#pragma mark - 创建button，文字，字体，正常字体颜色，高亮字体颜色
+ (UIButton *)fm_createButtonFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font normalTitleColor:(UIColor *)normalTitleColor highlightedTitleColor:(UIColor *)highlightedTitleColor{
    
    UIButton *btn = [[UIButton alloc]initWithFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    [btn setTitleColor:normalTitleColor forState:UIControlStateNormal];
    
    if (highlightedTitleColor != nil) {
        [btn setTitleColor:highlightedTitleColor forState:UIControlStateHighlighted];
    }
    
    return btn;
    
}

#pragma mark - 创建button，正常图片和高亮图片，title文字，字体，正常字体颜色，高亮字体颜色
+ (UIButton *)fm_createButtonFrame:(CGRect)frame normalImageName:(NSString *)normalImageName highlightedImageName:(NSString *)highlightedImageName title:(NSString *)title font:(UIFont *)font normalTitleColor:(UIColor *)normalTitleColor highlightedTitleColor:(UIColor *)highlightedTitleColor{
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    [btn setTitleColor:normalTitleColor forState:UIControlStateNormal];
    
    if (highlightedTitleColor != nil) {
        [btn setTitleColor:highlightedTitleColor forState:UIControlStateHighlighted];
    }
    
    [btn setImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal];
    if (highlightedImageName != nil) {
        [btn setImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    }
    return btn;
}

#pragma mark - 创建button，文字，字体，正常字体颜色，高亮字体颜色，正常底图，高亮底图
+ (UIButton *)fm_createButtonFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font normalTitleColor:(UIColor *)normalTitleColor highlightedTitleColor:(UIColor *)highlightedTitleColor normalBgImageName:(NSString *)normalImageName highlightedBgImageName:(NSString *)highlightedImageName{
    
    UIButton *btn = [[UIButton alloc]initWithFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    [btn setTitleColor:normalTitleColor forState:UIControlStateNormal];
    
    if (highlightedTitleColor != nil) {
        [btn setTitleColor:highlightedTitleColor forState:UIControlStateHighlighted];
    }
    
    [btn setBackgroundImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal];
    
    if (highlightedImageName != nil) {
        [btn setBackgroundImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    }
    else{
        btn.adjustsImageWhenHighlighted = NO;
    }
    
    return btn;
    
}

#pragma mark - 创建button，文字，字体，正常字体颜色，高亮字体颜色，正常背景色，高亮背景色，圆角cornerRadius
+ (UIButton *)fm_createButtonFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font normalTitleColor:(UIColor *)normalTitleColor highlightedTitleColor:(UIColor *)highlightedTitleColor normalBackgroundColor:(UIColor *)normalBackgroundColor highlightedBackgroundColor:(UIColor *)highlightedBackgroundColor cornerRadius:(CGFloat)cornerRadius{
    
    UIButton *btn = [[UIButton alloc]initWithFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    [btn setTitleColor:normalTitleColor forState:UIControlStateNormal];
    
    if (highlightedTitleColor) {
        [btn setTitleColor:highlightedTitleColor forState:UIControlStateHighlighted];
    }
    
    [btn setBackgroundImage:[UIImage fm_createImageWithColor:normalBackgroundColor cornerRadius:cornerRadius] forState:UIControlStateNormal];
    
    if (highlightedBackgroundColor) {
        [btn setBackgroundImage:[UIImage fm_createImageWithColor:highlightedBackgroundColor cornerRadius:cornerRadius] forState:UIControlStateHighlighted];
    } else{
        btn.adjustsImageWhenHighlighted = NO;
    }
    if (cornerRadius) {
        btn.layer.cornerRadius = cornerRadius;
        btn.layer.masksToBounds = YES;
    }
    
    return btn;
}

#pragma mark - -------------------- 实例方法在下面 ---------------------

#pragma mark - button，highlighted相关设置
- (void)fm_highlightedTitleColor:(UIColor *)highlightedTitleColor highlightedImage:(UIImage *)highlightedImage normalBackgroundImage:(UIImage *)normalBackgroundImage highlightedTitle:(NSString *)highlightedTitle {
    
    if (highlightedTitleColor) [self setTitleColor:highlightedTitleColor forState:UIControlStateHighlighted];
    if (highlightedImage) [self setImage:highlightedImage forState:UIControlStateHighlighted];
    if (normalBackgroundImage) [self setBackgroundImage:normalBackgroundImage forState:UIControlStateNormal];
    if (highlightedTitle) [self setTitle:highlightedTitle forState:UIControlStateHighlighted];
}

#pragma mark - ----------------button添加事件block----------------
//setter
- (void)setActionBlock:(CallBackBlock)actionBlock{
    objc_setAssociatedObject(self, _cmd, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

//getter
- (CallBackBlock)actionBlock{
    return objc_getAssociatedObject(self, @selector(setActionBlock:));
}

- (void)addActionHandle:(CallBackBlock)block{
    self.actionBlock = block;
    [self addTarget:self action:@selector(didClickAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didClickAction:(UIButton *)sender{
    if (self.actionBlock) {
        self.actionBlock(sender);
    }
}

#pragma mark - ----------------设置button响应区域大小----------------

- (void)setEventFrame:(CGSize)eventFrame{
    NSString *eventFramStr = NSStringFromCGSize(eventFrame);
    objc_setAssociatedObject(self, _cmd, eventFramStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (CGSize)eventFrame{
    NSString *eventFramStr = objc_getAssociatedObject(self, @selector(setEventFrame:));
    return CGSizeFromString(eventFramStr);
}

- (void)setMinEventTouchSize:(CGSize)minSize{
    self.eventFrame = minSize;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event{
    CGRect bounds = self.bounds;
    CGFloat widthExtra = MAX(self.eventFrame.width - bounds.size.width, 0);
    CGFloat heightExtra = MAX(self.eventFrame.height - bounds.size.height, 0);
    bounds = CGRectInset(bounds, -0.5 * widthExtra, -0.5 * heightExtra);
    return CGRectContainsPoint(bounds, point);
    
}


// 设置背景颜色for state
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    [self setBackgroundImage:[UIButton imageWithColor:backgroundColor] forState:state];
}

// 设置颜色
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


@end
