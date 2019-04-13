//
//  UIImage+FMForUrlImaSize.h
//  MobileProject
//
//  Created by Mingo on 2018/2/7.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (FMForUrlImaSize)
#pragma mark -  根据图片url获取图片尺寸
+ (CGSize)fm_getImageSizeWithURL:(id)urlString;

+ (CGSize)fm_getImageSizeUrl:(id)urlString;

@end
