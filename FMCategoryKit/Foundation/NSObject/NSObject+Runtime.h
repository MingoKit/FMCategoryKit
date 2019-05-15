//
//  NSObject+Runtime.h
//  iOS-Categories (https://github.com/shaojiankui/iOS-Categories)
//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Runtime)


/** 属性列表 */
- (NSArray *)propertiesInfo;

/** 属性列表 */
+ (NSArray *)propertiesInfo;

/** 格式化之后的属性列表 */
+ (NSArray *)propertiesWithCodeFormat;

/** 成员变量列表 */
- (NSArray *)ivarInfo;

/** 成员变量列表 */
+ (NSArray *)ivarInfo;

/** 对象方法列表 */
-(NSArray*)instanceMethodList;

/** 对象方法列表 */
+(NSArray*)instanceMethodList;

/** 类方法列表 */
+(NSArray*)classMethodList;

/** 协议列表 */
-(NSDictionary *)protocolList;

/** 协议列表 */
+(NSDictionary *)protocolList;

/** 交换实例方法 */
+ (void)SwizzlingInstanceMethodWithOldMethod:(SEL)oldMethod newMethod:(SEL)newMethod;

/** 交换类方法 */
+ (void)SwizzlingClassMethodWithOldMethod:(SEL)oldMethod newMethod:(SEL)newMethod;

/** 添加方法 */
+ (void)addMethodWithSEL:(SEL)methodSEL methodIMP:(SEL)methodIMP;


/**
 Exchange methods' implementations.
 
 @param originalMethod Method to exchange.
 @param newMethod Method to exchange.
 */
+ (void)swizzleMethod:(SEL)originalMethod withMethod:(SEL)newMethod;

/**
 Append a new method to an object.
 
 @param newMethod Method to exchange.
 @param klass Host class.
 */
+ (void)appendMethod:(SEL)newMethod fromClass:(Class)klass;

/**
 Replace a method in an object.
 
 @param method Method to exchange.
 @param klass Host class.
 */
+ (void)replaceMethod:(SEL)method fromClass:(Class)klass;

/**
 Check whether the receiver implements or inherits a specified method up to and exluding a particular class in hierarchy.
 
 @param selector A selector that identifies a method.
 @param stopClass A final super class to stop quering (excluding it).
 @return YES if one of super classes in hierarchy responds a specified selector.
 */
- (BOOL)respondsToSelector:(SEL)selector untilClass:(Class)stopClass;

/**
 Check whether a superclass implements or inherits a specified method.
 
 @param selector A selector that identifies a method.
 @return YES if one of super classes in hierarchy responds a specified selector.
 */
- (BOOL)superRespondsToSelector:(SEL)selector;

/**
 Check whether a superclass implements or inherits a specified method.
 
 @param selector A selector that identifies a method.
 @param stopClass A final super class to stop quering (excluding it).
 @return YES if one of super classes in hierarchy responds a specified selector.
 */
- (BOOL)superRespondsToSelector:(SEL)selector untilClass:(Class)stopClass;

/**
 Check whether the receiver's instances implement or inherit a specified method up to and exluding a particular class in hierarchy.
 
 @param selector A selector that identifies a method.
 @param stopClass A final super class to stop quering (excluding it).
 @return YES if one of super classes in hierarchy responds a specified selector.
 */
+ (BOOL)instancesRespondToSelector:(SEL)selector untilClass:(Class)stopClass;
@end
