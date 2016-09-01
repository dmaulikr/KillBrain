//
//  FastCountProtocol.h
//  KillBrain
//
//  Created by Li Kelin on 16/8/20.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FastCountController.h"
#import "FastCountApi.h"
@interface FastCountProtocol : NSObject<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) FastCountController *viewController;
@property (nonatomic, strong) FastCountApi        *api;

@property (nonatomic, copy) void (^selectedBlock)(BOOL selected, NSArray <NSString *> * datas);

- (void)resetEnable;
@end
