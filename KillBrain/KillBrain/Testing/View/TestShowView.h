//
//  TestShowView.h
//  KillBrain
//
//  Created by Li Kelin on 16/8/20.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestShowView : UIView
@property (nonatomic, strong) UILabel *timerLabel;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *timeTipView;



- (void)showNumChangeViewWithImages:(NSArray *)images duration:(NSInteger)duration;
- (void)hiddenNumChangeView;

- (void)showTimeTipView;
- (void)hiddenTimeTipView;

- (void)addSnowAnimation;

- (void)removeSnowAnimation;
@end
