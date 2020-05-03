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


static NSString *const IndicatorViewKey = @"indicatorView";
static NSString *const ButtonTextObjectKey = @"buttonTextObject";

NSString const *UIButton_badgeKey = @"UIButton_badgeKey";
NSString const *UIButton_closeBlockKey = @"UIButton_closeBlockKey";
NSString const *UIButton_badgeBGColorKey = @"UIButton_badgeBGColorKey";
NSString const *UIButton_badgeTextColorKey = @"UIButton_badgeTextColorKey";
NSString const *UIButton_badgeFontKey = @"UIButton_badgeFontKey";
NSString const *UIButton_badgePaddingKey = @"UIButton_badgePaddingKey";
NSString const *UIButton_badgeMinSizeKey = @"UIButton_badgeMinSizeKey";
NSString const *UIButton_badgeOriginXKey = @"UIButton_badgeOriginXKey";
NSString const *UIButton_badgeOriginYKey = @"UIButton_badgeOriginYKey";
NSString const *UIButton_shouldHideBadgeAtZeroKey = @"UIButton_shouldHideBadgeAtZeroKey";
NSString const *UIButton_shouldAnimateBadgeKey = @"UIButton_shouldAnimateBadgeKey";
NSString const *UIButton_badgeValueKey = @"UIButton_badgeValueKey";

@interface UIButton ()

@property (nonatomic, copy) CallBackBlock actionBlock;

//事件响应最小区域大小(小于此区域则放大，否则保持原大小不变，不赋值保持原大小不变，center相同)
@property (nonatomic, assign) CGSize eventFrame;

@end

@implementation UIButton (FMExtension)

@dynamic badgeValue, badgeBGColor, badgeTextColor, badgeFont;
@dynamic badgePadding, badgeMinSize, badgeOriginX, badgeOriginY;
@dynamic shouldHideBadgeAtZero, shouldAnimateBadge;

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




+(instancetype)fm_buttonWithTitle:(NSString *)title backColor:(UIColor *)backColor backImageName:(NSString *)backImageName titleColor:(UIColor *)color fontSize:(int)fontSize frame:(CGRect)frame cornerRadius:(CGFloat)cornerRadius {
    
    UIButton *button = [UIButton new];
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundColor:backColor];
    [button setBackgroundImage:[UIImage imageNamed:backImageName] forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [button sizeToFit];
    button.frame=frame;
    button.layer.cornerRadius=cornerRadius;
    button.clipsToBounds=YES;
    return button;
}



- (void)startTime:(NSInteger)timeout waitBlock:(void(^)(NSInteger remainTime))waitBlock finishBlock:(void(^)(void))finishBlock;
{
    __block NSInteger timeOut = timeout;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeOut <= 0)
        {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (finishBlock)
                {
                    finishBlock();
                }
                self.userInteractionEnabled = YES;
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (waitBlock)
                {
                    waitBlock(timeOut);
                }
                self.userInteractionEnabled = NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}


- (void)fm_addActionHandler:(TouchedButtonBlock)touchHandler
{
    objc_setAssociatedObject(self, @selector(fm_addActionHandler:), touchHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(blockActionTouched:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)blockActionTouched:(UIButton *)btn
{
    TouchedButtonBlock block = objc_getAssociatedObject(self, @selector(fm_addActionHandler:));
    if (block)
    {
        block();
    }
}



- (void)fm_showIndicator
{
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicator.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    [indicator startAnimating];
    
    NSString *currentButtonText = self.titleLabel.text;
    
    objc_setAssociatedObject(self, &ButtonTextObjectKey, currentButtonText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &IndicatorViewKey, indicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.enabled = NO;
    [self setTitle:@"" forState:UIControlStateNormal];
    [self addSubview:indicator];
}

- (void)fm_hideIndicator
{
    NSString *currentButtonText = (NSString *)objc_getAssociatedObject(self, &ButtonTextObjectKey);
    UIActivityIndicatorView *indicator = (UIActivityIndicatorView *)objc_getAssociatedObject(self, &IndicatorViewKey);
    
    self.enabled = YES;
    [indicator removeFromSuperview];
    [self setTitle:currentButtonText forState:UIControlStateNormal];
}


- (void)badgeInit
{
    self.badgeBGColor   = [UIColor redColor];
    self.badgeTextColor = [UIColor whiteColor];
    self.badgeFont      = [UIFont systemFontOfSize:9.0];
    self.badgePadding   = 5;
    self.badgeMinSize   = 4;
    self.badgeOriginX   = self.frame.size.width - self.badge.frame.size.width/2-3;
    self.badgeOriginY   = -6;
    self.shouldHideBadgeAtZero = YES;
    self.shouldAnimateBadge = YES;
    self.clipsToBounds = NO;
}

#pragma mark - Utility methods

- (void)refreshBadge
{
    self.badge.textColor        = self.badgeTextColor;
    self.badge.backgroundColor  = self.badgeBGColor;
    self.badge.font             = self.badgeFont;
}

- (CGSize) badgeExpectedSize
{
    UILabel *frameLabel = [self duplicateLabel:self.badge];
    [frameLabel sizeToFit];
    
    CGSize expectedLabelSize = frameLabel.frame.size;
    return expectedLabelSize;
}

- (void)updateBadgeFrame
{
    CGSize expectedLabelSize = [self badgeExpectedSize];
    
    CGFloat minHeight = expectedLabelSize.height;
    
    minHeight = (minHeight < self.badgeMinSize) ? self.badgeMinSize : expectedLabelSize.height;
    CGFloat minWidth = expectedLabelSize.width;
    CGFloat padding = self.badgePadding;
    
    minWidth = (minWidth < minHeight) ? minHeight : expectedLabelSize.width;
    self.badge.frame = CGRectMake(self.badgeOriginX, self.badgeOriginY, minWidth + padding, minHeight + padding);
    self.badge.layer.cornerRadius = (minHeight + padding) / 2;
    self.badge.layer.masksToBounds = YES;
}

- (void)updateBadgeValueAnimated:(BOOL)animated
{
    if (animated && self.shouldAnimateBadge && ![self.badge.text isEqualToString:self.badgeValue]) {
        CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        [animation setFromValue:[NSNumber numberWithFloat:1.5]];
        [animation setToValue:[NSNumber numberWithFloat:1]];
        [animation setDuration:0.2];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithControlPoints:.4f :1.3f :1.f :1.f]];
        [self.badge.layer addAnimation:animation forKey:@"bounceAnimation"];
    }
    
    self.badge.text = self.badgeValue;
    
    NSTimeInterval duration = animated ? 0.2 : 0;
    [UIView animateWithDuration:duration animations:^{
        [self updateBadgeFrame];
    }];
}

- (UILabel *)duplicateLabel:(UILabel *)labelToCopy
{
    UILabel *duplicateLabel = [[UILabel alloc] initWithFrame:labelToCopy.frame];
    duplicateLabel.text = labelToCopy.text;
    duplicateLabel.font = labelToCopy.font;
    
    return duplicateLabel;
}

- (void)removeBadge
{
    
    [UIView animateWithDuration:0.2 animations:^{
        self.badge.transform = CGAffineTransformMakeScale(0, 0);
    } completion:^(BOOL finished) {
        [self.badge removeFromSuperview];
        self.badge = nil;
    }];
}

#pragma mark - getters/setters
-(CloseBlock)closeBlock {
    return objc_getAssociatedObject(self, &UIButton_closeBlockKey);
}
-(void)setCloseBlock:(CloseBlock )closeBlock
{
    objc_setAssociatedObject(self, &UIButton_closeBlockKey, closeBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(UILabel*) badge {
    return objc_getAssociatedObject(self, &UIButton_badgeKey);
}
-(void)setBadge:(UILabel *)badgeLabel
{
    objc_setAssociatedObject(self, &UIButton_badgeKey, badgeLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(NSString *)badgeValue {
    return objc_getAssociatedObject(self, &UIButton_badgeValueKey);
}
-(void) setBadgeValue:(NSString *)badgeValue
{
    objc_setAssociatedObject(self, &UIButton_badgeValueKey, badgeValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    
    if (!badgeValue || [badgeValue isEqualToString:@""] || ([badgeValue isEqualToString:@"0"] && self.shouldHideBadgeAtZero)) {
        [self removeBadge];
    } else if (!self.badge) {
        // Create a new badge because not existing
        self.badge                      = [[UILabel alloc] initWithFrame:CGRectMake(self.badgeOriginX, self.badgeOriginY, 20, 20)];
        self.badge.textColor            = self.badgeTextColor;
        self.badge.backgroundColor      = self.badgeBGColor;
        self.badge.font                 = self.badgeFont;
        self.badge.textAlignment        = NSTextAlignmentCenter;
        [self badgeInit];
        [self addSubview:self.badge];
        [self updateBadgeValueAnimated:NO];
    } else {
        [self updateBadgeValueAnimated:YES];
    }
}

-(UIColor *)badgeBGColor {
    return objc_getAssociatedObject(self, &UIButton_badgeBGColorKey);
}
-(void)setBadgeBGColor:(UIColor *)badgeBGColor
{
    objc_setAssociatedObject(self, &UIButton_badgeBGColorKey, badgeBGColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self refreshBadge];
    }
}

-(UIColor *)badgeTextColor {
    return objc_getAssociatedObject(self, &UIButton_badgeTextColorKey);
}
-(void)setBadgeTextColor:(UIColor *)badgeTextColor
{
    objc_setAssociatedObject(self, &UIButton_badgeTextColorKey, badgeTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self refreshBadge];
    }
}

-(UIFont *)badgeFont {
    return objc_getAssociatedObject(self, &UIButton_badgeFontKey);
}
-(void)setBadgeFont:(UIFont *)badgeFont
{
    objc_setAssociatedObject(self, &UIButton_badgeFontKey, badgeFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self refreshBadge];
    }
}

-(CGFloat) badgePadding {
    NSNumber *number = objc_getAssociatedObject(self, &UIButton_badgePaddingKey);
    return number.floatValue;
}
-(void) setBadgePadding:(CGFloat)badgePadding
{
    NSNumber *number = [NSNumber numberWithDouble:badgePadding];
    objc_setAssociatedObject(self, &UIButton_badgePaddingKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self updateBadgeFrame];
    }
}

-(CGFloat) badgeMinSize {
    NSNumber *number = objc_getAssociatedObject(self, &UIButton_badgeMinSizeKey);
    return number.floatValue;
}
-(void) setBadgeMinSize:(CGFloat)badgeMinSize
{
    NSNumber *number = [NSNumber numberWithDouble:badgeMinSize];
    objc_setAssociatedObject(self, &UIButton_badgeMinSizeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self updateBadgeFrame];
    }
}


-(CGFloat) badgeOriginX {
    NSNumber *number = objc_getAssociatedObject(self, &UIButton_badgeOriginXKey);
    return number.floatValue;
}
-(void) setBadgeOriginX:(CGFloat)badgeOriginX
{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginX];
    objc_setAssociatedObject(self, &UIButton_badgeOriginXKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self updateBadgeFrame];
    }
}

-(CGFloat) badgeOriginY {
    NSNumber *number = objc_getAssociatedObject(self, &UIButton_badgeOriginYKey);
    return number.floatValue;
}
-(void) setBadgeOriginY:(CGFloat)badgeOriginY
{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginY];
    objc_setAssociatedObject(self, &UIButton_badgeOriginYKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self updateBadgeFrame];
    }
}

-(BOOL) shouldHideBadgeAtZero {
    NSNumber *number = objc_getAssociatedObject(self, &UIButton_shouldHideBadgeAtZeroKey);
    return number.boolValue;
}
- (void)setShouldHideBadgeAtZero:(BOOL)shouldHideBadgeAtZero
{
    NSNumber *number = [NSNumber numberWithBool:shouldHideBadgeAtZero];
    objc_setAssociatedObject(self, &UIButton_shouldHideBadgeAtZeroKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL) shouldAnimateBadge {
    NSNumber *number = objc_getAssociatedObject(self, &UIButton_shouldAnimateBadgeKey);
    return number.boolValue;
}
- (void)setShouldAnimateBadge:(BOOL)shouldAnimateBadge
{
    NSNumber *number = [NSNumber numberWithBool:shouldAnimateBadge];
    objc_setAssociatedObject(self, &UIButton_shouldAnimateBadgeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (UIEdgeInsets)clickEdgeInsets
{
    return [objc_getAssociatedObject(self, @selector(clickEdgeInsets)) UIEdgeInsetsValue];
}

- (void)setClickEdgeInsets:(UIEdgeInsets)clickEdgeInsets
{
    objc_setAssociatedObject(self, @selector(clickEdgeInsets), [NSValue valueWithUIEdgeInsets:clickEdgeInsets], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    if (UIEdgeInsetsEqualToEdgeInsets(self.clickEdgeInsets, UIEdgeInsetsZero))
    {
        return [super pointInside:point withEvent:event];
    }
    else
    {
        CGRect large = UIEdgeInsetsInsetRect(self.bounds, self.clickEdgeInsets);
        return CGRectContainsPoint(large, point) ? YES : NO;
    }
}


#pragma mark - button倒计时
- (void)fm_countdownTime:(NSInteger)timeLine normalTitle:(NSString *)normalTitle countdownSubtitle:(NSString *)countdownSubtitle normalColor:(UIColor *)normalColor countdownColor:(UIColor *)countdownColor isFlashing:(BOOL)isFlashing {
    [self fm_countdownTime:timeLine normalTitle:normalTitle countNumBeforeTitle:nil countNumBehindTitle:countdownSubtitle normalColor:normalColor countdownColor:countdownColor isFlashing:isFlashing cuntingEnabled:NO waitBlock:^(NSInteger remainTime) {
        
    } finishBlock:^{
        
    }];
}


- (void)fm_countdownTime:(NSInteger)timeLine normalTitle:(NSString *)normalTitle countNumBeforeTitle:(NSString *)beforeTitle countNumBehindTitle:(NSString *)behindTitle normalColor:(UIColor *)normalColor countdownColor:(UIColor *)countdownColor isFlashing:(BOOL)isFlashing cuntingEnabled:(BOOL)cuntingEnabled waitBlock:(void(^)(NSInteger remainTime))waitBlock finishBlock:(void(^)(void))finishBlock {
    __weak __typeof(self)weakSelf = self;
   
    //倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0, 0, queue);
    //每秒执行一次
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL,0), 1.0 * NSEC_PER_SEC,0);
    dispatch_source_set_event_handler(_timer, ^{
        
        //倒计时结束，关闭
        if (timeOut == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (normalColor)   [self setTitleColor:normalColor forState:0];
                [self setTitle:normalTitle forState:UIControlStateNormal];
                self.userInteractionEnabled =YES;
                dispatch_source_cancel(_timer);
                if (timeLine <= 0) {
                    return;
                }
                if (finishBlock) {
                    finishBlock();
                }
            });
        } else {
            NSInteger minutes = timeOut / 60;
            NSInteger seconds = ((timeOut == timeLine) && timeOut<=60) ? timeOut: (timeOut % 60);
            NSString *timeStr = [NSString stringWithFormat:@"%02ld", seconds];
            if (minutes) {
                timeStr = [NSString stringWithFormat:@"%02ld:%02ld", minutes,seconds];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if (countdownColor)  [self setTitleColor:countdownColor forState:0];
                NSString *obstr = [NSString stringWithFormat:@"%@%@%@",(beforeTitle.length ? beforeTitle : @""),timeStr,(behindTitle.length ? behindTitle : @"")];
                if (!isFlashing) {
                    self.titleLabel.text = obstr ;
                }
                [self setTitle:obstr forState:UIControlStateNormal];
              
                if (cuntingEnabled) {
                    self.userInteractionEnabled = YES;
                }else{
                    self.userInteractionEnabled =NO;
                }
            });
            timeOut--;
            if (waitBlock && timeOut) {
                waitBlock(timeOut);
            }
            
            weakSelf.closeBlock = ^(id objc) {
                dispatch_source_cancel(_timer);
                dispatch_async(dispatch_get_main_queue(), ^{
//                    if (normalColor)  weakSelf.backgroundColor = normalColor;
                    [weakSelf setTitle:normalTitle forState:UIControlStateNormal];
                    weakSelf.userInteractionEnabled =YES;
                });
            };
        }
    });
    dispatch_resume(_timer);
}


-(void)setSelecedColor:(UIColor *)selecedColor {
    if (selecedColor) {
        [self setTitleColor:selecedColor forState:UIControlStateSelected];
    }
}

-(void)setSelecedBgImage:(UIImage *)selecedBgImage {
    if (selecedBgImage) {
        [self setBackgroundImage:selecedBgImage forState:UIControlStateSelected];
    }
}

@end
