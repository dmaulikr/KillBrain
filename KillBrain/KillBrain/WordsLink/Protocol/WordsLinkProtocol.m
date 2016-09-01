//
//  WordsLinkProtocol.m
//  KillBrain
//
//  Created by Li Kelin on 16/9/1.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "WordsLinkProtocol.h"

@implementation WordsLinkProtocol
- (void)wordView:(WordsMainView *)wordView didDeselectItemAtIndex:(NSInteger)index
{
  [self.controller handleDatasWhenDidDeselectItemAtIndex:index];
}

- (void)wordView:(WordsMainView *)wordView didSelectItemAtIndex:(NSInteger)index
{
  
  // TODO:判断所选答案是否正确，如果正确，那么隐藏所选按钮，如果不正确则提示答案不正确，并进行进一步的处理
  [self.controller handleDatasWhenDidSelectItem:index];
}

- (NSString *)wordView:(WordsMainView *)wordView titleForItemAtIndex:(NSInteger)index
{
  return self.controller.datas[index];
}

- (NSInteger)numbersOfItemsInWordView:(WordsMainView *)wordView
{
  return self.controller.datas.count;
}

- (BOOL)wordView:(WordsMainView *)wordView isShowItemAtIndex:(NSInteger)index
{
  return  [self.controller handleDatasWhenIsShowItemAtIndex:index];
}

- (BOOL)wordView:(WordsMainView *)wordView isEnableForItemAtIndex:(NSInteger)index
{
  
  if (self.controller.gameOver) {
    return NO;
  }
  return YES;
}

@end
