//
//  UIImage+UIView.m
//  OpenCVTest
//
//  Created by mac on 2017/3/22.
//  Copyright © 2017年 yolande. All rights reserved.
//

#import "UIImage+UIView.h"

@implementation UIImage (UIView)
+ (UIImage *)imageWithView:(UIView *)view {
  UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque,[[UIScreen mainScreen] scale]);
  [view.layer renderInContext:UIGraphicsGetCurrentContext()];
  UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return img;
}
@end
