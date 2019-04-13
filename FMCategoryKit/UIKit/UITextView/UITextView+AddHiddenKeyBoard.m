//
//  UITextView+AddHiddenKeyBoard.m
//  LaiCai
//
//  Created by yuyong on 16/1/29.
//  Copyright © 2016年 laicaijie.laicai. All rights reserved.
//

#import "UITextView+AddHiddenKeyBoard.h"

@implementation UITextView (AddHiddenKeyBoard)
#define kScreenW ([UIScreen mainScreen].bounds.size.width)
#define kScreenH ([UIScreen mainScreen].bounds.size.hight)

- (void)AddHiddenButton
{
    //设置隐藏键盘按钮
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(30,30),NO,0);
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, 2);
    CGContextMoveToPoint(context, 5, 7);
    CGContextAddLineToPoint(context, 15, 18);
    CGContextAddLineToPoint(context, 25, 7);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextStrokePath(context);
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIButton *hiddenButton = [UIButton buttonWithType:UIButtonTypeCustom];
    hiddenButton.layer.masksToBounds=YES;
    hiddenButton.layer.cornerRadius = 5.0f;
    [hiddenButton setImage:image forState:UIControlStateNormal];
    [hiddenButton setBackgroundColor:[UIColor colorWithRed:189/255.0f green:192/255.0f blue:197/255.0f alpha:1.0f]];
    [hiddenButton setFrame:CGRectMake(kScreenW - 64, 0 , 55.0f, 35.0f)];
    [hiddenButton addTarget:self action:@selector(hiddenKeyboard) forControlEvents:UIControlEventTouchUpInside];
    if([[[UIDevice currentDevice] systemVersion] doubleValue] <= 5.2) {
        hiddenButton.layer.borderWidth=1.0f;
    }
    UIView * inputAccessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , kScreenW, 30.0f)];
    [inputAccessoryView addSubview:hiddenButton];
    inputAccessoryView.clipsToBounds = YES;
    self.inputAccessoryView = inputAccessoryView;
}


- (void)hiddenKeyboard
{
    [self resignFirstResponder];
}

@end
