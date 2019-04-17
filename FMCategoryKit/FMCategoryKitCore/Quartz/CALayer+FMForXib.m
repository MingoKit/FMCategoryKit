//
//  CALayer+FMForXib.m
//
//  Created by mingo on 2018/8/30.
//  Copyright © 2018年 mingo. All rights reserved.
//

#import "CALayer+FMForXib.h"
@implementation CALayer (FMForXib)

-(void)setBColor:(UIColor *)bColor {
    self.borderColor = bColor.CGColor;
}

- (UIColor*)bColor {
    return [UIColor colorWithCGColor:self.borderColor];
}

-(void)setBWidth:(CGFloat )bWidth {
    self.borderWidth = bWidth;
}
-(CGFloat)bWidth {
    return self.borderWidth;
}


-(void)setRound:(CGFloat)round {
    self.cornerRadius = round;
}

-(CGFloat)round {
    return self.cornerRadius;
}


-(void)setSColor:(UIColor *)sColor {
    self.shadowColor = sColor.CGColor;
}

-(UIColor *)sColor {
    return [UIColor colorWithCGColor:self.shadowColor];
}

-(void)setSOp:(CGFloat)sOp {
    self.shadowOpacity = sOp;
}

-(void)setSOffset:(CGSize)sOffset {
    self.shadowOffset = sOffset;
}




@end
