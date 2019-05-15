//
//  NSArray+FMExtension.m
//  MobileProject
//
//  Created by Mingo on 2017/7/5.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "NSArray+FMExtension.h"

@implementation NSArray (FMExtension)

#pragma mark - 字符串按多个符号分割
+ (NSArray *)fm_componentsSeparatedMainString:(NSString *)string ByCharactersInSetString:(NSString *)setString{
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:setString];
    NSArray *arr = [string componentsSeparatedByCharactersInSet:set];
    return arr;
}

#pragma mark - 取两个数组并集集和返回新数组
// eg:array1 =  @[@"1",@"2",@"3"],array2 =@[@"5",@"1",@"6"]。//取并集后 set1中为1，2，3，5，6
+ (NSArray *)fm_getUnionSetArray:(NSArray *)aArray withOtherArray:(NSArray *)bArray returnArrayWithAscending:(BOOL)ascending {

    NSMutableSet *set1 = [NSMutableSet setWithArray:aArray];
    NSMutableSet *set2 = [NSMutableSet setWithArray:bArray];
    [set1 unionSet:set2];       //类如示例：取并集后 set1中为1，2，3，5，6
    NSArray *sortDesc = @[[[NSSortDescriptor alloc] initWithKey:nil ascending:ascending]];
    NSArray *sortSetArray = [set1 sortedArrayUsingDescriptors:sortDesc];
    return sortSetArray;
}

#pragma mark - 取两个数组交集集和返回新数组
// eg:array1 =  @[@"1",@"2",@"3"],array2 =@[@"5",@"1",@"6"]。//取交集后 set1中为1
+ (NSArray *)fm_getIntersectSetArray:(NSArray *)aArray withOtherArray:(NSArray *)bArray returnArrayWithAscending:(BOOL)ascending {
    
    NSMutableSet *set1 = [NSMutableSet setWithArray:aArray];
    NSMutableSet *set2 = [NSMutableSet setWithArray:bArray];
    [set1 intersectSet:set2];  //类如示例：取交集后 set1中为1
    NSArray *sortDesc = @[[[NSSortDescriptor alloc] initWithKey:nil ascending:ascending]];
    NSArray *sortSetArray = [set1 sortedArrayUsingDescriptors:sortDesc];
    return sortSetArray;
}

#pragma mark - 取两个数组差集集和返回新数组
// eg:array1 =  @[@"1",@"2",@"3"],array2 =@[@"5",@"1",@"6"]。//取交集后 set1中为2，3，5，6
+ (NSArray *)fm_getMinusSetArray:(NSArray *)aArray withOtherArray:(NSArray *)bArray returnArrayWithAscending:(BOOL)ascending {
    
    NSMutableSet *set1 = [NSMutableSet setWithArray:aArray];
    NSMutableSet *set2 = [NSMutableSet setWithArray:bArray];
    [set1 minusSet:set2];      //类如示例：取差集后 set1中为2，3，5，6
    NSArray *sortDesc = @[[[NSSortDescriptor alloc] initWithKey:nil ascending:ascending]];
    NSArray *sortSetArray = [set1 sortedArrayUsingDescriptors:sortDesc];
    return sortSetArray;
}


@end
