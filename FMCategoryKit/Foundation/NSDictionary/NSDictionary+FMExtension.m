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


#pragma mark - 网络模型属性
-(void)fm_createNetProperty{
    NSMutableString *codes=[NSMutableString string];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop) {
        NSString *code;
        if ([value isKindOfClass:[NSString class]]) {
            code=[NSString stringWithFormat:@"@property (nonatomic, copy) NSString *%@;",key];
        }else if ([value isKindOfClass:NSClassFromString(@"__NSCFBoolean")]){
            code=[NSString stringWithFormat:@"@property (nonatomic, copy) BOOL %@;",key];
        }else if ([value isKindOfClass:[NSNumber class]]) {
            code=[NSString stringWithFormat:@"@property (nonatomic, copy) NSNumber *%@;",key];
        }else if ([value isKindOfClass:[NSArray class]]) {
            code=[NSString stringWithFormat:@"@property (nonatomic, copy) NSArray *%@;",key];
        }else if ([value isKindOfClass:[NSDictionary class]]) {
            code=[NSString stringWithFormat:@"@property (nonatomic, copy) NSDictionary *%@;",key];
        }
        [codes appendFormat:@"\n%@\n",code];
    }];
    NSLog(@"%@",codes);
}


#pragma mark - 根据字典key值转模型属性
-(void)fm_createProperty{
    NSMutableString *codes=[NSMutableString string];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop) {
        NSString *code;
        if ([value isKindOfClass:[NSString class]]) {
            code=[NSString stringWithFormat:@"@property (nonatomic, copy) NSString *%@;",key];
        }else if ([value isKindOfClass:NSClassFromString(@"__NSCFBoolean")]){
            code=[NSString stringWithFormat:@"@property (nonatomic, assign) BOOL %@;",key];
        }else if ([value isKindOfClass:[NSNumber class]]) {
            code=[NSString stringWithFormat:@"@property (nonatomic, assign) NSInteger %@;",key];
        }else if ([value isKindOfClass:[NSArray class]]) {
            code=[NSString stringWithFormat:@"@property (nonatomic, strong) NSArray *%@;",key];
        }else if ([value isKindOfClass:[NSDictionary class]]) {
            code=[NSString stringWithFormat:@"@property (nonatomic, strong) NSDictionary *%@;",key];
        }
        [codes appendFormat:@"\n%@\n",code];
    }];
    NSLog(@"%@",codes);
}


+ (NSDictionary *)dictionaryByMerging:(NSDictionary *)dict1 with:(NSDictionary *)dict2
{
    NSMutableDictionary * result = [NSMutableDictionary dictionaryWithDictionary:dict1];
    NSMutableDictionary * resultTemp = [NSMutableDictionary dictionaryWithDictionary:dict1];
    [resultTemp addEntriesFromDictionary:dict2];
    
    [resultTemp enumerateKeysAndObjectsUsingBlock: ^(id key, id obj, BOOL *stop) {
        if ([dict1 objectForKey:key])
        {
            if ([obj isKindOfClass:[NSDictionary class]])
            {
                NSDictionary * newVal = [[dict1 objectForKey: key] dictionaryByMergingWith: (NSDictionary *) obj];
                [result setObject: newVal forKey: key];
            }
            else
            {
                [result setObject: obj forKey: key];
            }
        }
        else if([dict2 objectForKey:key])
        {
            if ([obj isKindOfClass:[NSDictionary class]])
            {
                NSDictionary * newVal = [[dict2 objectForKey: key] dictionaryByMergingWith: (NSDictionary *) obj];
                [result setObject: newVal forKey: key];
            }
            else
            {
                [result setObject: obj forKey: key];
            }
        }
    }];
    return (NSDictionary *) [result mutableCopy];
    
}

- (NSDictionary *)dictionaryByMergingWith:(NSDictionary *)dict
{
    return [[self class] dictionaryByMerging:self with: dict];
}

#pragma mark - Manipulation
- (NSDictionary *)dictionaryByAddingEntriesFromDictionary:(NSDictionary *)dictionary
{
    NSMutableDictionary *result = [self mutableCopy];
    [result addEntriesFromDictionary:dictionary];
    return result;
}

- (NSDictionary *)dictionaryByRemovingEntriesWithKeys:(NSSet *)keys
{
    NSMutableDictionary *result = [self mutableCopy];
    [result removeObjectsForKeys:keys.allObjects];
    return result;
}

@end
