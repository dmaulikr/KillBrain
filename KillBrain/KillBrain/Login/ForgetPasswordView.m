//
//  ForgetView.m
//  KillBrain
//
//  Created by Li Kelin on 16/9/20.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "ForgetPasswordView.h"

@implementation ForgetPasswordView

- (IBAction)retPassword:(UIButton *)sender
{
  if (self.retPasswordButton) {
    self.retPasswordButton(sender);
  }
}

- (IBAction)sendCheckNum:(UIButton *)sender
{
  if (self.checkPhoneNumButton) {
    self.checkPhoneNumButton(sender);
  }
}
@end
