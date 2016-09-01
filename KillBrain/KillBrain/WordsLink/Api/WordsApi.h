//
//  Api.h
//  KillBrain
//
//  Created by Li Kelin on 16/9/1.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WordsApi : NSObject
- (NSArray *)resultApi;
- (void)loadData:(void (^)(NSArray *datas))completion;
@end
