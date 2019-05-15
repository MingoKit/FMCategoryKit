//
//  NSNumber+FMExtension.m
//  MobileProject
//
//  Created by Mingo on 2017/9/1.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "NSNumber+FMExtension.h"

static NSNumberFormatter *numberFormatter = nil;

@implementation NSNumber (FMExtension)

+ (NSNumber *)fm_numberWithString:(NSString *)string {
    if(numberFormatter == nil) {
        numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    }
    
    if (string) {
        @try {
            return [numberFormatter numberFromString:string];
        }
        @catch (NSException * e) {
            NSLog(@"NSNumberFormatter exception! parsing: %@", string);
        }
    }
    return nil;
}

#pragma mark - 判断NSNumber中存的到底是什么基本数据类型【int，float，double，BOOL】
+ (void)fm_valueTypeInNSNumber:(NSNumber *)value {

    if([value isKindOfClass:[NSNumber class]]){
        const char * pObjCType = [((NSNumber*)value) objCType];
        if (strcmp(pObjCType, @encode(int))  == 0) {
            NSLog(@"值是int类型,值为%d",[value intValue]);
        }
        if (strcmp(pObjCType, @encode(float)) == 0) {
            NSLog(@"值是float类型,值为%f",[value floatValue]);
        }
        if (strcmp(pObjCType, @encode(double))  == 0) {
            NSLog(@"值是double类型,值为%f",[value doubleValue]);
        }
        if (strcmp(pObjCType, @encode(BOOL)) == 0) {
            NSLog(@"值是bool类型,值为%i",[value boolValue]);
        }
    }
}


- (NSString *)romanNumeral
{
    NSInteger n = [self integerValue];
    
    NSArray *numerals = [NSArray arrayWithObjects:@"M", @"CM", @"D", @"CD", @"C", @"XC", @"L", @"XL", @"X", @"IX", @"V", @"IV", @"I", nil];
    
    NSUInteger valueCount = 13;
    NSUInteger values[] = {1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1};
    
    NSMutableString *numeralString = [NSMutableString string];
    
    for (NSUInteger i = 0; i < valueCount; i++)
    {
        while (n >= values[i])
        {
            n -= values[i];
            [numeralString appendString:[numerals objectAtIndex:i]];
        }
    }
    return numeralString;
}



#pragma mark - Display
- (NSString*)toDisplayNumberWithDigit:(NSInteger)digit
{
    NSString *result = nil;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    [formatter setMaximumFractionDigits:digit];
    result = [formatter  stringFromNumber:self];
    if (result == nil)
        return @"";
    return result;
    
}

- (NSString*)toDisplayPercentageWithDigit:(NSInteger)digit
{
    NSString *result = nil;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterPercentStyle];
    [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    [formatter setMaximumFractionDigits:digit];
    result = [formatter  stringFromNumber:self];
    return result;
}

#pragma mark - round, ceil, floor
- (NSNumber*)doRoundWithDigit:(NSUInteger)digit
{
    NSNumber *result = nil;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    [formatter setMaximumFractionDigits:digit];
    [formatter setMinimumFractionDigits:digit];
    result = [NSNumber numberWithDouble:[[formatter  stringFromNumber:self] doubleValue]];
    return result;
}


- (NSNumber*)doCeilWithDigit:(NSUInteger)digit
{
    NSNumber *result = nil;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setRoundingMode:NSNumberFormatterRoundCeiling];
    [formatter setMaximumFractionDigits:digit];
    result = [NSNumber numberWithDouble:[[formatter  stringFromNumber:self] doubleValue]];
    return result;
}

- (NSNumber*)doFloorWithDigit:(NSUInteger)digit
{
    NSNumber *result = nil;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setRoundingMode:NSNumberFormatterRoundFloor];
    [formatter setMaximumFractionDigits:digit];
    result = [NSNumber numberWithDouble:[[formatter  stringFromNumber:self] doubleValue]];
    return result;
}

@end
