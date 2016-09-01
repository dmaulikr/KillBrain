//
//  WrongApi.m
//  KillBrain
//
//  Created by Li Kelin on 16/8/23.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "WrongApi.h"

@implementation WrongApi

+ (instancetype)shareApi
{ static id api = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    api = [[self alloc] init];
  });
  return api;
}

- (NSString *)userValue
{
  if (_userValue.length == 0) {
    return @"你尚未填入任何数据";
  }
  else{
    return _userValue;
  }
}
@end
