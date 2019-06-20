//
//  UIView+Frame.h
//  iOS-Categories (https://github.com/shaojiankui/iOS-Categories)
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

CGPoint fm_CGRectGetCenter(CGRect rect);
CGRect  fm_CGRectMoveToCenter(CGRect rect, CGPoint center);
double fm_radians(float degrees);
CATransform3D fm_getTransForm3DWithAngle(CGFloat angle);
CATransform3D fm_getTransForm3DWithAngle_r(CGFloat angle);
CATransform3D fm_getTransForm3DWithScale(CGFloat scale);

@interface UIView (Frame)

@property (nonatomic ,assign) CGFloat x;
@property (nonatomic ,assign) CGFloat y;

// shortcuts for frame properties
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;

// shortcuts for positions
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;



@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat left;

@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic,readonly) CGPoint bottomLeft;
@property (nonatomic,readonly) CGPoint bottomRight;
@property (nonatomic,readonly) CGPoint topRight;
- (void)fm_moveBy: (CGPoint) delta;
- (void)fm_scaleBy: (CGFloat) scaleFactor;
- (void)fm_fitInSize: (CGSize) aSize;
///  视图转成图片
- (UIImage *)fm_convertViewToImage;

@end
