//
//  UINavigationController+FMAdd.m
//  MobileProject
//
//  Created by Mingo on 2017/7/17.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "UINavigationController+FMAdd.h"


@implementation UINavigationController (FMAdd)

#pragma mark - 设置状态栏（通知栏）颜色
- (void)fm_setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}



@end
