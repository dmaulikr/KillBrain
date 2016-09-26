//
//  MemonryController.m
//  KillBrain
//
//  Created by Li Kelin on 16/8/24.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "MemonryController.h"
#import "MemonryNumsView.h"
#import "MemonryProtocol.h"
#import "MemonryApi.h"
#import <MAMapKit/MAMapKit.h>
@interface MemonryController () //<MAMapViewDelegate>
{
  CGFloat _originY;   // 此处虽然没有用到，但是写此变量的人对我意义重大，不可删除
}
@property (nonatomic, strong) MemonryNumsView *numView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) MemonryApi *api;

@property (nonatomic, assign) NSInteger watchTime;
@property (nonatomic, assign) NSInteger answerCount;

@property (nonatomic, strong) MemonryProtocol *protocol;
@end

@implementation MemonryController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.view.backgroundColor = whiteColor();
  
  _numView = [[MemonryNumsView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
  _numView.delegate = self.protocol;
  [self.view addSubview:_numView];
  _numView.countTimeLabel.text = [NSString stringWithFormat:@"游戏尚未开始，请点击开始按钮开始游戏"];

  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"开始"
                                                                            style:UIBarButtonItemStyleDone
                                                                           target:self
                                                                           action:@selector(beginAction)];

}

- (void)beginAction
{
  _watchTime = memonryNeedTime;
  _answerCount = memonryNeedAnswerCount;
  _numView.countTimeLabel.text = [NSString stringWithFormat:@"您的观察时间还剩%ld秒",_watchTime];
  [self.api loadData:^{
    [_numView showNumButtonsViewWithArray:[self.api.beforeReplaceArray copy] enable:NO];
    [self showTimer];
    self.navigationItem.rightBarButtonItem.enabled = NO;
  }];
}

- (void)countTimer
{
   _watchTime--;
   _numView.countTimeLabel.text = [NSString stringWithFormat:@"您的观察时间还剩%ld秒",_watchTime];
  if (_watchTime <= 0) {
    [self timerIsEnd];
  }
}

- (void)timerIsEnd
{
  _numView.countTimeLabel.text = [NSString stringWithFormat:@"观察时间结束"];
  __weak typeof(self) wSelf = self;
  [_numView addCoverViewCompletion:^{
    __strong typeof(self) strongSelf = wSelf;
    [strongSelf.numView showNumButtonsViewWithArray:[strongSelf.api.afterReplaceArray copy] enable:YES];
  }];
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [_numView removeCoverView];
    [_numView showLeaveCountLabel];
    _numView.leaveCountLabel.text = [NSString stringWithFormat:@"剩余答题次数还剩%ld次",_answerCount];
    self.title = [NSString stringWithFormat:@"%ld",self.api.firstValue];
  });
  [self hiddenTimer];

}

- (void)showTimer
{
  _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(countTimer) userInfo:nil repeats:YES];
  [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)hiddenTimer
{
  if (_timer) {
    [_timer invalidate];
    _timer = nil;
  }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  [self.view endEditing:YES];
}

- (void)didDeselectAtIndex:(NSInteger)index
{
  _numView.leaveCountLabel.text = [NSString stringWithFormat:@"剩余答题次数还剩%ld次",_answerCount];
  if (_answerCount <= 0) {
    [self gameOver];
  }
}

- (void)didSelectAtIndex:(NSInteger)index
{
  _answerCount--;
  _numView.leaveCountLabel.text = [NSString stringWithFormat:@"剩余答题次数还剩%ld次",_answerCount];
  [self judgeAnswerIsTrueOrFalseWithIndex:index];
  if (_answerCount <=0 ) {
    [self gameOver];
  }
}

- (void)judgeAnswerIsTrueOrFalseWithIndex:(NSInteger)index
{
  NSString *answer = self.api.afterReplaceArray[index];
  if ([answer isEqualToString:[NSString stringWithFormat:@"%ld",self.api.firstValue]] ||
      [answer isEqualToString:[NSString stringWithFormat:@"%ld",self.api.secondValue]]) {
    [self answerIsCorrect];
  }
  else {
    [self answerIsFalse];
  }
}

- (void)answerIsCorrect
{
  [SVProgressHUD showSuccessWithStatus:@"恭喜，答案正确！"];
  [_numView hiddenLeaveCountLabel];
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self.navigationController popViewControllerAnimated:YES];
  });
}

- (void)answerIsFalse
{
  [SVProgressHUD showErrorWithStatus:@"答案错误！"];
}

- (BOOL)isSelectedAtIndex:(NSInteger)index
{
  return YES;
}

- (void)gameOver
{
  _numView.leaveCountLabel.text = [NSString stringWithFormat:@"您的答题次数已用完，请重新开始游戏 (7s后自动回到首页)"];
  [self.numView showNumButtonsViewWithArray:[self.api.afterReplaceArray copy] enable:NO];
  
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self.navigationController popViewControllerAnimated:YES];
  });
}

- (MemonryProtocol *)protocol
{
  if (!_protocol) {
    _protocol = [[MemonryProtocol alloc] init];
    _protocol.controller = self;
  }
  return _protocol;
}

- (MemonryApi *)api
{
  if (!_api) {
    _api = [[MemonryApi alloc] init];
  }
  return _api;
}

/*

// TODO: 此处对键盘的显示和隐藏进行了监听，（后来修改了代码逻辑，并没有使用到）
- (void)addKeyBoardObservers
{
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  _originY = self.view.y;
}


- (void)keyboardShow:(NSNotification *)noti
{
  NSDictionary *dict = noti.userInfo;
  CGRect frame = [[dict objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
  
  self.view.y = _originY - frame.size.height;
}

- (void)keyboardHidden:(NSNotification *)noti
{
  self.view.y = _originY;
}
 
- (void)dealloc
{
 [[NSNotificationCenter defaultCenter] removeObserver:self];
}

 
*/

@end
