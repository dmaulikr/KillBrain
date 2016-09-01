//
//  FastCountView.m
//  KillBrain
//
//  Created by Li Kelin on 16/8/20.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "FastCountView.h"

#define kEachViewHeight (self.height - 100) / 3
@implementation FastCountView


- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {

    _numView = [[SelectNum alloc] init];
    [_numView addBorderWithColor:grayColor() width:2];
    
    _methodView = [[SelectMethod alloc] init];
    [_methodView addBorderWithColor:grayColor() width:2];
    
    _timerView = [[SelectTimeView alloc] init];
    [_timerView addBorderWithColor:grayColor() width:2];
    
    _showDataLabel = [[UILabel alloc] init];
    _showDataLabel.textAlignment = NSTextAlignmentCenter;
    _showDataLabel.textColor = blackColor();
    _showDataLabel.font = UIFontWithSize(15);
    _showDataLabel.backgroundColor = lightGrayColor();
    
    [self addSubview:_numView];
    [self addSubview:_methodView];
    [self addSubview:_timerView];
    [self addSubview:_showDataLabel];
    
    
  }
  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  
  _numView.frame = CGRectMake(5, 10, self.width - 10, kEachViewHeight);
  _methodView.frame = CGRectMake(5, CGRectGetMaxY(_numView.frame) + 10, self.width - 10, kEachViewHeight);
  _timerView.frame  = CGRectMake(5, CGRectGetMaxY(_methodView.frame) + 10, self.width - 10, kEachViewHeight);
  _showDataLabel.frame = CGRectMake(5, CGRectGetMaxY(_timerView.frame) + 20, self.width - 10, 40);
}
@end
