//
//  UIImage+UIView.m
//  OpenCVTest
//
//  Created by mac on 2017/3/22.
//  Copyright © 2017年 yolande. All rights reserved.
//

#import "UIImage+UIView.h"
#import <opencv2/imgcodecs/ios.h>
#import <opencv2/imgproc.hpp>

@implementation UIImage (UIView)
+ (UIImage *)imageWithView:(UIView *)view {
  UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque,[[UIScreen mainScreen] scale]);
  [view.layer renderInContext:UIGraphicsGetCurrentContext()];
  UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return img;
}

- (NSArray *)scanImage {
  UIImage *img1;
  UIImage *img2;
  cv::Mat cvImage;
  UIImageToMat(self, cvImage);
  if (!cvImage.empty()) {
    cv::Mat edges;
    cv::Canny(cvImage, edges, 0, 50);
    cvImage.setTo(cv::Scalar::all(0));
    cvImage.setTo(cv::Scalar(0,0,0,255), edges);
    img1 = MatToUIImage(cvImage);
    cvImage.setTo(cv::Scalar(50,100,150,255), edges);
    img2 = MatToUIImage(cvImage);
  }
  return @[img1, img2];
}

@end
