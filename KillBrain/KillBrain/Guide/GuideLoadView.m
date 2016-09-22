//
//  GuideView.m
//  KillBrain
//
//  Created by Li Kelin on 16/9/21.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "GuideLoadView.h"

@implementation GuideLoadView

- (IBAction)skipButton:(UIButton *)sender
{
  if (self.clickSkipADButton) {
    self.clickSkipADButton();
  }
}


- (void)hiddenSkipButton
{
  self.skipButton.hidden = YES;
}
@end
