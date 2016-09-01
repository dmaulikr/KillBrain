//
//  TestAnswerView.m
//  KillBrain
//
//  Created by Li Kelin on 16/8/21.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "TestAnswerView.h"

@implementation TestAnswerView

+ (instancetype)anserView
{
  return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

- (IBAction)submitAnswer:(UIButton *)sender
{
  if (self.clickSubmitButton) {
    self.clickSubmitButton();
  }
}
@end
