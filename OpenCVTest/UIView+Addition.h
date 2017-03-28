//
//  UIView+Addition.h
//  SmartPigai
//
//  Created by mac on 16/8/19.
//  Copyright © 2016年 SmartStudy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)
- (CGFloat)left;
- (CGFloat)right;
- (CGFloat)top;
- (CGFloat)bottom;

- (CGFloat)width;
- (CGFloat)height;

- (CGFloat)centerX;
- (CGFloat)centerY;

- (CGPoint)middlePoint;
- (CGFloat)middleX;
- (CGFloat)middleY;

- (void)setLeft:(CGFloat)left;
- (void)setRight:(CGFloat)right;
- (void)setTop:(CGFloat)top;
- (void)setBottom:(CGFloat)bottom;

- (void)setHeight:(CGFloat)height;
- (void)setWidth:(CGFloat)width;

- (void)setSize:(CGSize)size;
- (void)setOrigin:(CGPoint)point;

- (void)setCenterX:(CGFloat)centerX;
- (void)setCenterY:(CGFloat)centerY;
@end

