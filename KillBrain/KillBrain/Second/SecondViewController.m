//
//  SecondViewController.m
//  KillBrain
//
//  Created by Li Kelin on 16/9/21.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor cyanColor];
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
  self.showType = ShowTypeModal;
}

- (void)back
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
