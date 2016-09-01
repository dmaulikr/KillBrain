//
//  TestShowView.m
//  KillBrain
//
//  Created by Li Kelin on 16/8/20.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "TestShowView.h"

@interface TestShowView ()
@property (nonatomic, strong) CALayer *aLayer;
@property (nonatomic, strong) CAEmitterLayer *snowEmitter;
@end
@implementation TestShowView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    _timerLabel = [[UILabel alloc] init];
    _timerLabel.backgroundColor = blackColor();
    _timerLabel.textAlignment = NSTextAlignmentCenter;
    _timerLabel.textColor = whiteColor();
    _timerLabel.hidden = YES;
    
    _imageView = [[UIImageView alloc] init];
    _imageView.hidden = YES;
    
    _timeTipView = [[UIImageView alloc] init];
    _timeTipView.contentMode = UIViewContentModeScaleAspectFit;
    _timeTipView.hidden = YES;
    


    [self addSubview:_timeTipView];
    [self addSubview:_imageView];
    [self addSubview:_timerLabel];
  }
  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  _timerLabel.frame = CGRectMake(10, 10, self.width - 20, 40);
  _imageView.centerX = self.center.x;
  _imageView.centerY = self.centerY - 64;
  _imageView.width  = self.width * 0.8;
  _imageView.height = self.width * 0.8;
  
  _timeTipView.centerX = self.center.x;
  _timeTipView.centerY = self.centerY - 64;
  _timeTipView.width  = 100;
  _timeTipView.height = 100;
  
}

- (void)showTimeTipView
{
  _timeTipView.hidden = NO;
  _timeTipView.animationImages = @[
                                   [UIImage imageNamed:@"time3"],
                                   [UIImage imageNamed:@"time2"],
                                   [UIImage imageNamed:@"time1"],
                                   [UIImage imageNamed:@"time0"],
                                   [UIImage imageNamed:@"go"]
                                   ];
  _timeTipView.animationRepeatCount = 1;
  _timeTipView.animationDuration = 5;
  [_timeTipView startAnimating];
 
}

- (void)hiddenTimeTipView
{
  if (_timeTipView) {
    _timeTipView.hidden = YES;
    [_timeTipView stopAnimating];
    [_timeTipView removeFromSuperview];
    _timeTipView = nil;
  }

}

- (void)showNumChangeViewWithImages:(NSArray *)images duration:(NSInteger)duration
{
  _imageView.hidden = NO;
  _imageView.animationImages = images;
  _imageView.animationDuration = duration;
  _imageView.animationRepeatCount = 1;
  [_imageView startAnimating];
  
}

- (void)hiddenNumChangeView
{
  if (_imageView) {
    _imageView.hidden = YES;
    [_imageView stopAnimating];
    [_imageView removeFromSuperview];
    _imageView = nil;
  }

}

// 添加雪花动画
- (void)addSnowAnimation
{
  self.backgroundColor = [UIColor whiteColor];
  
  // 创建粒子Layer
  CAEmitterLayer *snowEmitter = [CAEmitterLayer layer];
  
  // 粒子发射位置
  snowEmitter.emitterPosition = CGPointMake(120,0);
  
  // 发射源的尺寸大小
  snowEmitter.emitterSize     = self.bounds.size;
  
  // 发射模式
  snowEmitter.emitterMode     = kCAEmitterLayerSurface;
  
  // 发射源的形状
  snowEmitter.emitterShape    = kCAEmitterLayerLine;
  
  // 创建雪花类型的粒子
  CAEmitterCell *snowflake    = [CAEmitterCell emitterCell];
  
  // 粒子的名字
  snowflake.name = @"snow";
  
  // 粒子参数的速度乘数因子
  snowflake.birthRate = 20.0;
  snowflake.lifetime  = 120.0;
  
  // 粒子速度
  snowflake.velocity  = 10.0;
  
  // 粒子的速度范围
  snowflake.velocityRange = 10;
  
  // 粒子y方向的加速度分量
  snowflake.yAcceleration = 2;
  
  // 周围发射角度
  snowflake.emissionRange = 0.5 * M_PI;
  
  // 子旋转角度范围
  snowflake.spinRange = 0.25 * M_PI;
  snowflake.contents  = (id)[[UIImage imageNamed:@"snow"] CGImage];
  
  // 设置雪花形状的粒子的颜色
  snowflake.color      = [[UIColor whiteColor] CGColor];
  snowflake.redRange   = 1.5f;
  snowflake.greenRange = 2.2f;
  snowflake.blueRange  = 2.2f;
  
  snowflake.scaleRange = 0.6f;
  snowflake.scale      = 0.7f;
  
  snowEmitter.shadowOpacity = 1.0;
  snowEmitter.shadowRadius  = 0.0;
  snowEmitter.shadowOffset  = CGSizeMake(0.0, 0.0);
  
  // 粒子边缘的颜色
  snowEmitter.shadowColor  = [[UIColor whiteColor] CGColor];
  
  // 添加粒子
  snowEmitter.emitterCells = @[snowflake];
  
  // 将粒子Layer添加进图层中
  [self.layer addSublayer:snowEmitter];
  // 形成遮罩
  UIImage *image      = [UIImage imageNamed:@"alpha"];
  _aLayer              = [CALayer layer];
  _aLayer.frame        = (CGRect){CGPointZero, self.bounds.size};
  _aLayer.contents     = (__bridge id)(image.CGImage);
  _aLayer.position     = self.center;
  snowEmitter.mask    = _aLayer;
  self.snowEmitter = snowEmitter;
}

- (void)removeSnowAnimation
{
  [self.snowEmitter removeFromSuperlayer];
  self.snowEmitter = nil;
}
@end
