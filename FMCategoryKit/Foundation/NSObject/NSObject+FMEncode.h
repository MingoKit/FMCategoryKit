//
//  NSObject+FMEncode.h
//  MobileProject
//
//  Created by Mingo on 2017/9/1.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (FMEncode)

//归档
- (void)fm_encodeObjectWithCoder:(NSCoder *)aCoder;

//解档
- (void)fm_decodeObjectCoder:(NSCoder *)aDecoder;

@end
