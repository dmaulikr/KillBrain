//
//  MemonryApi.h
//  KillBrain
//
//  Created by Li Kelin on 16/9/1.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MemonryApi : NSObject

- (void)loadData:(void (^)())completion;
@property (nonatomic, strong, readonly) NSMutableArray *beforeReplaceArray;
@property (nonatomic, strong, readonly) NSMutableArray *afterReplaceArray;
@property (nonatomic, assign, readonly) NSInteger firstValue;
@property (nonatomic, assign, readonly) NSInteger secondValue;
@end
