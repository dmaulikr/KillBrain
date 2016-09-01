//
//  Api.m
//  KillBrain
//
//  Created by Li Kelin on 16/9/1.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "WordsApi.h"

@implementation WordsApi

-(void)loadData:(void (^)(NSArray *))completion
{
  NSArray *origin = [self arrayOfStrings];
  // 使数组内的元素乱序排列
  origin = [origin sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
    int temp = arc4random_uniform(2);
    if (temp) {
      return [obj1 compare:obj2];
    }
    else {
      return [obj2 compare:obj1];
    }
  }];
  completion(origin);
}


- (NSArray *)resultApi
{
  return @[@"国,色,天,香",@"八,仙,过,海",@"皆,大,欢,喜",@"金,玉,良,缘",@"两,小,无,猜"];
}

- (NSArray *)arrayOfStrings
{
  NSArray *apiArray = [self resultApi];
  NSMutableArray *bigArray = [NSMutableArray array];
  [apiArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    NSArray *tempArr = [obj componentsSeparatedByString:@","];
    [bigArray addObjectsFromArray:tempArr];
  }];
  return [bigArray copy];
}


/*
 // 判断两个数组是否相等
 - (BOOL)originArray:(NSArray *)originArray destionArray:(NSArray *)destionArray
 {
 if (originArray.count != destionArray.count) {
 return NO;
 }
 
 for (int i = 0; i < originArray.count; i++) {
 if (originArray[i] != destionArray[i]) {
 return NO;
 }
 }
 return YES;
 }
 */

@end
