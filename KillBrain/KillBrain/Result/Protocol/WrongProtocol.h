//
//  WrongProtocol.h
//  KillBrain
//
//  Created by Li Kelin on 16/8/23.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WrongApi.h"
@interface WrongProtocol : NSObject<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) WrongApi *api;
@end
