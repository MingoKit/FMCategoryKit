//
//  NSLayoutConstraint+XibScale.m
//  Client
//
//  Created by mingo on 2018/11/30.
//  Copyright © 2018年 mingo. All rights reserved.
//

#import "NSLayoutConstraint+XibScale.h"
#import <objc/runtime.h>

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScaleWidthByOject(contentWidth) (CGFloat)kScreenWidth/375.0*(contentWidth)

@implementation NSLayoutConstraint (XibScale)

+ (void)load{
    
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode
{
    [self myInitWithCoder:aDecode];
    if (self){
        
//        if([self.identifier isEqualToString:@"666"])    // 也可以加一个判断条件，只对符合条件的约束进行适配
//        {
//            self.constant = ScaleWidthByOject(self.constant);
//        }
//        self.constant = ScaleWidthByOject(self.constant);
        self.constant = self.constant;

    }
    return self;
}
@end

