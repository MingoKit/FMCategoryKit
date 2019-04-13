//
//  NSAttributedString+FMExtension.m
//  FupingElectricity
//
//  Created by mingo on 2019/1/11.
//  Copyright © 2019年 Fleeming. All rights reserved.
//

#import "NSAttributedString+FMExtension.h"

@implementation NSAttributedString (FMExtension)

-(NSAttributedString *)fm_setString:(NSString *)str arrOrOneColor:(id )arrOrOneColor titleArr:(NSMutableArray *)titleArr {
    NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:str];
    
    if ([arrOrOneColor isKindOfClass:[UIColor class]]) {
        for (NSInteger i = 0; i < titleArr.count; i++) {
            NSString *oneStr = titleArr[i];
            UIColor *oneColor = (UIColor *)arrOrOneColor;
            NSRange range = [[hintString string]rangeOfString:oneStr];
            [hintString addAttribute:NSForegroundColorAttributeName value:oneColor range:range];
        }
    }else if ([arrOrOneColor isKindOfClass:[NSMutableArray class]] ||[arrOrOneColor isKindOfClass:[NSArray class]] ) {
        NSMutableArray *colArr = ((NSArray *)arrOrOneColor).mutableCopy;
        if ((colArr.count > 0) && (colArr.count == titleArr.count)) {
            for (NSInteger i = 0; i < colArr.count; i++) {
                NSString *oneStr = titleArr[i];
                UIColor *oneColor = colArr[i];
                NSRange range = [[hintString string]rangeOfString:oneStr];
                [hintString addAttribute:NSForegroundColorAttributeName value:oneColor range:range];
            }
        }
    }
    return hintString;
}


@end
