//
//  KKView+Common.m
//  KKF
//
//  Created by Li Kelin on 16/6/22.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "KKView+Common.h"

@implementation UIView (Common)

- (void)addBorder
{
  [self addBorderWithColor:[UIColor blackColor] width:1.0];
}

- (void)addBorderWithColor:(UIColor *)color
{
  [self addBorderWithColor:color width:1.0];
}

- (void)addBorderWithColor:(UIColor *)color width:(CGFloat)width
{
  self.layer.borderColor = color.CGColor;
  self.layer.borderWidth = width;
}

- (void)addShadow:(UIColor *)color offset:(CGSize)offset radius:(CGFloat)radius
{
  self.layer.shadowColor = color.CGColor;
  self.layer.shadowOffset = offset;
  self.layer.shadowOpacity = 1.0;
  self.layer.shadowRadius = radius;
  self.layer.shouldRasterize = YES;
  self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (void)removeBorder
{
  self.layer.borderWidth = 0;
  self.layer.borderColor = [UIColor clearColor].CGColor;
}

@end
