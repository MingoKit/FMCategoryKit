//
//  NSMutableArray+FMAdd.m
//  Pods
//
//  Created by mingo on 2019/12/25.
//

#import "NSMutableArray+FMAdd.h"


@implementation NSMutableArray (FMAdd)

- (NSString *)fm_appendingAllItemsWith:(NSString *)str {
    if (!self.count) {
        return @"";
    }
    if (![self.firstObject isKindOfClass:NSString.class]) {
        return @"";
    }
    NSString *endstr = @"";
    for (NSInteger i = 0; i < self.count; i++) {
        NSString *tmp = self[i];
        endstr = [endstr stringByAppendingString:[NSString stringWithFormat:@"%@",tmp]];
        if (i < self.count - 1 ) {
            endstr = [endstr stringByAppendingString:str];
        }
    }
    return endstr;
}

- (NSString *)fm_appendingSemicolonForAllItems {
    return [self fm_appendingAllItemsWith:@","];
}

- (NSString *)fm_arrToJsonString{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    NSString *string =  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return string;
}

@end
