//
//  KKView+Common.h
//  KKF
//
//  Created by Li Kelin on 16/6/22.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Common)

/**
 *  给当前的视图添加边框
 *  defult 颜色：灰色  宽度：1.0
 */

- (void)addBorder;

/**
 *  给当前的视图添加边框
 *
 *  @defult 宽度：1.0
 */
- (void)addBorderWithColor:(UIColor *)color;

/**
 *  给当前的视图添加边框
 */
- (void)addBorderWithColor:(UIColor *)color width:(CGFloat)width;

/**
 *  添加阴影
 */
- (void)addShadow:(UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius;

/**
 * 移除边框
 */
- (void)removeBorder;

@end
