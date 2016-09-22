//
//  CustomController.m
//  KillBrain
//
//  Created by Li Kelin on 16/9/1.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "CustomController.h"
#import "HandSpeedView.h"
@interface CustomController ()
@property (nonatomic, strong) HandSpeedView *handView;
@property (nonatomic, strong) NSTimer       *timer;
@property (nonatomic, assign) NSInteger     time;
@property (nonatomic, assign) NSInteger      tapCount;
@end

@implementation CustomController

- (void)viewDidLoad {
    [super viewDidLoad];

  self.view.backgroundColor = whiteColor();
  _handView = [[HandSpeedView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
  [self.view addSubview:_handView];
  
  _time = 10;
  _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(runTimer)  userInfo:nil repeats:YES];
  [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
  [_handView.tapDownButton addTarget:self action:@selector(tapDown:) forControlEvents:UIControlEventTouchDown];
  _handView.tapDownButton.enabled = NO;
}

- (void)tapDown:(UIButton *)sender
{
  _tapCount++;
  _handView.tapCountLabel.text = [NSString stringWithFormat:@"%ld",_tapCount];
}

- (void)runTimer
{
  _time--;
  _handView.timerLabel.text = [NSString stringWithFormat:@"倒计时：%ld秒",_time];
  _handView.tapDownButton.enabled = YES;
  if (_time <= 0) {
    [_timer invalidate];
    _timer = nil;
    _handView.tapDownButton.enabled = NO;
    _handView.timerLabel.text = [NSString stringWithFormat:@"时间到"];
  }
}
@end
