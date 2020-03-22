//
//  UIView+FMExtension.m
//  MobileProject
//
//  Created by Mingo on 2017/9/1.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "UIView+FMExtension.h"
#import <objc/runtime.h>


@implementation UIView (FMExtension)

/**
 *  @brief  找到当前view所在的viewcontroler
 */
- (UIViewController *)viewController
{
    UIResponder *responder = self.nextResponder;
    do {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = responder.nextResponder;
    } while (responder);
    return nil;
}

- (NSString *)viewControllerName{
    UIViewController *vc = [self viewController];
    if (vc) {
        return NSStringFromClass([vc class]);
    }
    return nil;
}

+ (UINib *)nibWithName:(NSString *)name {
    return [UINib nibWithNibName:name bundle:nil];
}

+ (NSArray *)viewsWithNibName:(NSString *)name {
    return [[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil];
}

- (void)setCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = borderColor.CGColor;
    self.layer.masksToBounds = YES;
}


- (void)handleClick:(UIViewClickHandle)handle {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewClick)];
    [self addGestureRecognizer:tap];
    objc_setAssociatedObject(self, &viewClickKey, handle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)viewClick {
    UIViewClickHandle callBack = objc_getAssociatedObject(self, &viewClickKey);
    if (callBack!= nil)
    {
        callBack(self);
    }
}

- (void)removeAllSubviews {
    for (UIView *vv in self.subviews) {
        [vv removeFromSuperview];
    }
}

-(void)fm_addBottedlineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor{
    CAShapeLayer *border = [CAShapeLayer layer];
    border.strokeColor = lineColor.CGColor;
    border.fillColor = nil;
    border.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    border.frame = self.bounds;
    border.lineWidth = lineWidth;
    border.lineCap = @"square";
        //设置线宽和线间距
    border.lineDashPattern = @[@10, @5];
    [self.layer addSublayer:border];
}


@end
