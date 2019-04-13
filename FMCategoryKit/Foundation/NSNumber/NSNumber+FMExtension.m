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

@end
