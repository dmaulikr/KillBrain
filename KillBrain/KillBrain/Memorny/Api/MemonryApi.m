//
//  MemonryApi.m
//  KillBrain
//
//  Created by Li Kelin on 16/9/1.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "MemonryApi.h"

@interface MemonryApi ()
@property (nonatomic, strong, readwrite) NSMutableArray *beforeReplaceArray;
@property (nonatomic, strong, readwrite) NSMutableArray *afterReplaceArray;
@property (nonatomic, assign, readwrite) NSInteger firstValue;
@property (nonatomic, assign, readwrite) NSInteger secondValue;
@end
@implementation MemonryApi

- (void)loadData:(void (^)())completion
{
  self.beforeReplaceArray = [NSMutableArray arrayWithArray:[self randomArray]];
  
  NSInteger indexOne = arc4random_uniform(10);
  NSInteger indexTwo = arc4random_uniform(10) + 10;
  
  id objOne = self.beforeReplaceArray[indexOne];
  id objTwo = self.beforeReplaceArray[indexTwo];
  
  _firstValue  = [objOne integerValue];
  _secondValue = [objTwo integerValue];
  
  self.afterReplaceArray = [NSMutableArray arrayWithArray:[self.beforeReplaceArray copy]];
  [self.afterReplaceArray replaceObjectAtIndex:indexOne withObject:objTwo];
  [self.afterReplaceArray replaceObjectAtIndex:indexTwo withObject:objOne];
  
  completion();
}

- (NSArray *)randomArray
{
  
  NSArray *origin = @[@"1",@"2",@"3",@"4",@"5",
                      @"6",@"7",@"8",@"9",@"10",
                      @"11",@"12",@"13",@"14",@"15",
                      @"16",@"17",@"18",@"19",@"20"
                      ];
  
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
  return origin;
}

@end
