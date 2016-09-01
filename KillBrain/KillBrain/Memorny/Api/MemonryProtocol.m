//
//  MemonryProtocol.m
//  KillBrain
//
//  Created by Li Kelin on 16/9/1.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "MemonryProtocol.h"

@implementation MemonryProtocol
- (void)memonryView:(MemonryNumsView *)memonryView didDeselectAtIndex:(NSInteger)index
{
  [self.controller didDeselectAtIndex:index];
}

- (void)memonryView:(MemonryNumsView *)memonryView didSelectAtIndex:(NSInteger)index
{
  [self.controller didSelectAtIndex:index];
}

- (BOOL)memonryView:(MemonryNumsView *)memonryView isSelectedAtIndex:(NSInteger)index
{
  return [self.controller isSelectedAtIndex:index];
}

@end
