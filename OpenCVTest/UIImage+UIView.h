//
//  UIImage+UIView.h
//  OpenCVTest
//
//  Created by mac on 2017/3/22.
//  Copyright © 2017年 yolande. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIView)
+ (UIImage *)imageWithView:(UIView *)view;
- (NSArray *)scanImage;
@end
