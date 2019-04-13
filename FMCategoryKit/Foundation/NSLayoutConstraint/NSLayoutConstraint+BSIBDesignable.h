//
//  NSLayoutConstraint+BSIBDesignable.h
//  FupingElectricity
//
//  Created by mingo on 2019/3/4.
//  Copyright © 2019年 Fleeming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSLayoutConstraint (BSIBDesignable)

@property(nonatomic, assign) IBInspectable BOOL adapt_h;
@property(nonatomic, assign) IBInspectable BOOL adapt_w;

@end
