//
//  NSString+File.m
//  黑马微博
//
//  Created by apple on 14-7-25.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "NSString+File.h"
#import <CommonCrypto/CommonDigest.h>
#define kScreenW ([UIScreen mainScreen].bounds.size.width)
#define kScreenH ([UIScreen mainScreen].bounds.size.hight)


@implementation NSString (File)
- (long long)fileSize
{
    // 1.文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 2.判断file是否存在
    BOOL isDirectory = NO;
    BOOL fileExists = [mgr fileExistsAtPath:self isDirectory:&isDirectory];
    // 文件\文件夹不存在
    if (fileExists == NO) return 0;
    
    // 3.判断file是否为文件夹
    if (isDirectory) { // 是文件夹
        NSArray *subpaths = [mgr contentsOfDirectoryAtPath:self error:nil];
        long long totalSize = 0;
        for (NSString *subpath in subpaths) {
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            totalSize += [fullSubpath fileSize];
        }
        return totalSize;
    } else { // 不是文件夹, 文件
        // 直接计算当前文件的尺寸
        NSDictionary *attr = [mgr attributesOfItemAtPath:self error:nil];
        return [attr[NSFileSize] longLongValue];
    }
}

-(CGSize)textSizeWith:(UIFont *)font contentSize:(CGSize)size{
    NSDictionary *attribute = @{NSFontAttributeName : font};

    if (CGSizeEqualToSize(size, CGSizeZero)) {
        size = CGSizeMake(kScreenW, CGFLOAT_MAX);
    }
    //ios 9 出现的bug  提供参考的size的宽度 不能是lable的宽度,
    CGSize textSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading  attributes:attribute context:nil].size;
    
    return textSize;
}

-(CGSize)textSizeAttributes:(NSDictionary *)attribute contentSize:(CGSize)size;{
    
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        size = CGSizeMake(kScreenW, CGFLOAT_MAX);
    }
    //ios 9 出现的bug  提供参考的size的宽度 不能是lable的宽度,
    CGSize textSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading  attributes:attribute context:nil].size;
    
    return textSize;
}

+ (NSString *)convertTime:(CGFloat)second{
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [formatter setTimeZone:timeZone];
    if (second/3600 >= 1) {
        [formatter setDateFormat:@"H:mm:ss"];
    } else {
        [formatter setDateFormat:@"mm:ss"];
    }
    NSString *showtimeNew = [formatter stringFromDate:d];
    return showtimeNew;
}
- (BOOL)includeChinese
{
    for(int i=0; i< [self length];i++)
    {
        int a =[self characterAtIndex:i];
        if( a >0x4e00&& a <0x9fff){
            return YES;
        }
    }
    return NO;
}
-(NSString *)md5Str{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+ (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *mobileNoRegex = @"^1((3\\d|5[0-35-9]|8[025-9])\\d|70[059])\\d{7}$";
    
    NSString *phsRegex =@"^0(10|2[0-57-9]|\\d{3})\\d{7,8}$";
    
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",mobileNoRegex];
    BOOL ret = [pre evaluateWithObject:mobile];
    
    NSPredicate *pre2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phsRegex];
    BOOL ret1 = [pre2 evaluateWithObject:mobile];
    
    return (ret || ret1);
}

+ (CGSize )fm_getTextMaxWidth:(UIFont *)titleFont titleHeight:(CGFloat)titleHeight mainText:(NSString *)text {
    NSDictionary *attrs = @{NSFontAttributeName : titleFont};
    CGSize maxSize = CGSizeMake(MAXFLOAT,titleHeight );
    CGSize size = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    return size;
}

+ (CGFloat )fm_getTextMaxHeight:(UIFont *)titleFont titleWidth:(CGFloat)titleWidth mainText:(NSString *)text {
    NSDictionary *attrs = @{NSFontAttributeName : titleFont};
    CGSize maxSize = CGSizeMake(titleWidth,MAXFLOAT);
    CGSize size = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    return size.height;
}

@end
