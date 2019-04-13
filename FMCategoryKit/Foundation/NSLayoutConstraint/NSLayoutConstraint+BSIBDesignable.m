//
//  NSLayoutConstraint+BSIBDesignable.m
//  FupingElectricity
//
//  Created by mingo on 2019/3/4.
//  Copyright © 2019年 Fleeming. All rights reserved.
//

#import "NSLayoutConstraint+BSIBDesignable.h"
#import <objc/runtime.h>

// 基准屏幕宽度
// 以屏幕宽度为固定比例关系，来计算对应的值。假设：基准屏幕宽度375，floatV=10；当前屏幕宽度为750时，那么返回的值为20
#define AdaptW(floatValue) (floatValue*[[UIScreen mainScreen] bounds].size.width/375.0)
#define AdaptH(floatValue) (floatValue*[[UIScreen mainScreen] bounds].size.height/667.0)


@implementation NSLayoutConstraint (BSIBDesignable)

//定义常量 必须是C语言字符串
static char *AdapterScreenKeyW = "AdapterScreenKeyW";
static char *AdapterScreenKeyH = "AdapterScreenKeyH";

- (BOOL)adapt_w{
    NSNumber *number = objc_getAssociatedObject(self, AdapterScreenKeyW);
    return number.boolValue;
}

-(void)setAdapt_w:(BOOL)adapt_w {
    NSNumber *number = @(adapt_w);
    objc_setAssociatedObject(self, AdapterScreenKeyW, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (adapt_w){
        self.constant = AdaptW(self.constant);
    }
}

- (BOOL)adapt_h{
    NSNumber *number = objc_getAssociatedObject(self, AdapterScreenKeyH);
    return number.boolValue;
}

-(void)setAdapt_h:(BOOL)adapt_h {
    NSNumber *number = @(adapt_h);
    objc_setAssociatedObject(self, AdapterScreenKeyH, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (adapt_h){
        self.constant = AdaptH(self.constant);
    }
}


@end
