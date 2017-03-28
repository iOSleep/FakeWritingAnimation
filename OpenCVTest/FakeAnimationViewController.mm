//
//  FakeAnimationViewController.m
//  SmartPigai
//
//  Created by mac on 2017/3/27.
//  Copyright © 2017年 SmartStudy. All rights reserved.
//

#import "FakeAnimationViewController.h"
#import "FBShimmeringView.h"
#import <opencv2/imgcodecs/ios.h>
#import <opencv2/imgproc.hpp>
#import "UIView+Addition.h"

#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define kScreenWidht ([UIScreen mainScreen].bounds.size.widht)

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000
@interface FakeAnimationViewController() <CAAnimationDelegate>
#else
@interface FakeAnimationViewController()
#endif

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, assign) BOOL shouldStop;
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, strong) UIImage *scanedImage;
@property (nonatomic, weak) UIImageView *blackScanView;
@property (nonatomic, weak) UIImageView *blueScanView;
//@property (nonatomic, strong) FBShimmeringView *shimmeringView;
@end

@implementation FakeAnimationViewController
#pragma mark - override
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.view.backgroundColor = [UIColor clearColor];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
  return UIStatusBarStyleLightContent;
}

#pragma mark - animations
- (void)beginAnimation {
  [self.window makeKeyAndVisible];
  [self startDepthAnimation];
}

- (void)stopAnimation {
  _shouldStop = YES;
  // 扫描动画应该是自检测, 然后调用stopDepthAnimation的
  [self stopDepthAnimation];
}

- (void)startDepthAnimation {
  // 破碎动画的容器
  UIView *contentView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
  contentView.backgroundColor = [UIColor blackColor];
  self.contentView = contentView;
  [self.view addSubview:contentView];
  // 默认的图片
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
  imageView.contentMode = UIViewContentModeScaleAspectFit;
  imageView.image = self.cropedImage;
  self.imageView = imageView;
  [contentView addSubview:imageView];
  // 黑色的识别
  UIImageView *blackScanView= [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
  blackScanView.alpha = 0.0f;
  blackScanView.contentMode = UIViewContentModeScaleAspectFit;
  self.blackScanView = blackScanView;
  [self.imageView addSubview:self.blackScanView];
  
//  self.shimmeringView = [[FBShimmeringView alloc] initWithFrame:blackScanView.bounds];
//  self.shimmeringView.contentView = blackScanView;
//  self.shimmeringView.shimmeringBeginFadeDuration = 0.3;
//  self.shimmeringView.shimmeringOpacity = 0.3;
  // 蓝色的识别
  UIImageView *blueScanView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
  blueScanView.contentMode = UIViewContentModeScaleAspectFit;
  blueScanView.alpha = 0.0f;
  blueScanView.layer.masksToBounds = YES;
  self.blueScanView = blueScanView;
  [self.blackScanView addSubview:blueScanView];
  
  CATransform3D trans = CATransform3DIdentity;
  trans = CATransform3DRotate(trans, M_PI/180*60, 1, 0, 0);
  trans = CATransform3DRotate(trans, M_PI/180*-50, 0, 0, 1);
  trans = CATransform3DScale(trans, 0.5, 0.5, 0.5);
  [UIView animateWithDuration:1.0f animations:^{
    imageView.layer.transform = trans;
  } completion:^(BOOL finished) {
    [self startScanAnimation];
  }];
}

- (void)stopDepthAnimation {
  [self stopScanAnimation];
  CATransform3D trans = CATransform3DIdentity;
  [UIView animateWithDuration:1.0f animations:^{
    self.imageView.layer.transform = trans;
//    self.blueScanView.layer.transform = trans;
    self.blackScanView.layer.transform = trans;
  } completion:^(BOOL finished) {
    [self startStarWarAnimation];
  }];
}

- (void)startScanAnimation {
  // 边缘检测
  cv::Mat cvImage;
  UIImageToMat(self.cropedImage, cvImage);
  if (!cvImage.empty()) {
    cv::Mat edges;
    cv::Canny(cvImage, edges, 0, 50);
    cvImage.setTo(cv::Scalar::all(225));
    cvImage.setTo(cv::Scalar(84,255,118,246), edges);
    self.blueScanView.image = MatToUIImage(cvImage);
    cvImage.setTo(cv::Scalar(84,255,255,255), edges);
    self.blackScanView.image = MatToUIImage(cvImage);
  }
  // 升起识别界面
  CATransform3D trans = self.blackScanView.layer.transform;
  trans = CATransform3DTranslate(trans, 60, -60, 0);
  [UIView animateWithDuration:0.75f animations:^{
    self.blackScanView.alpha = 1.0;
    self.blackScanView.layer.transform = trans;
  }completion:^(BOOL finished) {
    // 扫描动画
    self.blueScanView.alpha = 1.0;
    [self addScanAnimation];
//    self.shimmeringView.shimmering = YES;
//    self.blueScanView.height = 0;
//    [self stopAnimation];
//    [self stopDepthAnimation];
  }];
}



- (void)addScanAnimation {
  self.blueScanView.height = 0;
  self.blueScanView.layer.anchorPoint = CGPointMake(1, 1);
  [UIView animateWithDuration:1.0 animations:^{
    self.blueScanView.height = kScreenHeight;
  } completion:^(BOOL finished) {
    if (self.shouldStop) {
      // 如果结束.刚好动画停止...
    } else {
      // 没有停止, 就重复刚才的动画.
      [self addScanAnimation];
    }
  }];
}

//- (CAAnimation *)creatAnimation {
//
//  CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds"];
//  animation.delegate = self;
//  animation.fromValue = [NSValue valueWithCGRect:CGRectMake(0, 0, kScreenWidth, 0)];
//  animation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//  animation.autoreverses = YES;
//  animation.removedOnCompletion = NO;
//  animation.fillMode = kCAFillModeForwards;
//  animation.duration = 2.0f;
//  animation.repeatCount = 1;
//  self.blueScanView.alpha = 1.0;
//  [self.blueScanView.layer addAnimation:animation forKey:@"123"];
//  
//  
//  CAAnimationGroup *groupAnim = [CAAnimationGroup animation];
//  [groupAnim setAnimations:<#(NSArray<CAAnimation *> * _Nullable)#>]
//}

//- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
//  if (self.shouldStop) {
//    [self.blueScanView.layer removeAllAnimations];
//  } else {
//    CAAnimation *anim = [self creatAnimation];
//    [self.blueScanView.layer addAnimation:anim forKey:@"scan"];
//  }
//}

- (void)stopScanAnimation {
//  DDLogError(@"结束扫描");
}

- (void)startStarWarAnimation {
  UIView *containerView = self.contentView;
  UIView *fromView = self.imageView;
  
  CGSize size = fromView.frame.size;
  
  UIView *fromViewSnapshot = [fromView snapshotViewAfterScreenUpdates:NO];
  CGFloat width = self.spriteWidth;
  CGFloat height = width;
  
  self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:containerView];
  
  NSMutableArray *snapshots = [NSMutableArray array];
  for (int i = 0; i < (int)(size.width/width); i++) {
    for (int j = 0; j < (int)(size.height/height); j++) {
      // 切割小view
      CGRect snapshotRegion = CGRectMake(i*width, j*height, width, height);
      UIView *snapshot = [fromViewSnapshot resizableSnapshotViewFromRect:snapshotRegion afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
      [containerView addSubview:snapshot];
      snapshot.frame = snapshotRegion;
      [snapshots addObject:snapshot];
      // 每个小view添加随机的push
      UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems:@[snapshot] mode:UIPushBehaviorModeInstantaneous];
      CGVector direction = CGVectorMake([self randomFloatBetweenSmall:-15 big:15], [self randomFloatBetweenSmall:-15 big:0]);
      push.pushDirection = direction;
      push.active = YES;
      [self.animator addBehavior:push];
    }
  }
  // 添加完成每个小块儿的view后 移除层级
  [self.imageView removeFromSuperview];
  self.contentView.backgroundColor = [UIColor clearColor];
  // 所有的小view添加重力
  UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:snapshots];
  [self.animator addBehavior:gravity];
  NSLog(@"%zd", snapshots.count);
  [fromView removeFromSuperview];
  [NSTimer scheduledTimerWithTimeInterval:self.duration repeats:NO block:^(NSTimer * _Nonnull timer) {
    [self destory];
    [timer invalidate];
  }];
}

#pragma mark - private
- (void)destory {
  [self.animator removeAllBehaviors];
  self.window.rootViewController = nil;
  self.window = nil;
//  [self actionSheetContainer].actionSheet = nil;
//  SWActionSheetWindow.hidden = YES;
//  if ([SWActionSheetWindow isKeyWindow])
//    [SWActionSheetWindow resignFirstResponder];
//  SWActionSheetWindow.rootViewController = nil;
//  SWActionSheetWindow = nil;
}

- (CGFloat)randomFloatBetweenSmall:(NSInteger)small big:(NSInteger)big {
  NSInteger diff = big - small;
  return (arc4random() / 100 % diff + small)/100.0;
}

#pragma mark - lazyLoading
- (UIWindow *)window {
  if (_window == nil) {
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.windowLevel = UIWindowLevelAlert;
    _window.rootViewController = self;
  }
  return _window;
}

@end
