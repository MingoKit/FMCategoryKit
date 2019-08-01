//
//  UIWebView+Add.h
//  FMCategoryKit
//
//  Created by mingo on 2019/7/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIWebView (Add)
/// 域名请求设置参数到 web的cookie中
- (void)fm_setKeysToWebCookie:(NSDictionary *)keys webHost:(NSString *)webHost;
@end

NS_ASSUME_NONNULL_END
