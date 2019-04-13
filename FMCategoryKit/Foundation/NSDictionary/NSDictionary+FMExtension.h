//
//  NSDictionary+FMExtension.h
//  MobileProject
//
//  Created by Mingo on 2017/6/7.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (FMExtension)

/** 将 Get Post 请求URL中得参数转化成字典 */
+ (NSDictionary*)fm_getURLParameter:(NSString*)urlString;

/*!//json格式字符串转字典：
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 */
+ (NSDictionary *)fm_dictionaryWithJsonString:(NSString *)jsonString;
+ (NSDictionary *) fm_dictionaryValueFromJsonString:(NSString *)jsonString;
@end
