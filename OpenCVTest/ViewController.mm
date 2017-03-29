//
//  ViewController.m
//  OpenCVTest
//
//  Created by mac on 2017/3/22.
//  Copyright © 2017年 yolande. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+UIView.h"
#import "FakeAnimationViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIImageView *fakeView;
@property (nonatomic, strong) UIImage *blueImage;
@property (nonatomic, strong) UIImage *blackImage;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  
  FakeAnimationViewController *vc = [FakeAnimationViewController new];
  vc.cropedImage = [UIImage imageNamed:@"love"];
  vc.spriteWidth = 50;
  vc.duration = 3;
  [vc beginAnimation];
  
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [vc stopAnimation];
  });
}

@end
