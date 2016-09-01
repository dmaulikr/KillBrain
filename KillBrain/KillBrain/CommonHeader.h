//
//  CommonHeader.h
//  KillBrain
//
//  Created by Li Kelin on 16/8/20.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import <UIKit/UIKit.h>
#ifndef CommonHeader_h
#define CommonHeader_h

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenCenter CGPointMake(kScreenWidth * 0.5, kScreenHeight * 0.5)
#define UIFontWithSize(fontSize) [UIFont systemFontOfSize:fontSize]
#define kSmallFont UIFontWithSize(10)
#define kMiddleFont UIFontWithSize(14)
#define kLargeFont UIFontWithSize(18);
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

static const CGFloat animationDuration = 0.3;


NS_INLINE UIColor *whiteColor(){ return [UIColor whiteColor];}

NS_INLINE UIColor *blackColor(){ return [UIColor blackColor];}

NS_INLINE UIColor *redColor(){   return [UIColor redColor];}

NS_INLINE UIColor *clearColor(){ return [UIColor clearColor];}

NS_INLINE UIColor *grayColor(){ return [UIColor grayColor]; }

NS_INLINE UIColor *lightGrayColor(){ return [UIColor lightGrayColor];}

NS_INLINE UIColor *darkGrayColor(){ return [UIColor darkGrayColor];}

NS_INLINE UIColor *orangeColor(){ return [UIColor orangeColor];}

NS_INLINE UIColor *blueColor(){ return [UIColor blueColor];}

NS_INLINE UIColor *yellowColor(){ return [UIColor yellowColor];}

NS_INLINE UIColor *cyanColor(){ return [UIColor cyanColor];}

NS_INLINE UIColor *greenColor(){ return [UIColor greenColor];}

NS_INLINE UIColor *darkTextColor() {return [UIColor darkTextColor];}

NS_INLINE CGFloat headerHeight(){ return 64 ;}

NS_INLINE CGFloat viewHeight() {return kScreenHeight - 64;}

#endif