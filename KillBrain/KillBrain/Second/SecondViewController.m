//
//  SecondViewController.m
//  KillBrain
//
//  Created by Li Kelin on 16/9/21.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "SecondViewController.h"
#import "RCTBundleURLProvider.h"
#import "RCTRootView.h"
@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor cyanColor];
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
  self.showType = ShowTypeModal;
  
  NSURL *jsCodeLocation;
  
//  jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index.ios" fallbackResource:nil];
  
  jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
  
  RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                      moduleName:@"KillBrain"
                                               initialProperties:nil
                                                   launchOptions:nil];
  rootView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64);
//  self.view = rootView;
  [self.view addSubview:rootView];
}

- (void)back
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
