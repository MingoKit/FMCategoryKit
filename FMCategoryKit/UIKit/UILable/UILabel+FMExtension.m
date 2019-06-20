//
//  UILabel+FMExtension.m
//  
//
//  Created by Mingo on 16/11/14.
//
//

#import "UILabel+FMExtension.h"

@implementation UILabel (FMExtension)

#pragma mark - 快速创建UILabel
+ (UILabel *)fm_initUIlabelWithTextColor:(UIColor *)color backColor:(UIColor *)backColor textAlignment_Left0_Center1_Right2:(NSInteger)styleNum font:(NSInteger)font cornerRadius:(CGFloat)cornerRadius  addToSuperView:(UIView *)superView title:(NSString *)title {
    
    UILabel *lab = [[UILabel alloc] init];
    if (color) [lab setTextColor:color];
    if (backColor)  lab.backgroundColor = backColor;
    
    
    switch (styleNum) {
        case 0:
            lab.textAlignment = NSTextAlignmentLeft;
            break;
        case 1:
            lab.textAlignment = NSTextAlignmentCenter;
            break;
        case 2:
            lab.textAlignment = NSTextAlignmentRight;
            break;
        default:
            break;
    }
    
    if (font) lab.font =  [UIFont systemFontOfSize:font];
    
    if (cornerRadius >0.0) {
        lab.layer.cornerRadius = cornerRadius;
        lab.clipsToBounds = YES;
    }
    
    if (superView) [superView addSubview:lab];
    if (title)  lab.text = title;
 

    return lab;
}

#pragma mark - 显示收益率文字颜色，以"."分隔，左边字体大小，右边字体大小
- (void)fm_showRateNumString:(NSString *)numString color:(UIColor *)color leftFont:(UIFont *)leftFont rightFont:(UIFont *)rightFont {
    
    //检测小数点的位置
    NSInteger location =  [numString rangeOfString:@"."].location;
    
    NSMutableAttributedString *mabstring = [[NSMutableAttributedString alloc]initWithString:numString];
    
    [mabstring addAttribute:NSFontAttributeName value:leftFont range:NSMakeRange(0, location)];
    [mabstring addAttribute:NSFontAttributeName value:rightFont range:NSMakeRange(location, mabstring.length - location)];
    [mabstring addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, mabstring.length)];
    
    self.attributedText = mabstring;
}

#pragma mark 设置lable的某些字符颜色
- (void)fm_attributedStringWithRangeColor:(UIColor *)rangeColor needUnderline:(BOOL)needUnderline rangeString:(NSString *)rangeStr {
    
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSRange range = NSMakeRange([[noteStr string] rangeOfString:rangeStr].location,
                                   [[noteStr string] rangeOfString:rangeStr].length);
   
    if (rangeColor) {
        //需要设置的位置
        [noteStr addAttribute:NSForegroundColorAttributeName value:rangeColor range:range];
    }
   
    if (needUnderline) {
        [noteStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];
    }
    //设置颜色
    [self setAttributedText:noteStr];
    
}

#pragma mark - 创建一个label
+(UILabel *)fm_createLabelFrame:(CGRect)frame withText:(NSString *)text withAlign:(NSTextAlignment)align withColor:(UIColor*)color withFont:(UIFont *)font
{
    UILabel *label= [[UILabel alloc]initWithFrame:frame];
    label.text = text;
    label.textAlignment = align;
    label.textColor = color;
    label.font = font;
    label.backgroundColor = [UIColor clearColor];
    
    return label;
}


- (void)fm_addSingleLine {
    
    NSString *textStr = self.text;
    //中划线
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:textStr attributes:attribtDic];
    // 赋值
    self.attributedText = attribtStr;
}

@end
