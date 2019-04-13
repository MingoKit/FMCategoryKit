//
//  UITableViewCell+LayoutHeight.m
//  WJQNews
//
//  Created by 吴俊秋 on 2017/4/12.
//  Copyright © 2017年 JackWu. All rights reserved.
//

#import "UITableViewCell+LayoutHeight.h"

@implementation UITableViewCell (LayoutHeight)


/**
 距离cell底部无距离时的cell高度

 @return cell高度
 */
- (CGFloat)getLayoutCellHeight {
    return [self getLayoutCellHeightWithFlex:0];
}



/**
 获取距离底部有距离时的cell高度

 @param flex 距离cell底部的距离
 @return cell高度
 */
- (CGFloat)getLayoutCellHeightWithFlex:(CGFloat)flex {
    UIView *bottomView = [self getBottomView:self.contentView.subviews];
    return [self getLayoutCellHeightWithFlex:flex BottomView:bottomView];
}

- (CGFloat)getLayoutCellHeightWithFlex:(CGFloat)flex BottomView:(UIView *)bottomView {
    return [self getLayoutCellHeightWithFlex:flex BottomView:bottomView DefaultHeight:44.0];
}


/**
 获取cell最终高度
 
 @param flex 距离cell底部的距离
 @param bottomView cell.contenView上最后添加的视图
 @param defaultHeight cell默认高度
 @return cell最终高度
 */
- (CGFloat)getLayoutCellHeightWithFlex:(CGFloat)flex BottomView:(UIView *)bottomView DefaultHeight:(CGFloat)defaultHeight {
    if (bottomView)
    {
        return (bottomView.frame.origin.y+bottomView.frame.size.height+flex);
    }
    else
    {
        return defaultHeight;
    }
}

/**
 获取cell.contenview上最后添加的视图

 @param views cell.contenview上添加的所有视图
 @return cell.contenview上最后添加的视图
 */
- (UIView *)getBottomView:(NSArray *)views {
    [self layoutIfNeeded];
    if (views && views.count >0)
    {
        CGFloat height = 0;
        UIView *bottomView = [views objectAtIndex:0];
        for(UIView *tpView in views)
        {
            CGFloat flex = tpView.frame.origin.y+tpView.frame.size.height;
            if (flex>height)
            {
                height = flex;
                bottomView = tpView;
            }
        }
        return bottomView;
    }
    return nil;
}





@end
