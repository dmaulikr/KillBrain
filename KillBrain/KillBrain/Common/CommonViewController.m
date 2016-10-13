//
//  CommonViewController.m
//  KillBrain
//
//  Created by Li Kelin on 16/9/21.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "CommonViewController.h"
#import "GamesViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourViewController.h"
@interface CommonViewController ()

@end

@implementation CommonViewController

- (void)loadControllers
{
  GamesViewController *first = [[GamesViewController alloc] init];
  first.tabBarItem.title = @"First";
  first.tabBarItem.image = [[UIImage imageNamed:@"cart"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
  UINavigationController *fNav = [[UINavigationController alloc] initWithRootViewController:first];
  
  SecondViewController *sec = [[SecondViewController alloc] init];
  sec.tabBarItem.title = @"Second";
  sec.showType = ShowTypeModal;
  sec.tabBarItem.image = [[UIImage imageNamed:@"add"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
  
  ThirdViewController *thi = [[ThirdViewController alloc] init];
  thi.tabBarItem.title = @"Third";
  thi.tabBarItem.image = [[UIImage imageNamed:@"cart"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
  UINavigationController *tNav = [[UINavigationController alloc] initWithRootViewController:thi];

  
  [self addChildViewController:fNav];
  [self addChildViewController:sec];
  [self addChildViewController:tNav];
  
  self.animationed = YES;
  self.musical = YES;

}

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self loadControllers];
}

@end
