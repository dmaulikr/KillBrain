//
//  UIViewController+KKExtension.m
//  KLTabBarController
//
//  Created by Li Kelin on 16/7/21.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "UIViewController+KKExtension.h"
#import <objc/runtime.h>
@implementation UIViewController (KKExtension)

- (void)setShowType:(ShowType)showType
{
  objc_setAssociatedObject(self, @selector(showType), @(showType), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ShowType)showType
{
  id res = objc_getAssociatedObject(self, @selector(showType));
  return [res integerValue];
}

@end
