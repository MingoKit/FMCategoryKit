//
//  NSDictionary+FMExtension.m
//  MobileProject
//
//  Created by Mingo on 2017/6/7.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "NSDictionary+FMExtension.h"

@implementation NSDictionary (FMExtension)


#pragma mark - 将Get Post请求URL中得参数转化成字典
+ (NSDictionary*)fm_getURLParameter:(NSString*)urlString{
    if (urlString.length == 0) {
        return  nil;
    }
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    NSArray *urlArray = [urlString componentsSeparatedByString:@"?"];
    
    if (urlArray.count > 1) {   //如果大于1，认为有参数
        NSString *URLParString = [urlArray lastObject];
        
        if ([URLParString rangeOfString:@"&"].location != NSNotFound) { //多个参数
            NSArray *dictArray = [URLParString componentsSeparatedByString:@"&"];
            for (NSString *KVString in dictArray) {
                NSArray *KVArray = [KVString componentsSeparatedByString:@"="];
                for (int i = 0; i < KVArray.count; i++) {
                    if (i == KVArray.count - 1) {
                        [dict setValue:KVArray[i] forKey:KVArray[i - 1]];
                    }
                }
            }
        }else if ([URLParString rangeOfString:@"="].location != NSNotFound){ //单个参数
            NSArray *dictArray = [URLParString componentsSeparatedByString:@"="];
            for (int i = 0; i < dictArray.count; i++) {
                if (i == dictArray.count - 1) {
                    [dict setValue:dictArray[i] forKey:dictArray[i - 1]];
                }
            }
        }
    }
    
    return dict;
}

#pragma mark - json格式字符串转字典
/*  json格式字符串转字典
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 */
+ (NSDictionary *)fm_dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) return nil;
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData  options:NSJSONReadingMutableContainers error:&err];
    
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+ (NSDictionary *) fm_dictionaryValueFromJsonString:(NSString *)jsonString {
    NSError *errorJson;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&errorJson];
    if (errorJson != nil) {
#ifdef DEBUG
        NSLog(@"fail to get dictioanry from JSON: %@, error: %@", self, errorJson);
#endif
    }
    return jsonDict;
}

@end
