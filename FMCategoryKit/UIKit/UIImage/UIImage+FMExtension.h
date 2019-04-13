//
//  UIImage+FMExtension.h
//  FSZX
//
//  Created by Mingo on 2017/4/20.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (FMExtension)

/** /获取视频的第一帧截图, 返回UIImage */
+ (UIImage*)fm_getVideoPreViewImageWithPath:(NSString *)videoPath;


/** videoURL:本地视频路径    time：用来控制视频播放的时间点图片截取 */
+ (UIImage*)fm_thumbnailImageForVideo:(NSString *)videoURL atTime:(NSTimeInterval)time;

+ (UIImage *)fm_imageWithColor:(UIColor *)color;


/* *  @brief 对图片进行滤镜处理 */
+ (UIImage *)fm_filterWithOriginalImage:(UIImage *)image filterName:(NSString *)name;

/**  @brief 对图片进行模糊处理 */
+ (UIImage *)fm_blurWithOriginalImage:(UIImage *)image blurName:(NSString *)name radius:(NSInteger)radius;

/**  @brief 调整图片饱和度, 亮度, 对比度
 *  @param image      目标图片
 *  @param saturation 饱和度
 *  @param brightness 亮度: -1.0 ~ 1.0
 *  @param contrast   对比度
 *
 */
+ (UIImage *)fm_colorControlsWithOriginalImage:(UIImage *)image saturation:(CGFloat)saturation brightness:(CGFloat)brightness contrast:(CGFloat)contrast;

/**  @brief 全屏截图 */
+ (UIImage *)fm_shotScreen;

/**  @brief 截取view生成一张图片 */
+ (UIImage *)fm_shotWithView:(UIView *)view;

/**  @brief 截取view中某个区域生成一张图片 */
+ (UIImage *)fm_shotWithView:(UIView *)view scope:(CGRect)scope;

/**  @brief 压缩图片到指定尺寸大小 */
+ (UIImage *)fm_compressOriginalImage:(UIImage *)image toSize:(CGSize)size;

/**  @brief 压缩图片到指定文件大小 */
+ (NSData *)fm_compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size;

/** 返回圆形图片 */
+ (instancetype)fm_circleImage:(UIImage *)objIma;

/** 直接根据image name 新建 image 并 设置圆角 */
+(instancetype)fm_circleImageNamed:(NSString *)name;

/** image 高效设置圆角 */
+ (UIImage *)fm_imageWithCornerRadius:(CGFloat)radius objImage:(UIImage *)objIma;

/** UIColor生成UIImage上圆下方 */
+ (UIImage *)fm_createImageWithColor:(UIColor *)color topLeftAndRightCornerRadius:(CGFloat)cornerRadius;

/// UIColor生成UIImage 不带圆角 cornerRadius == 0
+ (UIImage *)fm_createImageWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius;

/// 高斯模糊 将页面图像转化为模糊的image
+ (UIImage *)fm_blurryImage:(UIView *)view withBlurLevel:(CGFloat)blur;

/// 根据文字内容生成二维码
+ (UIImage *)fm_createQRCodeFromString:(NSString *)string;
@end
