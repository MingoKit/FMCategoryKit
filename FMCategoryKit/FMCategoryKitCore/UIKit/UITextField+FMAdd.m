//
//  UITextField+FMAdd.m
//  FMCategoryKit <https://github.com/yfming93/FMCategoryKit>
//
//  Created by mingo on 14/5/12.
//  Copyright (c) 2015 mingo.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "UITextField+FMAdd.h"
#import "FMCategoryKitMacro.h"

YYSYNTH_DUMMY_CLASS(UITextField_FMAdd)


@implementation UITextField (FMAdd)

- (void)selectAllText {
    UITextRange *range = [self textRangeFromPosition:self.beginningOfDocument toPosition:self.endOfDocument];
    [self setSelectedTextRange:range];
}

- (void)setSelectedRange:(NSRange)range {
    UITextPosition *beginning = self.beginningOfDocument;
    UITextPosition *startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *endPosition = [self positionFromPosition:beginning offset:NSMaxRange(range)];
    UITextRange *selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}

@end
