//
//  ThirdViewController.m
//  KillBrain
//
//  Created by Li Kelin on 16/9/21.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "ThirdViewController.h"

//#import "PDSearchHUD.h"
@interface ThirdViewController () //<PDSearchHUDDelegate>

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.view.backgroundColor = cyanColor();
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"位置" style:UIBarButtonItemStyleDone target:self action:@selector(handleItem)];
  

}

- (void)handleItem
{
  
}

@end
