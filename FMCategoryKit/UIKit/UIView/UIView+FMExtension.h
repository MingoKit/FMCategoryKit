//
//  UIView+FMExtension.h
//  MobileProject
//
//  Created by Mingo on 2017/9/1.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>

static char *viewClickKey;
typedef void(^UIViewClickHandle)(UIView *view);

@interface UIView (FMExtension)
/**
 *  @brief  找到当前view所在的viewcontroler
 */
@property (readonly) UIViewController *viewController;

/**  增加UIView的点击事件 */
-(void)handleClick:(UIViewClickHandle)handle;

//获取view所在的ViewController
- (UIViewController *)viewController;

//获取view所在的ViewController的name
- (NSString *)viewControllerName;

//通过名称获取nib
+ (UINib *)nibWithName:(NSString *)name;

//通过NIb名称获取内部View视图集合
+ (NSArray *)viewsWithNibName:(NSString *)name;

//设置圆角 (圆角大小 圆角宽度 圆角颜色)
- (void)setCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
- (void)removeAllSubviews;
/// view加虚线边框
-(void)fm_addBottedlineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor;
@end
