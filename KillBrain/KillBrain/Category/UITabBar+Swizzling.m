//
//  UITabBar+Swizzling.m
//  KLTabBarController
//
//  Created by Li Kelin on 16/7/21.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "UITabBar+Swizzling.h"
#import <objc/runtime.h>
#import "AppDelegate.h"
@implementation UITabBar (Swizzling)

+ (void)load
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    Class class = [self class];
    [self exchangeMethodsWithOriginalSelector:@selector(layoutSubviews) swizzledSelector:@selector(kl_layoutSubviews) class:class];
    [self exchangeMethodsWithOriginalSelector:@selector(hitTest:withEvent:) swizzledSelector:@selector(kl_hitTest:withEvent:) class:class];
    [self exchangeMethodsWithOriginalSelector:@selector(touchesBegan:withEvent:) swizzledSelector:@selector(kl_touchesBegan:withEvent:) class:class];
  });
}


+ (void)exchangeMethodsWithOriginalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector class:(Class)class
{
  Method original = class_getInstanceMethod(class, originalSelector);
  Method swizzled = class_getInstanceMethod(class, swizzledSelector);
  BOOL method = class_addMethod(class, originalSelector, method_getImplementation(swizzled), method_getTypeEncoding(swizzled));
  
  if (method) {
    class_replaceMethod(class, swizzledSelector, method_getImplementation(original), method_getTypeEncoding(original));
  }
  else{
    method_exchangeImplementations(original, swizzled);
  }
}

- (void)kl_layoutSubviews
{
  [self kl_layoutSubviews];
  CGFloat margin = 12, lTabBarButtonLabelHeight = 16;
  UIView *lTabBarImageView, *lTabBarButtonLabel;

  for (UIView *childView in self.subviews) {
    if (![childView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
      continue;
    }
    self.selectionIndicatorImage = [[UIImage alloc] init];
    [self bringSubviewToFront:childView];
    
    for (UIView *lTabBarItem in childView.subviews) {
      // 图片显示区域
      if ([lTabBarItem isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
        lTabBarImageView = lTabBarItem;
      }
      // 文字显示区域
      else if ([lTabBarItem isKindOfClass:NSClassFromString(@"UITabBarButtonLabel")]) {
        lTabBarButtonLabel = lTabBarItem;
      }
    }
    
    NSString *lTabBarButtonLabelText = ((UILabel *)lTabBarButtonLabel).text;
    CGFloat tabBarLabelH = CGRectGetHeight(lTabBarButtonLabel.bounds);
    CGFloat tabBarImageVH = CGRectGetHeight(lTabBarImageView.bounds);
    CGFloat y = CGRectGetHeight(self.bounds) - (tabBarLabelH + tabBarImageVH);
    
    if (y < 0) {
      if (lTabBarButtonLabelText.length == 0) {
        margin -= lTabBarButtonLabelHeight;
      }else {
        margin = 12;
      }
      childView.frame = CGRectMake(childView.frame.origin.x,y - margin,childView.frame.size.width,
                                   childView.frame.size.height - y + margin);
    } else {
      margin = MIN(margin, y);
    }
    
 }
}

- (UIView *)kl_hitTest:(CGPoint)point withEvent:(UIEvent *)event {
  if (!self.clipsToBounds && !self.hidden && self.alpha > 0) {
    UIView *result = [self kl_hitTest:point withEvent:event];
    if (result) {
      return result;
    } else {
      for (UIView *subview in self.subviews.reverseObjectEnumerator) {
        CGPoint subPoint = [subview convertPoint:point fromView:self];
        result = [subview hitTest:subPoint withEvent:event];
        if (result) {
          return result;
        }
      }
    }
  }
  return nil;
}

- (void)kl_touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [self kl_touchesBegan:touches withEvent:event];
  
  NSSet *allTouches = [event allTouches];
  UITouch *touch = [allTouches anyObject];
  CGPoint point = [touch locationInView:[touch view]];
  
  NSInteger tabCount = 0;
  for (UIView *childView in self.subviews) {
    if (![childView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
      continue;
    }
    
    tabCount++;
  }
  CGFloat width = [UIScreen mainScreen].bounds.size.width / tabCount;
  NSUInteger clickIndex = ceilf(point.x) / ceilf(width);
  
  UITabBarController *mainController = (UITabBarController *)[(AppDelegate *)[[UIApplication sharedApplication] delegate] window].rootViewController;
  [mainController setSelectedIndex:clickIndex];
}


@end
