//
//  NSMutableArray+FMAdd.m
//  Pods
//
//  Created by mingo on 2019/12/25.
//

#import "NSMutableArray+FMAdd.h"


@implementation NSMutableArray (FMAdd)
- (NSString *)fm_appendingSemicolonForAllItems {
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
            endstr = [endstr stringByAppendingString:[NSString stringWithFormat:@","]];
        }
    }
    return endstr;
}
@end
