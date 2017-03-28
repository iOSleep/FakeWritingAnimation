//
//  FakeAnimationViewController.h
//  SmartPigai
//
//  Created by mac on 2017/3/27.
//  Copyright © 2017年 SmartStudy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FakeAnimationViewController : UIViewController
//@property (nonatomic, strong) UIView *snapView;
@property (nonatomic, strong) UIImage *cropedImage;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) CGFloat spriteWidth;
//@property (nonatomic, assign) BOOL stop;
- (void)stopAnimation;
- (void)beginAnimation;
@end
