//
//  UIButton+FMExtension.h
//  MobileProject
//
//  Created by Mingo on 2017/7/20.
//  Copyright © 2017年 袁凤鸣. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CallBackBlock)(UIButton * button);
typedef void (^TouchedButtonBlock)(void);



@interface UIButton (FMExtension)


/** 快速创建按钮 */
+(instancetype)fm_buttonWithTitle:(NSString *)title backColor:(UIColor *)backColor backImageName:(NSString *)backImageName titleColor:(UIColor *)color fontSize:(int)fontSize frame:(CGRect)frame cornerRadius:(CGFloat)cornerRadius;

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
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;


/**  button，highlighted相关设置  */
- (void)fm_highlightedTitleColor:(UIColor *)highlightedTitleColor highlightedImage:(UIImage *)highlightedImage normalBackgroundImage:(UIImage *)normalBackgroundImage highlightedTitle:(NSString *)highlightedTitle;

//button添加事件block
- (void)addActionHandle:(CallBackBlock)block;

//设置button响应区域大小(小于此区域则放大，否则保持原大小不变，不赋值保持原大小不变，center相同)
- (void)setMinEventTouchSize:(CGSize)minSize;


/**
 多久之后开始执行
 
 @param timeout 多少秒
 @param waitBlock 倒计时
 @param finishBlock 倒计时结束时回调
 */
- (void)startTime:(NSInteger)timeout waitBlock:(void(^)(NSInteger remainTime))waitBlock finishBlock:(void(^)(void))finishBlock;

/** 触发按钮点击事件 */
- (void)fm_addActionHandler:(TouchedButtonBlock)touchHandler;

/** 显示菊花 */
- (void)fm_showIndicator;

/** 隐藏菊花 */
- (void)fm_hideIndicator;


/**
 按钮倒计时
 @param timeLine 倒计时时间 如：60
 @param normalTitle 倒计时结束后 显示的文字
 @param countdownSubtitle 倒计时期间 除去数字后 显示的文字 如：60S后刷新，那就是 S后刷新
 @param normalColor 倒计时结束后 文字颜色
 @param countdownColor 倒计时期间 文字颜色
 @param isFlashing 文字是否闪动
 */
- (void)fm_countdownTime:(NSInteger)timeLine normalTitle:(NSString *)normalTitle countdownSubtitle:(NSString *)countdownSubtitle normalColor:(UIColor *)normalColor countdownColor:(UIColor *)countdownColor isFlashing:(BOOL)isFlashing;
/**
 按钮倒计时
 @param timeLine 倒计时时间 如：60
 @param normalTitle 倒计时结束后 显示的文字
 @param beforeTitle 倒计时期间 数字前面 显示的文字 如：将在60S后刷新，那就是 将在
 @param behindTitle 倒计时期间 数字后面 显示的文字 如：将在60S后刷新，那就是 S后刷新
 @param normalColor 倒计时结束后 文字颜色
 @param countdownColor 倒计时期间 文字颜色
 @param isFlashing 文字是否闪动
 @param waitBlock 每秒执行的 waitBlock
 @param finishBlock 倒计时结束 finishBlock 【中途手动结束调用 closeBlock 】
 */
- (void)fm_countdownTime:(NSInteger)timeLine normalTitle:(NSString *)normalTitle countNumBeforeTitle:(NSString *)beforeTitle countNumBehindTitle:(NSString *)behindTitle normalColor:(UIColor *)normalColor countdownColor:(UIColor *)countdownColor isFlashing:(BOOL)isFlashing cuntingEnabled:(BOOL)cuntingEnabled waitBlock:(void(^)(NSInteger remainTime))waitBlock finishBlock:(void(^)(void))finishBlock;

typedef void(^CloseBlock)(id objc);
@property (copy, nonatomic) CloseBlock closeBlock;


/** 改变按钮的响应区域,上左下右分别增加或减小多少 正数为增加 负数为减小 */
@property (nonatomic, assign) UIEdgeInsets clickEdgeInsets;

/** 角标 */
@property (strong, nonatomic) UILabel *badge;



/** 角标的值 */
@property (nonatomic) NSString *badgeValue;

/** 角标背景颜色 */
@property (nonatomic) UIColor *badgeBGColor;

/** 角标文字颜色 */
@property (nonatomic) UIColor *badgeTextColor;

/** 角标文字的字体 */
@property (nonatomic) UIFont *badgeFont;

/** 角标边距 */
@property (nonatomic) CGFloat badgePadding;

/** 角标最小的大小 */
@property (nonatomic) CGFloat badgeMinSize;

/** 角标x坐标 */
@property (nonatomic) CGFloat badgeOriginX;

/** 角标y坐标 */
@property (nonatomic) CGFloat badgeOriginY;

/** 如果是数字0的话就隐藏角标不显示 */
@property BOOL shouldHideBadgeAtZero;

/** 显示角标是否要缩放动画 */
@property BOOL shouldAnimateBadge;


#pragma mark - xib扩展

@property (nonatomic, strong) IBInspectable UIColor *selecedColor;
@property (nonatomic, strong) IBInspectable UIImage *selecedBgImage;
@end
