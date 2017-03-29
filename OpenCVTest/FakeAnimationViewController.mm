//
//  FakeAnimationViewController.m
//  SmartPigai
//
//  Created by mac on 2017/3/27.
//  Copyright © 2017年 SmartStudy. All rights reserved.
//

#import "FakeAnimationViewController.h"
#import "UIView+Addition.h"
#import "UIImage+UIView.h"
#import "UIView+MaskAnimation.h"

#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000
@interface FakeAnimationViewController() <CAAnimationDelegate>
#else
@interface FakeAnimationViewController()
#endif

@property (nonatomic, strong) UIImage *blueImage;
@property (nonatomic, strong) UIImage *blackImage;
@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, assign) BOOL shouldStop;
@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UIImageView *blackScanView;
@property (nonatomic, weak) UIImageView *blueScanView;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@end

@implementation FakeAnimationViewController
#pragma mark - override
- (void)viewDidLoad {
    [super viewDidLoad];
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
//  [self stopDepthAnimation];
}

- (void)startDepthAnimation {
  // 破碎动画的容器
  UIView *contentView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
  contentView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:1.0];
  self.contentView = contentView;
  [self.view addSubview:contentView];
  // 默认的图片
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:contentView.bounds];
  imageView.contentMode = UIViewContentModeScaleAspectFit;
  imageView.image = self.cropedImage;
  self.imageView = imageView;
  [contentView addSubview:imageView];
  // 黑色的识别
  UIImageView *blackScanView= [[UIImageView alloc] initWithFrame:contentView.bounds];
  blackScanView.alpha = 0.0f;
  blackScanView.contentMode = UIViewContentModeScaleAspectFit;
  self.blackScanView = blackScanView;
  [contentView addSubview:blackScanView];
  // 蓝色的识别
  UIImageView *blueScanView = [[UIImageView alloc] initWithFrame:contentView.bounds];
  blueScanView.contentMode = UIViewContentModeScaleAspectFit;
  blueScanView.alpha = 0.0f;
  self.blueScanView = blueScanView;
  [contentView addSubview:blueScanView];
  
  CATransform3D trans = CATransform3DIdentity;
  trans = CATransform3DRotate(trans, M_PI/180*60, 1, 0, 0);
  trans = CATransform3DRotate(trans, M_PI/180*-50, 0, 0, 1);
  trans = CATransform3DScale(trans, 0.5, 0.5, 0.5);
  [UIView animateWithDuration:1.0f animations:^{
    imageView.layer.transform = trans;
    blueScanView.layer.transform = trans;
    blackScanView.layer.transform = trans;
  } completion:^(BOOL finished) {
    [self doScanAnimation];
  }];
}

- (void)doScanAnimation {
  // 边缘检测拿到两张图片
  NSArray *images = [UIImage imageNamed:@"love"].scanImage;
  self.blackImage = images[0];
  self.blueImage = images[1];
  self.blackScanView.image = self.blackImage;
  self.blueScanView.image = self.blueImage;
  
  CATransform3D trans = self.blackScanView.layer.transform;
  trans = CATransform3DTranslate(trans, 60, -60, 0);
  [UIView animateWithDuration:0.75f animations:^{
    // 升起识别界面
    self.blackScanView.alpha = 1.0;
    self.blackScanView.layer.transform = trans;
    self.blueScanView.layer.transform = trans;
  }completion:^(BOOL finished) {
    // 开始扫描动画
    [self.blueScanView mx_animateRectExpandDirection:MaskAnimationDirectionTopToBottom duration:2.0f alpha:1.0];
    self.blueScanView.alpha = 1.0f;
    [NSTimer scheduledTimerWithTimeInterval:2.0f repeats:YES block:^(NSTimer * _Nonnull timer) {
      if (self.shouldStop) {
        [self.blueScanView mx_removeMaskAnimation];
        self.blackScanView.image = nil;
      }
      [timer invalidate];
    }];
  }];
}

- (void)endDepthAnimation {
  CATransform3D trans = CATransform3DIdentity;
  [UIView animateWithDuration:1.0f animations:^{
    self.imageView.layer.transform = trans;
//    self.blueScanView.layer.transform = trans;
    self.blackScanView.layer.transform = trans;
  } completion:^(BOOL finished) {
    [self doStarWarAnimation];
  }];
}

- (void)doStarWarAnimation {
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
      CGVector direction = CGVectorMake([self randomFloatBetweenSmall:-30 big:30], [self randomFloatBetweenSmall:-30 big:0]);
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
  [fromView removeFromSuperview];
  [NSTimer scheduledTimerWithTimeInterval:self.duration repeats:NO block:^(NSTimer * _Nonnull timer) {
    [self destory];
    [timer invalidate];
  }];
}

#pragma mark - private
- (void)destory {
  self.blueImage = nil;
  self.blackImage = nil;
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
