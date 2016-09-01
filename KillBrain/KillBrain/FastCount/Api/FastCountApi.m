//
//  HomeApi.m
//  Slave
//
//  Created by Li Kelin on 16/8/19.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "FastCountApi.h"

@interface FastCountApi ()

@end
@implementation FastCountApi
- (NSArray *)nums
{
  return @[@"三位数",@"四位数",@"五位数"];
}

- (NSArray *)methods
{
  return @[@"加法",@"加减混合"];
}

- (NSArray *)times
{
  return @[@"3秒",@"4秒",@"5秒",@"6秒",@"7秒",@"8秒",@"9秒"];
}
@end
