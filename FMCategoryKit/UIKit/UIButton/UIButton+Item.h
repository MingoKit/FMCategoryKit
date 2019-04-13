//
//  UIButton+Item.h
//  MobileProject
//
//  Created by 刘世玉 on 2017/3/28.
//  Copyright © 2017年 Mingoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Item)
+(UIButton *)CreateCoustemBtn:(NSString*)title Image:(NSString*)imageName;
+(UIButton *)CreateCellCoustemBtn:(NSString *)title Image:(NSString *)imageName;
@end
