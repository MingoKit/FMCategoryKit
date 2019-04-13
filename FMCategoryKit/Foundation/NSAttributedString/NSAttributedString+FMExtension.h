//
//  NSAttributedString+FMExtension.h
//  FupingElectricity
//
//  Created by mingo on 2019/1/11.
//  Copyright © 2019年 Fleeming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (FMExtension)

/**
 富文本多颜色字符

 @param str 富文本多颜色字符
 @param arrOrOneColor 颜色数组 或者 制定一个颜色
 @param titleArr 需要更换颜色的所以字符数组
 @return NSAttributedString
 */
-(NSAttributedString *)fm_setString:(NSString *)str arrOrOneColor:(id )arrOrOneColor titleArr:(NSMutableArray *)titleArr;
@end
