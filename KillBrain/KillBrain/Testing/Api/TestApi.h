//
//  TestApi.h
//  KillBrain
//
//  Created by Li Kelin on 16/8/23.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestApi : NSObject
- (NSInteger)numsWithStr:(NSString *)str;
- (void)valueWithMethod:(NSString *)method completion:(void (^)(NSArray *datas, NSInteger value))compelton;
- (void)productRandomNum:(NSInteger)num;
@end
