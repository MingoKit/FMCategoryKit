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
//    self.masksToBounds = NO;

}

-(CGFloat)round {
    return self.cornerRadius;
}

-(void)setCr:(CGFloat)cr {
    self.cornerRadius = cr;
    self.masksToBounds = YES;
}

-(CGFloat)cr {
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

-(void)setSc:(UIColor *)sc {
//    self.shadowColor = sc.CGColor;
//    self.shadowOpacity = 1.0;//阴影透明度，默认0
//    self.shadowOffset = CGSizeZero;//默认为0,-3
    self.cornerRadius = 4;
    self.shadowOffset = CGSizeMake(0.0, 3.0);
    self.shadowColor = sc.CGColor;
    self.shadowOpacity = 0.8; // 必传 默认是0.0
    

}

-(void)setBc:(UIColor *)bc {
    self.borderColor = bc.CGColor;
    self.borderWidth = 0.60f;
}



@end
