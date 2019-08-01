//
//  UIWebView+Add.m
//  FMCategoryKit
//
//  Created by mingo on 2019/7/19.
//

#import "UIWebView+Add.h"

@implementation UIWebView (Add)
#pragma mark - 对主域名请求设置token到web的cookie中
- (void)fm_setKeysToWebCookie:(NSDictionary *)keys webHost:(NSString *)webHost {
    if ((!webHost.length) || (![webHost hasPrefix:@"http"])) {
        return;
    }
    NSArray *keysName = keys.allKeys;
    for (NSInteger i = 0; i < keysName.count; i++) {
        // 工厂类中存储cookie的方法
        // 创建一个可变字典存放cookie
        NSMutableDictionary *fromappDict = [NSMutableDictionary dictionary];
        NSString *keyN = keysName[i];
        NSString *keyV = [keys objectForKey:keyN];
        [fromappDict setObject:keyN forKey:NSHTTPCookieName];
        [fromappDict setObject:keyV forKey:NSHTTPCookieValue];
        // kDomain是公司app网址
        NSArray *arr = [webHost componentsSeparatedByString:@"//"];
        [fromappDict setObject:[arr lastObject] forKey:NSHTTPCookieDomain];
        [fromappDict setObject:webHost forKey:NSHTTPCookieOriginURL];
        [fromappDict setObject:@"/" forKey:NSHTTPCookiePath];
        [fromappDict setObject:@"0" forKey:NSHTTPCookieVersion];
        
        // 将可变字典转化为cookie
        NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:fromappDict];
        // 获取cookieStorage
        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        // 存储cookie
        [cookieStorage setCookie:cookie];
    }
    
}
@end
