//
//  UIViewController+KKExtension.h
//  KLTabBarController
//
//  Created by Li Kelin on 16/7/21.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ShowType) {
  ShowTypeDefult = 0, // 默认的方式
  ShowTypeModal       // 模态的方式
};

@interface UIViewController (KKExtension)
@property (nonatomic, assign) ShowType showType;
@end
