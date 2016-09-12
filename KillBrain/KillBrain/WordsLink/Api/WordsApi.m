//
//  Api.m
//  KillBrain
//
//  Created by Li Kelin on 16/9/1.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "WordsApi.h"

@interface WordsApi ()
@property (nonatomic, strong) NSMutableArray *sourceData;
@end
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

/**
 *  随机生成5个成语
 */
- (NSArray *)resultApi
{
  return self.sourceData;
}

- (NSMutableArray *)sourceData
{
  if (!_sourceData) {
    NSMutableSet *set = [NSMutableSet set];
    while ([set count] < 5) {
      NSInteger index = arc4random() % [self sources].count;
      [set addObject:[[self sources] objectAtIndex:index]];
    }
    _sourceData = [NSMutableArray arrayWithArray:[set allObjects]];
  }
  return _sourceData;
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

// TODO:所有的成语（后期需要进行处理）
- (NSArray *)sources
{
  return @[@"左,顾,右,盼",@"走,马,观,花",@"趋,之,若,鹜",@"语,重,心,长",@"步,步,为,营",
           @"叶,公,好,龙",@"天,下,无,双",@"海,阔,天,空",@"情,非,得,已",@"满,腹,经,纶",
           @"偷,天,换,日",@"花,花,公,子",@"生,财,有,道",@"高,山,流,水",@"落,叶,归,根",
           @"亡,羊,补,牢",@"千,军,万,马",@"滥,竽,充,数",@"一,见,钟,情",@"风,花,雪,月",
           @"国,色,天,香",@"八,仙,过,海",@"皆,大,欢,喜",@"金,玉,良,缘",@"两,小,无,猜"];
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
