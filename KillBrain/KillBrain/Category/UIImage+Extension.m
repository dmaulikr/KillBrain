//
//  UIImage+Extension.m
//  EcoleanLive
//
//  Created by Li Kelin on 16/7/26.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "UIImage+Extension.h"
#import <Accelerate/Accelerate.h>

@implementation UIImage (Extension)
+ (UIImage *)blurImage:(UIImage *)image blur:(CGFloat)blur;
{
  // 模糊度越界
  if (blur < 0.f || blur > 1.f) {
    blur = 0.5f;
  }
  int boxSize = (int)(blur * 40);
  boxSize = boxSize - (boxSize % 2) + 1;
  CGImageRef img = image.CGImage;
  vImage_Buffer inBuffer, outBuffer;
  vImage_Error error;
  void *pixelBuffer;
  //从CGImage中获取数据
  CGDataProviderRef inProvider = CGImageGetDataProvider(img);
  CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
  //设置从CGImage获取对象的属性
  inBuffer.width = CGImageGetWidth(img);
  inBuffer.height = CGImageGetHeight(img);
  inBuffer.rowBytes = CGImageGetBytesPerRow(img);
  
  inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
  
  pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                       CGImageGetHeight(img));
  
  if(pixelBuffer == NULL)
    NSLog(@"No pixelbuffer");
  
  outBuffer.data = pixelBuffer;
  outBuffer.width = CGImageGetWidth(img);
  outBuffer.height = CGImageGetHeight(img);
  outBuffer.rowBytes = CGImageGetBytesPerRow(img);
  
  error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
  
  if (error) {
    NSLog(@"error from convolution %ld", error);
  }
  
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  CGContextRef ctx = CGBitmapContextCreate(
                                           outBuffer.data,
                                           outBuffer.width,
                                           outBuffer.height,
                                           8,
                                           outBuffer.rowBytes,
                                           colorSpace,
                                           kCGImageAlphaNoneSkipLast);
  CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
  UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
  
  CGContextRelease(ctx);
  CGColorSpaceRelease(colorSpace);
  
  free(pixelBuffer);
  CFRelease(inBitmapData);
  
  CGColorSpaceRelease(colorSpace);
  CGImageRelease(imageRef);
  
  return returnImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
  if (color) {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
  }
  return nil;
}

+ (UIImage *)circleImage:(UIImage *)originImage borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth
{
  //设置边框宽度
  CGFloat imageWH = originImage.size.width;
  
  //计算外圆的尺寸
  CGFloat ovalWH = imageWH + 2 * borderWidth;
  
  //开启上下文
  UIGraphicsBeginImageContextWithOptions(originImage.size, NO, 0);
  
  //画一个大的圆形
  UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, ovalWH, ovalWH)];
  
  [borderColor set];
  
  [path fill];
  
  //设置裁剪区域
  UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderWidth, borderWidth, imageWH, imageWH)];
  [clipPath addClip];
  
  //绘制图片
  [originImage drawAtPoint:CGPointMake(borderWidth, borderWidth)];
  
  //从上下文中获取图片
  UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
  
  //关闭上下文
  UIGraphicsEndImageContext();
  return resultImage;
}

+ (UIImage *)renderImage:(UIImage *)originImage
{
  UIImage *image = [originImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
  return image;
}

+ (UIImage *)imageWithName:(NSString *)name
{
  UIImage *image = nil;
  if ([[UIDevice currentDevice].systemVersion floatValue] > 7.0) { // 处理iOS7的情况
    NSString *newName = [name stringByAppendingString:@"_os7"];
    image = [UIImage imageNamed:newName];
  }
  
  if (image == nil) {
    image = [UIImage imageNamed:name];
  }
  return image;
}


+ (UIImage *)resizedImage:(NSString *)name
{
  UIImage *image = [UIImage imageWithName:name];
  return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}


+ (UIImage *)addText:(UIImage *)img text:(NSString *)text1

{
  //get image width and height
  
  int w = img.size.width;
  
  int h = img.size.height;
  
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  
  //create a graphic context with CGBitmapContextCreate
  
  CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
  
  CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
  
  CGContextSetRGBFillColor(context, 0.0, 1.0, 1.0, 1);
  
  char* text = (char *)[text1 cStringUsingEncoding:NSASCIIStringEncoding];
  
  CGContextSelectFont(context, "Georgia", 30, kCGEncodingMacRoman);
  
  CGContextSetTextDrawingMode(context, kCGTextFill);
  
  CGContextSetRGBFillColor(context, 255, 0, 0, 1);
  
  CGContextShowTextAtPoint(context, w/2-strlen(text)*8, h/2, text, strlen(text));
  
  //Create image ref from the context
  
  CGImageRef imageMasked = CGBitmapContextCreateImage(context);
  
  CGContextRelease(context);
  
  CGColorSpaceRelease(colorSpace);

  return [UIImage imageWithCGImage:imageMasked];
  
}

@end
