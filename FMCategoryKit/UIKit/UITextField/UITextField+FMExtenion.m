//
//  UITextField+FMExtenion.m
//  zms
//
//  Created by Mingo on 17/2/24.
//  Copyright © 2017年 袁凤鸣. All rights reserved.
//

#import "UITextField+FMExtenion.h"
#import <objc/runtime.h>


@interface NSString (FMString)

#pragma mark - 字符串宽度&&高度
/**
 *  获取字符串的实际宽度
 *
 *  @param font   字体
 *  @param height 高度
 *
 *  @return 实际宽度
 */
- (float)widthWithFont:(UIFont *)font height:(float)height;
/**
 *  是否正整数
 *
 *  @return YES：是 NO：否
 */
- (BOOL)isPositiveInteger;
@end


@implementation NSString (FMString)
#pragma mark - 字符串宽度&&高度
/**
 *  获取字符串的实际宽度
 *
 *  @param font   字体
 *  @param height 高度
 *
 *  @return 实际宽度
 */
- (float)widthWithFont:(UIFont *)font height:(float)height{
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
    CGSize actualsize =[self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    return actualsize.width;
}
#pragma mark - 数据类型的判断
/**
 *  是否正整数
 *
 *  @return YES：是 NO：否
 */
- (BOOL)isPositiveInteger{
    NSString *regex = @"^\\d+$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [test evaluateWithObject:self];
}
@end


#define TextFieldLeftViewMinWidth   60  //左侧文字最小宽度，为了输入位置对齐

static char maxLengthKey;
static char canOnlyInputNumberKey;
#define kScreenW ([UIScreen mainScreen].bounds.size.width)
#define kScreenH ([UIScreen mainScreen].bounds.size.hight)

@implementation UITextField (FMExtenion)

#pragma mark - 需要自己设置边框颜色，不设置就是无边框等等
/**  需要自己设置边框颜色，不设置就是无边框等等 */
+ (UITextField *)fm_initTextFieldTitleColor:(UIColor *)color backColor:(UIColor *)backColor font:(NSInteger)font textAlignment_Left0_Center1_Right2:(NSInteger)styleNum cornerRadius:(CGFloat)cornerRadius textBorderStyleColor:(UIColor *)textBorderStyleColor  distanceToLeft:(CGFloat)distanceToLeft addToSuperView:(UIView *)superView  placeholder:(NSString *)placeholder title:(NSString *)title {
    
    UITextField *field = [[UITextField alloc] init];
    if (color) [field setTextColor:color];
    
    if (backColor)  field.backgroundColor = backColor;
    if (font) field.font =  [UIFont systemFontOfSize:(font)];
    
    switch (styleNum) {
        case 0:
            field.textAlignment = NSTextAlignmentLeft;
            break;
        case 1:
            field.textAlignment = NSTextAlignmentCenter;
            break;
        case 2:
            field.textAlignment = NSTextAlignmentRight;
            break;
        default:
            break;
    }
    
    if (cornerRadius > 0.0) {
        field.layer.cornerRadius = cornerRadius;
        field.clipsToBounds = YES;
    }
    
    if (textBorderStyleColor) {
        field.layer.borderColor = textBorderStyleColor.CGColor;
        field.layer.borderWidth = 1.0f;
    }else{
        //  field.borderStyle = UITextBorderStyleNone;
        field.layer.borderColor = [UIColor grayColor].CGColor;
        field.layer.borderWidth = 1.0f;
    }
    
    if (distanceToLeft) {
        field.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, distanceToLeft, 0)];
        field.leftViewMode = UITextFieldViewModeAlways; //设置显示模式为永远显示(默认不显示)
    }
    
    [superView addSubview:field];
    if (placeholder) field.placeholder = placeholder;
    if (title) field.text = title;
    
    return field;
    
}

#pragma mark - //设置隐藏键盘按钮
- (void)AddHiddenButton {
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(30,30),NO,0);
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, 2);
    CGContextMoveToPoint(context, 5, 7);
    CGContextAddLineToPoint(context, 15, 18);
    CGContextAddLineToPoint(context, 25, 7);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextStrokePath(context);
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIButton *hiddenButton = [UIButton buttonWithType:UIButtonTypeCustom];
    hiddenButton.layer.masksToBounds=YES;
    hiddenButton.layer.cornerRadius = 5.0f;
    [hiddenButton setImage:image forState:UIControlStateNormal];
    [hiddenButton setBackgroundColor:[UIColor colorWithRed:189/255.0f green:192/255.0f blue:197/255.0f alpha:1.0f]];
    [hiddenButton setFrame:CGRectMake(kScreenW - 64, 0 , 55.0f, 35.0f)];
    [hiddenButton addTarget:self action:@selector(hiddenKeyboard) forControlEvents:UIControlEventTouchUpInside];
    if([[[UIDevice currentDevice] systemVersion] doubleValue] <= 5.2) {
        hiddenButton.layer.borderWidth=1.0f;
    }
    UIView * inputAccessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , kScreenW, 30.0f)];
    [inputAccessoryView addSubview:hiddenButton];
    inputAccessoryView.clipsToBounds = YES;
    self.inputAccessoryView = inputAccessoryView;
}


- (void)hiddenKeyboard {
    if ([self.delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        [self.delegate textFieldShouldReturn:self];
    }
}

/**
 创建textField
 */
+ (UITextField *)fm_createTextField:(CGRect)frame textColor:(UIColor *)textColor font:(UIFont *)font placeholder:(NSString *)placeholder{
    
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.backgroundColor = [UIColor clearColor];
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.textColor = textColor;
    textField.font = font;
    textField.placeholder = placeholder;
    textField.returnKeyType = UIReturnKeyDone;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    return textField;
}

//创建一个textFiled，左侧带一个图标，并且要指定图标宽高和左侧整个占据的距离
+ (UITextField *)fm_createTextFieldWithImageName:(CGRect)frame imageName:(NSString *)imageName imageWidth:(CGFloat)imageWidth imageHeight:(CGFloat)imageHeight leftAllWidth:(CGFloat)leftAllWidth font:(UIFont *)font textColor:(UIColor *)textColor placeholder:(NSString *)placeholder{
    
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.backgroundColor = [UIColor clearColor];
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.textColor = textColor;
    textField.font = font;
    textField.placeholder = placeholder;
    textField.returnKeyType = UIReturnKeyDone;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, leftAllWidth, CGRectGetHeight(frame))];
    
    
    UIImageView *leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(leftView.frame)/2 - imageWidth/2, CGRectGetHeight(leftView.frame)/2 - imageHeight/2, imageWidth, imageHeight)];
    leftImageView.image = [UIImage imageNamed:imageName];
    
    [leftView addSubview:leftImageView];
    
    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    return textField;
}


/**
 创建一个textFiled,左侧带文字，文字颜色，字体，leftSpace，leftAllWidth，输入框文字颜色，输入框文字字体，placeholder
 */
+ (UITextField *)fm_createTextFieldFrame:(CGRect)frame leftText:(NSString *)leftText leftTextColor:(UIColor *)leftTextColor leftTextfont:(UIFont *)leftTextfont leftSpace:(CGFloat)leftSpace leftAllWidth:(CGFloat)leftAllWidth inputTextColor:(UIColor *)inputTextColor inputTextfont:(UIFont *)inputTextfont placeholder:(NSString *)placeholder{
    
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.backgroundColor = [UIColor clearColor];
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.textColor = inputTextColor;
    textField.font = inputTextfont;
    textField.placeholder = placeholder;
    textField.returnKeyType = UIReturnKeyDone;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, leftAllWidth, CGRectGetHeight(frame))];
    
    UILabel *leftTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(leftSpace, 0, CGRectGetWidth(leftView.frame) - leftSpace, CGRectGetHeight(leftView.frame))];
    leftTextLabel.text = leftText;
    leftTextLabel.textAlignment = NSTextAlignmentLeft;
    leftTextLabel.textColor = leftTextColor;
    leftTextLabel.font = leftTextfont;
    leftTextLabel.backgroundColor = [UIColor clearColor];
    
    [leftView addSubview:leftTextLabel];
    
    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    return textField;
}

- (UITextField *)fm_leftViewImageName:(NSString *)name {
    UIImageView *ima =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
    UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, self.frame.size.height)];
    [back addSubview:ima];
    [ima setFrame:CGRectMake((back.frame.size.width - 5 *2)/2, (back.frame.size.height - 18)/2, 15, 18)];
    self.leftView = back;
    self.leftViewMode = UITextFieldViewModeAlways;
    return self;
}

- (void)fm_setPlaceholderColor:(UIColor *)color  {
    [self fm_setPlaceholderColor:color font:0];
}

- (void)fm_setPlaceholderColor:(UIColor *)color font:(NSInteger )font{
    if (color) {
         self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:color}]; ///新的实现
        
        
    }
    
    if (font) {
         self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}]; ///新的实现
    }
  
}

/**
 *  设置leftview为图片
 *
 *  @param imageName 图片名称
 */
- (void)setLeftViewWithImageName:(NSString *)imageName{
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.height, self.frame.size.height)];
    
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    //    NSLog(@"img frame:%@",NSStringFromCGRect(img.frame));
    img.frame = CGRectMake((leftView.frame.size.width - CGRectGetWidth(img.frame)) / 2, (leftView.frame.size.height - CGRectGetHeight(img.frame)) / 2, CGRectGetWidth(img.frame), CGRectGetHeight(img.frame));
    
    [leftView addSubview:img];
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = leftView;
}

/**
 *  设置leftView为文字
 *
 */
- (void)setLeftViewWithText:(NSString *)text{
    [self setLeftViewWithText:text minWidth:0];
}

/**
 *  设置leftView为文字
 *
 *  @param text  文字
 *  @param minWidth 最小宽度
 */
- (void)setLeftViewWithText:(NSString *)text minWidth:(CGFloat)minWidth{
    [self setLeftViewWithText:text minWidth:minWidth color:[UIColor colorWithRed:215/255.0 green:12/255.0 blue:37/255.0 alpha:1.0]];
}

/**
 *  设置leftView为文字
 *
 *  @param text  文字
 *  @param minWidth 最小宽度
 *  @param color 占位文字颜色
 */
- (void)setLeftViewWithText:(NSString *)text minWidth:(CGFloat)minWidth color:(UIColor *)color{
    if (minWidth <= 0) {
        minWidth = TextFieldLeftViewMinWidth;
    }
    
    CGFloat width = [text widthWithFont:self.font height:self.frame.size.height]+10;
    if (width < minWidth) {
        width = minWidth;
    }
    
    UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0, 0.0, width, self.frame.size.height)];
    leftLabel.font = self.font;
    leftLabel.text = text;
    leftLabel.textColor = color;
    
    self.leftView = leftLabel;
    self.leftViewMode = UITextFieldViewModeAlways;
}

#pragma mark - RightView
/**
 *  设置rightView为文字
 *
 *  @param text 文字
 */
- (void)setRightViewWithText:(NSString *)text{
    UILabel *rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0, 0.0, [text widthWithFont:self.font height:self.frame.size.height]+10, self.frame.size.height)];
    rightLabel.font = self.font;
    rightLabel.text = text;
    
    self.rightView = rightLabel;
    self.rightViewMode = UITextFieldViewModeAlways;
}

/**
 *  设置rightView为图片
 *
 *  @param imageName 图片名称
 */
- (void)setRightViewWithImageName:(NSString *)imageName{
    
    [self layoutIfNeeded];
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    //    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.height, self.frame.size.height)];
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(img.frame)+8, self.frame.size.height)];
    
    img.frame = CGRectMake((rightView.frame.size.width - CGRectGetWidth(img.frame)) / 2, (rightView.frame.size.height - CGRectGetHeight(img.frame)) / 2, CGRectGetWidth(img.frame), CGRectGetHeight(img.frame));
    img.userInteractionEnabled = NO;
    rightView.userInteractionEnabled = NO;
    [rightView addSubview:img];
    self.rightViewMode = UITextFieldViewModeAlways;
    self.rightView = rightView;
}

/**
 *  设置rightView为button
 *
 *  @param imageName 图片名称
 */
- (void)setRightViewButtonWithImageName:(NSString *)imageName taget:(id)taget selector:(SEL)selector{
    [self layoutIfNeeded];
    UIImage * img = [UIImage imageNamed:imageName];
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.rightView.frame.size.height, self.rightView.frame.size.height)];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:img forState:UIControlStateNormal];
    [button addTarget:taget action:selector forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 50, 50);
    [rightView addSubview:button];
    self.rightViewMode = UITextFieldViewModeAlways;
    self.rightView = rightView;
}

#pragma mark - Padding
/**
 *  设置UITextField左侧内边距
 *
 *  @param padding 距离
 */
- (void)setPaddingLeftSpace:(float)padding{
    CGRect frame = [self frame];
    frame.size.width = padding;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = leftview;
}

/**
 *  设置UITextField右侧内边距
 *
 *  @param padding 距离
 */
- (void)setPaddingRightSpace:(float)padding{
    CGRect frame = [self frame];
    frame.size.width = padding;
    UIView *rightview = [[UIView alloc] initWithFrame:frame];
    self.rightViewMode = UITextFieldViewModeAlways;
    self.rightView = rightview;
}

#pragma mark - UI显示
/**
 *  设置底部边框
 *
 *  @param lineColor 边框颜色
 */
- (void)setBottomBorderLineWithColor:(UIColor *)lineColor{
    [self layoutIfNeeded];
    CALayer *bottomLayer = [CALayer new];
    bottomLayer.frame = CGRectMake(0.0, CGRectGetHeight(self.bounds)-1, CGRectGetWidth(self.bounds), 1.0);
    bottomLayer.backgroundColor = lineColor.CGColor;
    [self.layer addSublayer:bottomLayer];
}

/**
 *  设置placeholder的颜色
 *
 */
- (void)setPlaceholderColor:(UIColor *)color{
    
    if (self.placeholder) {
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName: color}];
    }
}
/**
 *  设置下划线出去左边的文字
 */
- (void)setLeftViewWithText:(NSString *)text minWidth:(CGFloat)minWidth withOutTextBottomLineColor:(UIColor *)color{
    if (minWidth <= 0) {
        minWidth = TextFieldLeftViewMinWidth;
    }
    
    CGFloat width = [text widthWithFont:self.font height:self.frame.size.height]+10;
    if (width < minWidth) {
        width = minWidth;
    }
    
    UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0, 0.0, width, self.frame.size.height)];
    leftLabel.font = self.font;
    leftLabel.text = text;
    leftLabel.textColor = [UIColor colorWithRed:243/255.0 green:88/255.0 blue:88/255.0 alpha:1.0];
    
    self.leftView = leftLabel;
    self.leftViewMode = UITextFieldViewModeAlways;
    
    [self layoutIfNeeded];
    CALayer *bottomLayer = [CALayer new];
    bottomLayer.frame = CGRectMake(CGRectGetWidth(self.leftView.bounds), CGRectGetHeight(self.bounds)-1, CGRectGetWidth(self.bounds)-CGRectGetWidth(self.leftView.bounds), 1.0);
    bottomLayer.backgroundColor = color.CGColor;
    [self.layer addSublayer:bottomLayer];
}

#pragma mark - ========== 最大长度&&只可以输入数字 ==========
#pragma mark - Property

- (NSInteger)maxLength {
    NSNumber *maxLengthNumber = objc_getAssociatedObject(self, &maxLengthKey);
    return maxLengthNumber.integerValue;
}

- (void)setMaxLength:(NSInteger)maxLength {
    NSNumber *maxLengthNumber = [NSNumber numberWithInteger:maxLength];
    objc_setAssociatedObject(self, &maxLengthKey, maxLengthNumber, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (BOOL)canOnlyInputNumber {
    NSNumber *obj = objc_getAssociatedObject(self, &canOnlyInputNumberKey);
    return obj.boolValue;
}

- (void)setCanOnlyInputNumber:(BOOL)canOnlyInputNumber {
    NSNumber *numberObj = [NSNumber numberWithBool:canOnlyInputNumber];
    objc_setAssociatedObject(self, &canOnlyInputNumberKey, numberObj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)textFieldChanged:(UITextField *)textField {
    
    if (textField.maxLength <= 0) {
        return;
    }
    
    UITextRange *selectedRange = [self markedTextRange];
    //获取高亮部分
    UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position) {
        if (textField.text.length > textField.maxLength) {
            textField.text = [self.text substringToIndex:self.maxLength];
        }
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (string.length == 0) return YES;
    
    if (textField.canOnlyInputNumber && ![string isPositiveInteger]) {
        return NO;
    }
    NSInteger length = textField.text.length - range.length + string.length;
    if (textField.maxLength > 0 && length > textField.maxLength) {
        return NO;
    }
    return YES;
}

@end
