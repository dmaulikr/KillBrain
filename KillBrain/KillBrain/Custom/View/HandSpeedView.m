//
//  HandSpeedView.m
//  KillBrain
//
//  Created by Li Kelin on 16/9/12.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "HandSpeedView.h"

@interface HandSpeedView ()
{
  UIImage  *_image;
}
@end
@implementation HandSpeedView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    _timerLabel = [[UILabel alloc] init];
    _timerLabel.backgroundColor = lightGrayColor();
    _timerLabel.textColor = whiteColor();
    _timerLabel.textAlignment = NSTextAlignmentCenter;
    _timerLabel.font = UIFontWithSize(14);
    
    _tapCountLabel = [[UILabel alloc] init];
    _tapCountLabel.backgroundColor = cyanColor();
    _tapCountLabel.textColor = blackColor();
    _tapCountLabel.textAlignment = NSTextAlignmentCenter;
    _tapCountLabel.font = UIFontWithSize(18);
    
    _tapDownButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage circleImage:[UIImage imageNamed:@"tap"] borderColor:clearColor() borderWidth:0.1];
    [_tapDownButton setImage:image forState:UIControlStateNormal];
    [_tapDownButton setContentMode:UIViewContentModeScaleAspectFit];
    _image = image;
    
    [self addSubview:_tapDownButton];
    [self addSubview:_timerLabel];
    [self addSubview:_tapCountLabel];
  }
  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  _timerLabel.frame = CGRectMake(10, 10, self.width - 20, 40);
  _tapCountLabel.frame = CGRectMake(self.width - 70, CGRectGetMaxY(_timerLabel.frame) + 10, 60, 60);
  _tapDownButton.centerX = (self.width - _image.size.width)/2;
  _tapDownButton.centerY = (self.height - _image.size.height)/2;
  _tapDownButton.width = _image.size.width;
  _tapDownButton.height = _image.size.height;
}

@end
