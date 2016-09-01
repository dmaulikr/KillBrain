//
//  TestApi.m
//  KillBrain
//
//  Created by Li Kelin on 16/8/23.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "TestApi.h"

@interface TestApi ()
@property (nonatomic, strong) NSMutableArray *nums;
@end
@implementation TestApi

- (NSInteger)numsWithStr:(NSString *)str
{
  if ([str isEqualToString:@"三位数"]) {
    return 3;
  }
  
  if ([str isEqualToString:@"四位数"]) {
    return 4;
  }
  
  if ([str isEqualToString:@"五位数"]) {
    return 5;
  }
  return 0;
}

- (void)valueWithMethod:(NSString *)method completion:(void (^)(NSArray *datas, NSInteger value))compelton
{
  __block NSInteger value = 0;
  if ([method isEqualToString:@"加法"]) {
    [self.nums enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
      value += [obj integerValue];
    }];
    compelton([self.nums copy], value);
  }
  
  if ([method isEqualToString:@"加减混合"]) {
    NSInteger count = arc4random_uniform(2)+1;
    for (int i = 0; i < count; i++) {
      NSInteger index = arc4random_uniform(8) + 1;
      NSInteger res = [self.nums[index] integerValue];
      [self.nums replaceObjectAtIndex:index withObject:@(res * -1)];
    }
    
    [self.nums enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
      value += [obj integerValue];
    }];
    compelton([self.nums copy], value);
  }
}

#pragma mark
#pragma mark - 产生随机数
- (void)productRandomNum:(NSInteger)num
{
  NSMutableArray *numArray = [NSMutableArray array];
  
  if (num == 3) {
    for (int i = 0; i < 10; i++) {
      NSInteger num = arc4random_uniform(899) + 100;
      [numArray addObject:@(num)];
    }
  }
  
  if (num == 4) {
    for (int i = 0; i < 10; i++) {
      NSInteger num = arc4random_uniform(8999) + 1000;
      [numArray addObject:@(num)];
    }
  }
  
  if (num == 5) {
    for (int i = 0; i < 10; i++) {
      NSInteger num = arc4random_uniform(89999) + 10000;
      [numArray addObject:@(num)];
    }
  }
  self.nums = [NSMutableArray arrayWithArray:numArray];
}


@end
