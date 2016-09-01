//
//  MainViewProtocol.h
//  KillBrain
//
//  Created by Li Kelin on 16/8/20.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainViewController.h"
@interface MainViewProtocol : NSObject<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) MainViewController *viewController;
@end
