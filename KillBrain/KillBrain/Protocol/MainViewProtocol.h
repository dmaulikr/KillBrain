//
//  MainViewProtocol.h
//  KillBrain
//
//  Created by Li Kelin on 16/8/20.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GamesViewController.h"
@interface MainViewProtocol : NSObject<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) GamesViewController *viewController;
@end
