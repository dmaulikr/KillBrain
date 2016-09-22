//
//  MyView.m
//  KillBrain
//
//  Created by Li Kelin on 16/9/19.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "MyLoginView.h"

@implementation MyLoginView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  [self endEditing:YES];
}
- (IBAction)login:(UIButton *)sender
{
  if (self.clickSubmitButton) {
    self.clickSubmitButton(sender);
  }
}

- (IBAction)dismissPassword:(UIButton *)sender
{
  if (self.clickForgetButton) {
    self.clickForgetButton(sender);
  }
}

- (IBAction)registerCount:(UIButton *)sender
{
  if (self.clickRegistButton) {
    self.clickRegistButton(sender);
  }
}
@end
