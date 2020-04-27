//
//  UIView+FMXibStyle.h
//  FMXibStyle
//
//  Created by JohnnyHoo on 2018/12/19.
//

#import <UIKit/UIKit.h>
//IB_DESIGNABLE 不注释报错 failed to load designables from path (null)
@interface UIView (FMXibStyle)

typedef NS_ENUM(NSInteger, GradientStyle) {
    GradientStyleLeftToRight = 1,//渐变左到右
    GradientStyleTopToBottom = 2//渐变上到下
};

///头部圆角
@property (nonatomic, assign) IBInspectable BOOL roundTop;
///底部圆角
@property (nonatomic, assign) IBInspectable BOOL roundBottom;
///左边圆角
@property (nonatomic, assign) IBInspectable BOOL roundLeft;
///右边圆角
@property (nonatomic, assign) IBInspectable BOOL roundRight;

///圆
@property (nonatomic, assign) IBInspectable BOOL circle;
///圆角
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
///边框宽度
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
///边框颜色
@property (nonatomic, strong) IBInspectable UIColor *borderColor;

///阴影颜色
@property (nonatomic, strong) IBInspectable UIColor *shadowColor;
///阴影半径 默认1
@property (nonatomic, assign) IBInspectable CGFloat shadowRadius;
///阴影透明度 默认1
@property (nonatomic, assign) IBInspectable CGFloat shadowOpacity;
///阴影偏移
@property (nonatomic, assign) IBInspectable CGSize shadowOffset;

///是否开启主题渐变风格 (很多APP渐变风格大多数都是一致了.为了更快设置颜色而添加的属性,具体用法实现UIView+Theme方法)
@property (nonatomic, assign) IBInspectable BOOL themeGradientEnable;
///渐变方向
@property(nonatomic, assign) GradientStyle gradientStyle;
///渐变方向 xib用
@property(nonatomic, assign) IBInspectable NSInteger gradientStyleEnum;
///渐变A颜色
@property (nonatomic, strong) IBInspectable UIColor *gradientAColor;
///渐变B颜色
@property (nonatomic, strong) IBInspectable UIColor *gradientBColor;


/// 阴影Layer
@property(nonatomic, strong) CALayer *backgroundShadowLayer;
// 渐变Layer
@property(nonatomic, strong) CAGradientLayer *gradientLayer;
// 边圆角Layer
@property(nonatomic, strong) CAShapeLayer *maskLayer;


    /// NOTE：修改xib没有效果 清除Xcode缓存
@property (nonatomic, assign) IBInspectable CGFloat clipRadius;
@property (nonatomic, assign) IBInspectable CGFloat radius;
@property (nonatomic, assign) IBInspectable CGFloat bWidth;
@property (nonatomic, strong) IBInspectable UIColor *bColor;

//@property (nonatomic, assign) IBInspectable CGFloat shadowRadius;
//@property (nonatomic, strong) IBInspectable UIColor *shadowColor;
//@property (nonatomic, assign) IBInspectable CGFloat shadowOpacity;
//@property (nonatomic, assign) IBInspectable CGSize shadowOffset;

@end

