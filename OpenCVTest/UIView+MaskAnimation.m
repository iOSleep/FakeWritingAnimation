//
//  UIView+MaskAnimation.m
//  OpenCVTest
//
//  Created by mac on 2017/3/29.
//  Copyright © 2017年 yolande. All rights reserved.
//

#import "UIView+MaskAnimation.h"

@implementation UIView (MaskAnimation)
- (void)mx_animateMaskFromPath:(UIBezierPath *)fromPath
                        toPath:(UIBezierPath *)toPath
                      duration:(NSTimeInterval)duration
                         alpha:(CGFloat)alpha
{
  CAShapeLayer * maskLayer = [CAShapeLayer layer];
  maskLayer.path = toPath.CGPath;
  maskLayer.fillColor = [UIColor colorWithWhite:1.0 alpha:alpha].CGColor;
//  self.alpha = 1.0;
  self.layer.mask = maskLayer;
  
  CABasicAnimation * animation = [CABasicAnimation animation];
  animation.keyPath = @"path";
  animation.fromValue = (__bridge id)fromPath.CGPath;
  animation.toValue = (__bridge id)toPath.CGPath;
  animation.duration = duration;
  animation.removedOnCompletion = NO;
  animation.fillMode = kCAFillModeForwards;
  animation.repeatCount = 100;
  [maskLayer addAnimation:animation forKey:@"MaskAnimation"];
}

- (void)mx_animateRectExpandDirection:(MaskAnimationDirections)directions
                             duration:(NSTimeInterval)duration
                                alpha:(CGFloat)alpha {
  UIBezierPath * fromPath;
  CGFloat width = CGRectGetWidth(self.bounds);
  CGFloat height = CGRectGetHeight(self.bounds);
  if (directions == MaskAnimationDirectionBottomToTop) {
    fromPath = [UIBezierPath bezierPathWithRect:CGRectMake(0,height, width, 0)];
  }else if(directions == MaskAnimationDirectionLeftToRight){
    fromPath = [UIBezierPath bezierPathWithRect:CGRectMake(0,0, 0,height)];
  }else if(directions ==  MaskAnimationDirectionTopToBottom){
    fromPath = [UIBezierPath bezierPathWithRect:CGRectMake(0,0, width, 0)];
  }else if(directions == MaskAnimationDirectionRightToLeft){
    fromPath = [UIBezierPath bezierPathWithRect:CGRectMake(width - 0, 0, 0, height)];
  }
  UIBezierPath * toPath = [UIBezierPath bezierPathWithRect:self.bounds];
  [self mx_animateMaskFromPath:fromPath toPath:toPath duration:duration alpha:alpha];
}

- (void)mx_removeMaskAnimation {
  [self.layer.mask removeAllAnimations];
  self.layer.mask = nil;
}

@end
