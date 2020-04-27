//
//  UIImageView+FMExtension.m
//  MingoKit
//
//  Created by Mingo on 16/10/16.
//  Copyright © 2016年 袁凤鸣. All rights reserved.
//

#import "UIImageView+FMExtension.h"
#import "UIImage+FMExtension.h"
//#import <UIImageView+WebCache.h>
//#import <Masonry.h>

@implementation UIImageView (FMExtension)

#pragma mark - 快速创建UIImageView
+ (UIImageView *)fm_initUIImageViewWithName:(NSString *)name ifHasPlaceholderImageName:(NSString *)placeholderImageName cornerRadius:(CGFloat)radius addTapGestureRecognizer:(id)object tapSel:(SEL)tapSel addToSuperView:(UIView *)superView {

    UIImageView *objView = [[UIImageView alloc] init];
    
    
    UIImage *placeholderImage;
    if (placeholderImageName) {
        placeholderImage = [UIImage imageNamed:placeholderImageName];
    }else {
        placeholderImage = nil;
    }
//    if ([urlOrName hasPrefix:@"http"]) {
//        [objView sd_setImageWithURL:[NSURL URLWithString:urlOrName] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//
//        }];
//    }else {
//        [objView setImage:[UIImage imageNamed:urlOrName]];
//    }
    [objView setImage:[UIImage imageNamed:name]];

    if (radius > 1.0)  objView.layer.cornerRadius = radius;
    [objView setContentMode:UIViewContentModeScaleAspectFill];
    objView.clipsToBounds = YES;
     
    //添加一个点击手势
    if (object && tapSel) {
        objView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:object action:tapSel];
        [objView addGestureRecognizer:tapGesture];
    }
 
    if (superView) [superView addSubview:objView];
 
    return objView;
    
}


#pragma mark - 创建imageView
+ (UIImageView *)fm_createImageView:(CGRect)frame addToSuperView:(UIView *)superView imageName:(NSString *)imageName{

    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    imageView.image = [UIImage imageNamed:imageName];
    [superView addSubview:imageView];
    return imageView;
}


/**
 *  @brief  倒影
 */
- (void)reflect {
    CGRect frame = self.frame;
    frame.origin.y += (frame.size.height + 1);
    
    UIImageView *reflectionImageView = [[UIImageView alloc] initWithFrame:frame];
    self.clipsToBounds = TRUE;
    reflectionImageView.contentMode = self.contentMode;
    [reflectionImageView setImage:self.image];
    reflectionImageView.transform = CGAffineTransformMakeScale(1.0, -1.0);
    
    CALayer *reflectionLayer = [reflectionImageView layer];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.bounds = reflectionLayer.bounds;
    gradientLayer.position = CGPointMake(reflectionLayer.bounds.size.width / 2, reflectionLayer.bounds.size.height * 0.5);
    gradientLayer.colors = [NSArray arrayWithObjects:
                            (id)[[UIColor clearColor] CGColor],
                            (id)[[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.3] CGColor], nil];
    
    gradientLayer.startPoint = CGPointMake(0.5,0.5);
    gradientLayer.endPoint = CGPointMake(0.5,1.0);
    reflectionLayer.mask = gradientLayer;
    
    [self.superview addSubview:reflectionImageView];
    
}

- (void)fm_changeColor:(UIColor *)color {
        //看下面例子，首先对图片进行渲染，其次设置imageView的tintColor即可，
    self.image = [self.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.tintColor = color;
}

@end
