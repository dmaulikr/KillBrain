//
//  RegisterView.m
//  KillBrain
//
//  Created by Li Kelin on 16/9/20.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "MyRegisterView.h"

@implementation MyRegisterView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  [self endEditing:YES];
}

- (IBAction)sendPhoneNum:(UIButton *)sender
{
  if (self.clickSendNumsButton) {
    self.clickSendNumsButton(sender);
  }
}
- (IBAction)completeRegist:(UIButton *)sender
{
  if (self.clickCompleteButton) {
    self.clickCompleteButton(sender);
  }
}

@end
