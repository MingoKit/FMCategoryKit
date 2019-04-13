//
//  NSString+File.h
//  黑马微博
//
//  Created by apple on 14-7-25.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (File)
- (long long)fileSize;

-(CGSize)textSizeWith:(UIFont *)font contentSize:(CGSize)size;
-(CGSize)textSizeAttributes:(NSDictionary *)attribute contentSize:(CGSize)size;
+ (NSString *)convertTime:(CGFloat)second;
-(NSString *)md5Str;
- (BOOL)includeChinese;
+ (BOOL) validateMobile:(NSString *)mobile;
/// 获取一段文字的最大宽度
+ (CGSize )fm_getTextMaxWidth:(UIFont *)titleFont titleHeight:(CGFloat)titleHeight mainText:(NSString *)text;
+ (CGFloat )fm_getTextMaxHeight:(UIFont *)titleFont titleWidth:(CGFloat)titleWidth mainText:(NSString *)text ;

@end
