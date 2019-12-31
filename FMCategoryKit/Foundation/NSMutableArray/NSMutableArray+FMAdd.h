//
//  NSMutableArray+FMAdd.h
//  Pods
//
//  Created by mingo on 2019/12/25.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (FMAdd)
    /// 用“,”拼接每个一个字符串数组里面的元素
- (NSString *)fm_appendingSemicolonForAllItems;
@end

NS_ASSUME_NONNULL_END
