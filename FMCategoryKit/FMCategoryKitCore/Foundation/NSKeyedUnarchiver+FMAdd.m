//
//  NSKeyedUnarchiver+FMAdd.m
//  FMCategoryKit <https://github.com/yfming93/FMCategoryKit>
//
//  Created by mingo on 13/8/4.
//  Copyright (c) 2015 mingo.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "NSKeyedUnarchiver+FMAdd.h"
#import "FMCategoryKitMacro.h"

YYSYNTH_DUMMY_CLASS(NSKeyedUnarchiver_FMAdd)


@implementation NSKeyedUnarchiver (FMAdd)

+ (id)unarchiveObjectWithData:(NSData *)data exception:(__autoreleasing NSException **)exception {
    id object = nil;
    @try {
        object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    @catch (NSException *e)
    {
        if (exception) *exception = e;
    }
    @finally
    {
    }
    return object;
}

+ (id)unarchiveObjectWithFile:(NSString *)path exception:(__autoreleasing NSException **)exception {
    id object = nil;
    
    @try {
        object = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    }
    @catch (NSException *e)
    {
        if (exception) *exception = e;
    }
    @finally
    {
    }
    return object;
}

@end
