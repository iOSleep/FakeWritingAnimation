//
//  ViewController.m
//  OpenCVTest
//
//  Created by mac on 2017/3/22.
//  Copyright © 2017年 yolande. All rights reserved.
//

#import "ViewController.h"
#import "FakeAnimationViewController.h"

@interface ViewController ()
@property(nonatomic, strong) UIImageView *imgView;
@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  
  FakeAnimationViewController *vc = [FakeAnimationViewController new];
  vc.cropedImage = [UIImage imageNamed:@"love"];
  vc.duration = 3;
  vc.spriteWidth = 18;
  [vc beginAnimation];
  
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
//  UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 20, 300, 600)];
//  //  UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(50, 330, 300, 300)];
//  //  imgView1.image = [UIImage imageNamed:@"love"];
////  [self.view addSubview:imgView];
//  //  [self.view addSubview:imgView1];
//  self.imgView = imgView;
//  UIImage *img = [UIImage imageNamed:@"love"];
//  imgView.image = img;
//  [self.view addSubview:self.imgView];
//  imgView.frame = self.view.bounds;
//  
//  cv::Mat cvImage;
//  UIImageToMat(img, cvImage);
//  if (!cvImage.empty()) {
//    cv::Mat edges;
//    cv::Canny(cvImage, edges, 0, 50);
//    cvImage.setTo(cv::Scalar::all(225));
//    cvImage.setTo(cv::Scalar(84,255,118,246), edges);
//    img = MatToUIImage(cvImage);
//  }
//  
//  UIImageView *fadeView = [[UIImageView alloc] initWithImage:img];
//  CALayer *layer;
//  
//  FBShimmeringView *shimmeringView = [FBShimmeringView new];
//  shimmeringView.shimmering = YES;
//  shimmeringView.shimmeringOpacity = 0.0;
//  shimmeringView.shimmeringPauseDuration = 0.0f;
//  shimmeringView.shimmeringEndFadeDuration = 0.0f;
//  shimmeringView.shimmeringBeginFadeDuration = 0.0f;
//  shimmeringView.shimmeringDirection = FBShimmerDirectionDown;
////  shimmeringView.shimmeringHighlightLength = 0.5;
////  shimmeringView.shimmeringOpacity = 0.5f;
////  shimmeringView.shimmeringBeginFadeDuration = 3.0f;
//  [self.view addSubview:shimmeringView];
//  
//  shimmeringView.contentView = fadeView;
//  shimmeringView.frame = self.view.bounds;
//  
  
  
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

  // 创建出CAGradientLayer
//  CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//  gradientLayer.frame            = self.imgView.bounds;
//  gradientLayer.colors           = @[(__bridge id)[UIColor clearColor].CGColor,
//                                     (__bridge id)[UIColor blackColor].CGColor,
//                                     (__bridge id)[UIColor clearColor].CGColor];
//  gradientLayer.locations        = @[@(0.25), @(0.5), @(0.75)];
//  gradientLayer.startPoint       = CGPointMake(0, 0);
//  gradientLayer.endPoint         = CGPointMake(1, 0);
//  
//  // 容器view --> 用于加载创建出的CAGradientLayer
//
//  UIView *containerView = [[UIView alloc] initWithFrame:self.imgView.bounds];
//  [containerView.layer addSublayer:gradientLayer];
//  
//  // 设定maskView
//  self.imgView.maskView  = containerView;
//  
//  CGRect frame        = containerView.frame;
//  frame.origin.x     -= 200;
//  
//  // 重新赋值
//  containerView.frame = frame;
//  
//  // 给maskView做动画效果
//  [UIView animateWithDuration:3.f animations:^{
//    // 改变位移
//    CGRect frame        = containerView.frame;
//    frame.origin.x     += 400;
//    // 重新赋值
//    containerView.frame = frame;
//  }];
//}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
