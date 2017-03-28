//
//  UIView+Addition.m
//  SmartPigai
//
//  Created by mac on 16/8/19.
//  Copyright © 2016年 SmartStudy. All rights reserved.
//

#import "UIView+Addition.h"

@implementation UIView (Frame)

- (CGFloat)left {
  return self.frame.origin.x;
}

- (CGFloat)right {
  return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)top {
  return self.frame.origin.y;
}

- (CGFloat)bottom {
  return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)width {
  return self.frame.size.width;
}

- (CGFloat)height {
  return self.frame.size.height;
}

- (CGFloat)centerX {
  return self.center.x;
}
- (CGFloat)centerY {
  return self.center.y;
}

#pragma mark Middle Point

- (CGPoint)middlePoint {
  return CGPointMake(self.middleX, self.middleY);
}

- (CGFloat)middleX {
  return self.width / 2;
}

- (CGFloat)middleY {
  return self.height / 2;
}

#pragma mark - set方法
- (void)setLeft:(CGFloat)left {
  CGRect frame = self.frame;
  frame.origin.x = left;
  self.frame = frame;
}

- (void)setRight:(CGFloat)right {
  CGRect frame = self.frame;
  frame.origin.x = right - frame.size.width;
  self.frame = frame;
}

- (void)setBottom:(CGFloat)bottom {
  CGRect frame = self.frame;
  frame.origin.y = bottom - frame.size.height;
  self.frame = frame;
}
- (void)setHeight:(CGFloat)height {
  CGRect frame = self.bounds;
  frame.size.height = height;
  self.bounds = frame;
}

- (void)setSize:(CGSize)size {
  CGRect frame = self.bounds;
  frame.size = size;
  self.bounds = frame;
}

- (void)setTop:(CGFloat)top {
  CGRect frame = self.frame;
  frame.origin.y = top;
  self.frame = frame;
}

- (void)setWidth:(CGFloat)width {
  CGRect frame = self.bounds;
  frame.size.width = width;
  self.bounds = frame;
}

- (void)setOrigin:(CGPoint)point {
  CGRect frame = self.frame;
  frame.origin = point;
  self.frame = frame;
}

- (void)setCenterY:(CGFloat)centerY {
  CGPoint center = self.center;
  center.y = centerY;
  self.center = center;
}

- (void)setCenterX:(CGFloat)centerX {
  CGPoint center = self.center;
  center.x = centerX;
  self.center = center;
}
@end

