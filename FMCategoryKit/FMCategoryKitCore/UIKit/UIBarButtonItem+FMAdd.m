//
//  UIBarButtonItem+FMAdd.m
//  FMCategoryKit <https://github.com/yfming93/FMCategoryKit>
//
//  Created by mingo on 13/10/15.
//  Copyright (c) 2015 mingo.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "UIBarButtonItem+FMAdd.h"
#import "FMCategoryKitMacro.h"
#import <objc/runtime.h>

YYSYNTH_DUMMY_CLASS(UIBarButtonItem_FMAdd)


static const int block_key;

@interface _YYUIBarButtonItemBlockTarget : NSObject

@property (nonatomic, copy) void (^block)(id sender);

- (id)initWithBlock:(void (^)(id sender))block;
- (void)invoke:(id)sender;

@end

@implementation _YYUIBarButtonItemBlockTarget

- (id)initWithBlock:(void (^)(id sender))block{
    self = [super init];
    if (self) {
        _block = [block copy];
    }
    return self;
}

- (void)invoke:(id)sender {
    if (self.block) self.block(sender);
}

@end


@implementation UIBarButtonItem (FMAdd)

+(instancetype _Nullable )fm_barButtonItemWithTitle:(NSString *_Nullable)title imageName:(NSString *_Nullable)imageName target:(nullable id)target action:(nonnull SEL)action fontSize:(CGFloat)fontSize titleNormalColor:(UIColor *_Nullable)normalColor titleHighlightedColor:(UIColor *_Nullable)highlightedColor {
    
    UIButton *button = [UIButton new];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setTitleColor:normalColor forState:UIControlStateNormal];
    [button setTitleColor:highlightedColor forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)setActionBlock:(void (^)(id sender))block {
    _YYUIBarButtonItemBlockTarget *target = [[_YYUIBarButtonItemBlockTarget alloc] initWithBlock:block];
    objc_setAssociatedObject(self, &block_key, target, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self setTarget:target];
    [self setAction:@selector(invoke:)];
}

- (void (^)(id)) actionBlock {
    _YYUIBarButtonItemBlockTarget *target = objc_getAssociatedObject(self, &block_key);
    return target.block;
}

@end
