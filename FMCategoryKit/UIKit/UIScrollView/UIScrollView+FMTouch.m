//
//  UIScrollView+FMTouch.m
//  MobileProject
//
//  Created by Mingo on 2017/8/7.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "UIScrollView+FMTouch.h"

@implementation UIScrollView (FMTouch)

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 选其一即可
    [super touchesBegan:touches withEvent:event];
    //  [[self nextResponder] touchesBegan:touches withEvent:event];
}

@end
