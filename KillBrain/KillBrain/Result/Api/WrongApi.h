//
//  WrongApi.h
//  KillBrain
//
//  Created by Li Kelin on 16/8/23.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WrongApi : NSObject

+ (instancetype)shareApi;
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, assign) NSInteger useTime;
@property (nonatomic, assign) NSInteger correctValue;
@property (nonatomic, copy) NSString *userValue;

@end
