//
//  AppDelegate.m
//  KillBrain
//
//  Created by Li Kelin on 16/8/20.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "AppDelegate.h"

#import "GuideViewController.h"
#import "CommonViewController.h"

@interface AppDelegate ()
@property (nonatomic, strong) GuideViewController *guideVC;
@property (nonatomic, strong) CommonViewController *commonVC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  
  GuideViewController *guideVC = [[GuideViewController alloc] init];
  CommonViewController *commonVC = [[CommonViewController alloc] init];
  
  _guideVC = guideVC;
  _commonVC = commonVC;
  
  
  [AMapServices sharedServices].apiKey = @"d05b38af47c7d21a6394147df8c1d47a";
  
  [self loadJSPatch];
  [self loadWindow];
  [self login];
  
  // LeanCloud
  [AVOSCloud setApplicationId:@"SByqz6wT3QEg6cOrtuJKHN5s-gzGzoHsz" clientKey:@"w3MJt3xt8VuuSPNHdCy0D9yM"];
  [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions]; // 跟踪应用被打开的情况

  return YES;
}

- (void)loadWindow
{
  self.window = [[UIWindow alloc] init];
  self.window.frame = [UIScreen mainScreen].bounds;
  self.window.backgroundColor = [UIColor whiteColor];
  [self.window makeKeyAndVisible];
}

- (void)login
{
  [self loadADView];
}

- (void)loadADView
{
  self.window.rootViewController = _guideVC;
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(hiddenADView)
                                               name:kKillBrainClickSkipADNotification
                                             object:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(timeOfShowADIsOver)
                                               name:kKillBrainSkipADTimerOverNotification
                                             object:nil];
}

- (void)hiddenADView
{
  [self hiddenGuideView];
}

- (void)timeOfShowADIsOver
{
  [self hiddenGuideView];
}

- (void)hiddenGuideView
{
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animationADDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    self.window.rootViewController = _commonVC;
  });
}

- (BOOL)isFirstLogin
{
  BOOL firstLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"firstLogin"];
  if (!firstLogin) {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLogin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return YES;
  }
  else {
    return NO;
  }
}

- (void)loadJSPatch
{
//#if TARGET_IPHONE_SIMULATOR
//  NSString *rootPath = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"projectPath"];
//#else
//  NSString *rootPath = [[NSBundle mainBundle] bundlePath];
//#endif
//  NSString *scriptRootPath = [rootPath stringByAppendingPathComponent:@"Other"];
//  NSString *mainScriptPath = [NSString stringWithFormat:@"%@/%@", scriptRootPath, @"main.js"];
//  
//  NSLog(@"%@",mainScriptPath);
  
  NSString *path = [[NSBundle mainBundle] pathForResource:@"main" ofType:@"js"];
  
  [JPEngine evaluateScriptWithPath:path];
  
  
}

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
