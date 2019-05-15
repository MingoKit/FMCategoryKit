//
//  NSArray+FMExtension.h
//  MobileProject
//
//  Created by Mingo on 2017/7/5.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (FMExtension)

/**  字符串按多个符号分割 &&param Mainstring 要分隔的字符 &setString 按照当前字符集分隔  【例如：@“ABC,DOF.UG”和@“,.”】
 *  @param string 要分隔的字符
 *  @param setString 按照当前字符集分隔 */
+ (NSArray *)fm_componentsSeparatedMainString:(NSString *)string ByCharactersInSetString:(NSString *)setString;

/// 取两个数组并集集和返回新数组 ascending:结果是否升序排序 eg:array1 =  @[@"1",@"2",@"3"],array2 =@[@"5",@"1",@"6"]。//取并集后 set1中为1，2，3，5，6
+ (NSArray *)fm_getUnionSetArray:(NSArray *)aArray withOtherArray:(NSArray *)bArray returnArrayWithAscending:(BOOL)ascending;

/// 取两个数组交集集和返回新数组 ascending:结果是否升序排序 eg:array1 =  @[@"1",@"2",@"3"],array2 =@[@"5",@"1",@"6"]。//取交集后 set1中为1
+ (NSArray *)fm_getIntersectSetArray:(NSArray *)aArray withOtherArray:(NSArray *)bArray returnArrayWithAscending:(BOOL)ascending;

///  取两个数组差集集和返回新数组 ascending:结果是否升序排序 eg:array1 =  @[@"1",@"2",@"3"],array2 =@[@"5",@"1",@"6"]。//取交集后 set1中为2，3，5，6
+ (NSArray *)fm_getMinusSetArray:(NSArray *)aArray withOtherArray:(NSArray *)bArray returnArrayWithAscending:(BOOL)ascending;


@end
