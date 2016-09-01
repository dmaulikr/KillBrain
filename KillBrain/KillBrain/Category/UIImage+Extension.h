//
//  UIImage+Extension.h
//  EcoleanLive
//
//  Created by Li Kelin on 16/7/26.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
/**
 *  生成一张高斯模糊的图片
 *
 *  @param image 原图
 *  @param blur  模糊程度 (0~1)
 *
 *  @return 高斯模糊图片
 */
+ (UIImage *)blurImage:(UIImage *)image blur:(CGFloat)blur;

/**
 *  根据颜色生成一张图片
 *
 *  @param color 颜色
 *  @param size  图片大小
 *
 *  @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  生成圆角的图片
 *
 *  @param originImage 原始图片
 *  @param borderColor 边框原色
 *  @param borderWidth 边框宽度
 *
 *  @return 圆形图片
 */
+ (UIImage *)circleImage:(UIImage *)originImage borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

/**
 *  返回渲染后的图片
 *
 *  @param originImage 原始图片
 *
 *  @return 渲染后的图片
 */
+ (UIImage *)renderImage:(UIImage *)originImage;

+ (UIImage *)resizedImage:(NSString *)name;

+ (UIImage *)imageWithName:(NSString *)name;

/**
 *  给图片添加文字描述
 *
 *  @param img   原始图片
 *  @param text1 需要添加的文字
 *
 *  @return 图片
 */
+ (UIImage *)addText:(UIImage *)img text:(NSString *)text1;

@end
