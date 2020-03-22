//
//  NSMutableArray+FMAdd.h
//  Pods
//
//  Created by mingo on 2019/12/25.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (FMAdd)
    /// 用 输入的 “字符” 拼接每一个字符串数组里面的元素，末尾不拼接
- (NSString *)fm_appendingAllItemsWith:(NSString *)str;

    /// 用“,”拼接每个一个字符串数组里面的元素，末尾不拼接
- (NSString *)fm_appendingSemicolonForAllItems;
    /// 数组转json字符串
- (NSString *)fm_arrToJsonString;
@end

NS_ASSUME_NONNULL_END
