//
//  GuideViewController.m
//  KillBrain
//
//  Created by Li Kelin on 16/9/21.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "GuideViewController.h"
#import "GuideLoadView.h"
@interface GuideViewController ()
@property (nonatomic, strong) GuideLoadView *guideView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger countTime;
@end

@implementation GuideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
  
  _countTime = 3;
  _guideView = [[NSBundle mainBundle] loadNibNamed:@"GuideLoadView" owner:nil options:nil].lastObject;
  _guideView.backgroundImage.image = [UIImage imageNamed:@"bg.png"];
  _guideView.frame = [UIScreen mainScreen].bounds;
  [self.view addSubview:_guideView];
  
  
  __weak typeof(self) wSelf = self;
  [_guideView setClickSkipADButton:^{
    __strong typeof(self) sSelf = wSelf;
    [sSelf dismissAnimation];
    [sSelf.guideView hiddenSkipButton];
    [[NSNotificationCenter defaultCenter] postNotificationName:kKillBrainClickSkipADNotification object:nil userInfo:nil];
  }];
  
  [_guideView.skipButton setTitle:@"3s后跳过" forState:UIControlStateNormal];
  [self showTimer];
}

- (void)dismissAnimation
{
  CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
  scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
  scaleAnim.toValue   = [NSValue valueWithCATransform3D:CATransform3DMakeScale(2.0, 2.0, 1.0)];
  
  CABasicAnimation *alphaAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
  alphaAnim.fromValue = @(1);
  alphaAnim.toValue   = @(0.1);
  
  CAAnimationGroup *group = [CAAnimationGroup animation];
  group.animations = [NSArray arrayWithObjects:scaleAnim,alphaAnim, nil];
  group.removedOnCompletion = NO;
  group.fillMode = kCAFillModeForwards;
  group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
  group.duration = animationADDuration;
  
  [_guideView.backgroundImage.layer addAnimation:group forKey:@"keyAnim"];
}

- (void)showTimer
{
  _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(runTimer) userInfo:nil repeats:YES];
}

- (void)hiddenTimer
{
  if (_timer) {
    [_timer invalidate];
    _timer = nil;
  }
}

- (void)runTimer
{
  _countTime--;
  [_guideView.skipButton setTitle:[NSString stringWithFormat:@"%lds后跳过",_countTime] forState:UIControlStateNormal];
  if (_countTime <= 0) {
    [self hiddenTimer];
    [self dismissAnimation];
    [self.guideView hiddenSkipButton];
    [[NSNotificationCenter defaultCenter] postNotificationName:kKillBrainSkipADTimerOverNotification object:nil userInfo:nil];
  }
}

@end
