//
//  UIButton+Item.m
//  MobileProject
//
//  Created by 刘世玉 on 2017/3/28.
//  Copyright © 2017年 Mingoy. All rights reserved.
//

#import "UIButton+Item.h"

@implementation UIButton (Item)
+(UIButton *)CreateCoustemBtn:(NSString *)title Image:(NSString *)imageName
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 30, 30);
//    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
//    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5);
//    btn.titleLabel.font= [UIFont systemFontOfSize:16.0f];
    return btn;
}
+(UIButton *)CreateCellCoustemBtn:(NSString *)title Image:(NSString *)imageName
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 20, 10);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 18);
    btn.titleLabel.font= [UIFont systemFontOfSize:19.0f];
    return btn;
}
@end
