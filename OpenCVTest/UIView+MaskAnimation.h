//
//  UIView+MaskAnimation.h
//  OpenCVTest
//
//  Created by mac on 2017/3/29.
//  Copyright © 2017年 yolande. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MaskAnimation)

typedef NS_ENUM(NSInteger,MaskAnimationDirections){
  MaskAnimationDirectionLeftToRight,
  MaskAnimationDirectionTopToBottom,
  MaskAnimationDirectionRightToLeft,
  MaskAnimationDirectionBottomToTop,
};

- (void)mx_animateRectExpandDirection:(MaskAnimationDirections)directions
                             duration:(NSTimeInterval)duration
                                alpha:(CGFloat)alpha;

- (void)mx_animateMaskFromPath:(UIBezierPath *)fromPath
                        toPath:(UIBezierPath *)toPath
                      duration:(NSTimeInterval)duration
                         alpha:(CGFloat)alpha;

- (void)mx_removeMaskAnimation;
@end
