//
//  UIViewController+FMAdd.h
//  FMCategoryKit
//
//  Created by mingo on 2019/4/13.
//

#import <UIKit/UIKit.h>

@interface UIViewController (FMAdd)
#pragma mark - 获取当前屏幕显示的VC
+ (UIViewController *)fm_getCurrentViewController;
@end
