//
//  TabBarViewController.h
//  KLTabBarController
//
//  Created by Li Kelin on 16/7/21.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KLTabBarViewController : UITabBarController

@property (nonatomic, assign) BOOL animationed;      // 点击tabBarItem实现显示动画 ，默认NO
@property (nonatomic, assign) BOOL musical;          // 点击tabBarItem是否播放音效 ，默认NO
@property (nonatomic, copy)   NSString *musicName;   // 音效的名称，在musical为YES的情况下才有效，而且musicName必须有值
@property (nonatomic, copy)   NSString *musicType;   // 可以为nil（在musicName包含音效类型的情况）

@end
