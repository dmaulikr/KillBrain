//
//  TabBarViewController.m
//  KLTabBarController
//
//  Created by Li Kelin on 16/7/21.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "KLTabBarViewController.h"
#import "UIViewController+KKExtension.h"
#import <AudioToolbox/AudioToolbox.h>

#define kMusicUrl(name,type) [[NSBundle mainBundle] URLForResource:name withExtension:type]
@interface KLTabBarViewController ()<UITabBarControllerDelegate>
@property (nonatomic, strong) NSMutableArray *imageViews;
@property (nonatomic, strong) NSMutableArray *tabBarButtons;
@property (nonatomic, strong) NSMutableArray *controllers;
@property (nonatomic, assign) NSUInteger     index;
@property (nonatomic, assign) SystemSoundID  gu;
@property (nonatomic, strong) NSURL          *musicUrl;
@end

@implementation KLTabBarViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.delegate = self;
}


- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  // 播放音效
  [self playmusic];
  /** dismiss控制器时，控制器会从当前的tabBarController.viewControllers中移除，所以全局获取一次总的控制器数量 */
  [self totalViewControllers];
  
  [self loadUITabBarButtonAndUITabBarSwappableImageView];
  /** 获取 type == ShowTypeModal 的控制器，并添加一个大小完全一样的view，并在view上添加手势 */
  [self addCoverViewInCurrentUITabBarButton];
  /** 修改UITabBarButton的透明度，因为当设置控制器的tabBarItem.enabled为NO时，UITabBarButton的透明度会变成0.25 */
  [self changeCurrentUITabBarButtonAlpha];
  
}


- (void)playmusic
{
  if (self.musical) {
    if (self.musicName.length == 0)
    {
      _musicUrl = kMusicUrl(@"gu",@"mp3");
    }
    
    if (self.musicName.length != 0 && self.musicType.length != 0)
    {
      _musicUrl = kMusicUrl(self.musicName,self.musicType);
    }
    
    if (self.musicName.length != 0 && self.musicType.length == 0)
    {
        NSString *name = [self musicNames][0];
        NSString *type = [self musicNames][1];
        _musicUrl = kMusicUrl(name, type);
    }
    // 加载音效
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(_musicUrl), &(_gu));
  }
}

- (NSArray *)musicNames
{
  NSString *text = self.musicName;
  NSArray *texts = [text componentsSeparatedByString:@"."];
  if (texts.count == 2) {
    return texts;
  }
  NSLog(@"音频格式不正确，请检查!");
  return nil;
}


- (void)loadUITabBarButtonAndUITabBarSwappableImageView
{
  [self.tabBarButtons removeAllObjects]; [self.imageViews removeAllObjects];
  for (UIView *child in self.tabBar.subviews) {
    if ([child isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
      [self.tabBarButtons addObject:child];
    }
  }
  
  [self.tabBarButtons sortUsingComparator:^NSComparisonResult(UIView *  _Nonnull obj1, UIView *  _Nonnull obj2) {
    return obj1.x > obj2.x;
  }];
  
  for (UIView *child in self.tabBarButtons) {
    for (UIView *childchild in child.subviews) {
      if ([childchild isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
        UIImageView *imageView = (UIImageView *)childchild;
        [self.imageViews addObject:imageView];
      }
    }
  }
}

- (void)addCoverViewInCurrentUITabBarButton
{
  for (UIViewController *viewController in self.controllers) {
    if (viewController.showType == ShowTypeModal) {
      NSInteger index = [self.controllers indexOfObject:viewController];
      UIView *modelView = self.tabBarButtons[index];
      
      UIView *coverView = [[UIView alloc] init];
      coverView.frame   = modelView.bounds;
      coverView.backgroundColor = [UIColor clearColor];
      coverView.tag     = index;
      UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
      [coverView addGestureRecognizer:tap];
      [modelView addSubview:coverView];
    }
  }
}

- (void)changeCurrentUITabBarButtonAlpha
{
  for (UIView *child in self.tabBar.subviews) {
    if ([child isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
      child.alpha = 1.;
    }
  }
}

- (void)totalViewControllers
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    [self.controllers addObjectsFromArray:self.viewControllers];
  });

}

- (void)click:(UITapGestureRecognizer *)tap
{
  NSInteger index = tap.view.tag;
  UIViewController *viewController = self.controllers[index];
  UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
  // 模态出导航控制器
  [self presentViewController:nav animated:YES completion:^{
    self.viewControllers = [self.controllers copy];
  }];
//   播放音效
  AudioServicesPlaySystemSound(_gu);
}

- (void)didSelectControllerAtIndex:(NSInteger)index
{
  UIImageView *imageView = self.imageViews[index];
  CAKeyframeAnimation *keyAnmi = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
  keyAnmi.values = @[@(1.0) ,@(1.4), @(0.9), @(1.15), @(0.95),@(1.02), @(1.0)];
  keyAnmi.duration = 0.6;
  keyAnmi.calculationMode = kCAAnimationCubic;
  [imageView.layer addAnimation:keyAnmi forKey:@"bounceAnimation"];
}

#pragma mark
#pragma mark - tabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
  _index = [self.controllers indexOfObject:viewController];
  if (self.animationed) {
    [self didSelectControllerAtIndex:_index];
  }
  // 播放音效
  AudioServicesPlaySystemSound(_gu);
    self.selectedIndex = _index;

}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
  if (viewController.showType == ShowTypeModal) {
    return NO;
  }
  return YES;
}


- (NSMutableArray *)imageViews
{
  if (!_imageViews) {
    _imageViews = [NSMutableArray array];
  }
  return _imageViews;
}

- (NSMutableArray *)tabBarButtons
{
  if (!_tabBarButtons) {
    _tabBarButtons = [NSMutableArray array];
  }
  return _tabBarButtons;
}

- (NSMutableArray *)controllers
{
  if (!_controllers) {
    _controllers = [NSMutableArray array];
  }
  return _controllers;
}

@end
