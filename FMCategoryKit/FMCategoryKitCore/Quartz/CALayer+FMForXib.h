//
//  CALayer+FMForXib.h
//
//  Created by mingo on 2018/8/30.
//  Copyright © 2018年 mingo. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer (FMForXib)
/// borderColor
@property(nonatomic, assign) UIColor *bColor;
/// borderWidth
@property(nonatomic, assign) CGFloat bWidth;

/// cornerRadius
@property(nonatomic, assign) CGFloat round;

/// cornerRadius
@property(nonatomic, assign) CGFloat cr;

/// shadowColor
@property(nonatomic, assign) UIColor *sColor;
/// shadowOpacity
@property(nonatomic, assign) CGFloat sOp;
/// shadowOffset
@property(nonatomic, assign) CGSize sOffset;

@property(nonatomic, strong) UIColor *sc;
@property(nonatomic, strong) UIColor *bc;

@end
