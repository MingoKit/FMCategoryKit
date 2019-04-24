//
//  UIButton+FMForClickDelay.h
//
//  Created by mingo on 2018/8/23.
//  Copyright © 2018年 mingo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (FMForClickDelay)
/**
 *  为按钮添加点击间隔 eventTimeInterval秒
 */
@property (nonatomic, assign) NSTimeInterval eventTimeInterval;
@end
