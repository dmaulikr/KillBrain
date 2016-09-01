//
//  MemonryController.m
//  KillBrain
//
//  Created by Li Kelin on 16/8/24.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "MemonryController.h"
#import "MemonryNumsView.h"
@interface MemonryController ()<MemonryNumsViewDelegate>
{
  CGFloat _originY;
}
@property (nonatomic, strong) MemonryNumsView *numView;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) NSMutableArray *beforeReplaceArray;
@property (nonatomic, strong) NSMutableArray *afterReplaceArray;

@property (nonatomic, assign) NSInteger watchTime;
@property (nonatomic, assign) NSInteger firstValue;
@property (nonatomic, assign) NSInteger secondValue;
@property (nonatomic, assign) NSInteger answerCount;
@end

@implementation MemonryController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.view.backgroundColor = whiteColor();
  
  _numView = [[MemonryNumsView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
  _numView.delegate = self;
  [self.view addSubview:_numView];
  _numView.countTimeLabel.text = [NSString stringWithFormat:@"游戏尚未开始，请点击开始按钮开始游戏"];

  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"开始" style:UIBarButtonItemStyleDone target:self action:@selector(beginAction)];

  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  _originY = self.view.y;
}

- (void)beginAction
{
  _watchTime = 10;
  _answerCount = 2;
  _numView.countTimeLabel.text = [NSString stringWithFormat:@"您的观察时间还剩%ld秒",_watchTime];
  [self productRandomNumsWithRandomArray:[self randomArray]];
  [self showTimer];
  self.navigationItem.rightBarButtonItem.enabled = NO;
  
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

- (void)countTimer
{
   _watchTime--;
   _numView.countTimeLabel.text = [NSString stringWithFormat:@"您的观察时间还剩%ld秒",_watchTime];

  if (_watchTime <= 0) {
    _numView.countTimeLabel.text = [NSString stringWithFormat:@"观察时间结束"];
    __weak typeof(self) wSelf = self;
    [_numView addCoverViewCompletion:^{
      __strong typeof(self) strongSelf = wSelf;
      [strongSelf.numView showNumButtonsViewWithArray:[strongSelf.afterReplaceArray copy] enable:YES];
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      [_numView removeCoverView];
      [_numView showLeaveCountLabel];
      _numView.leaveCountLabel.text = [NSString stringWithFormat:@"剩余答题次数还剩%ld次",_answerCount];
     self.title = [NSString stringWithFormat:@"%ld",_firstValue];
    });
    [self hiddenTimer];
  }
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



- (void)productRandomNumsWithRandomArray:(NSArray *)array;
{
  
  self.beforeReplaceArray = [NSMutableArray arrayWithArray:array];
  
  NSInteger indexOne = arc4random_uniform(10);
  NSInteger indexTwo = arc4random_uniform(10) + 10;
  
  id objOne = self.beforeReplaceArray[indexOne];
  id objTwo = self.beforeReplaceArray[indexTwo];
  
  _firstValue  = [objOne integerValue];
  _secondValue = [objTwo integerValue];
  
  self.afterReplaceArray = [NSMutableArray arrayWithArray:[self.beforeReplaceArray copy]];
  [self.afterReplaceArray replaceObjectAtIndex:indexOne withObject:objTwo];
  [self.afterReplaceArray replaceObjectAtIndex:indexTwo withObject:objOne];
  
  [_numView showNumButtonsViewWithArray:[self.beforeReplaceArray copy] enable:NO];

}

- (NSArray *)randomArray
{
  
  NSArray *origin = @[@"1",@"2",@"3",@"4",@"5",
                     @"6",@"7",@"8",@"9",@"10",
                     @"11",@"12",@"13",@"14",@"15",
                     @"16",@"17",@"18",@"19",@"20"
                     ];
  
  // 使数组内的元素乱序排列
  origin = [origin sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
    int temp = arc4random_uniform(2);
    if (temp) {
      return [obj1 compare:obj2];
    }
    else {
      return [obj2 compare:obj1];
    }
  }];
  return origin;
}

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  NSLog(@"%@",self);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  [self.view endEditing:YES];
}

- (void)memonryView:(MemonryNumsView *)memonryView didDeselectAtIndex:(NSInteger)index
{
  _numView.leaveCountLabel.text = [NSString stringWithFormat:@"剩余答题次数还剩%ld次",_answerCount];
  if (_answerCount <= 0) {
    [self gameOver];
  }
}

- (void)memonryView:(MemonryNumsView *)memonryView didSelectAtIndex:(NSInteger)index
{
  _answerCount--;
  _numView.leaveCountLabel.text = [NSString stringWithFormat:@"剩余答题次数还剩%ld次",_answerCount];
  NSString *answer = self.afterReplaceArray[index];
  if ([answer isEqualToString:[NSString stringWithFormat:@"%ld",_firstValue]] ||
      [answer isEqualToString:[NSString stringWithFormat:@"%ld",_secondValue]]) {
    [SVProgressHUD showSuccessWithStatus:@"恭喜，答案正确！"];
    [_numView hiddenLeaveCountLabel];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      [self.navigationController popViewControllerAnimated:YES];
    });
  }
  else {
    [SVProgressHUD showErrorWithStatus:@"答案错误！"];
  }

  if (_answerCount <=0 ) {
    [self gameOver];
  }

}

- (BOOL)memonryView:(MemonryNumsView *)memonryView isSelectedAtIndex:(NSInteger)index
{
  return YES;
}

- (void)gameOver
{
  _numView.leaveCountLabel.text = [NSString stringWithFormat:@"您的答题次数已用完，请重新开始游戏 (7s后自动回到首页)"];
  [self.numView showNumButtonsViewWithArray:[self.afterReplaceArray copy] enable:NO];
  
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self.navigationController popViewControllerAnimated:YES];
  });
}


@end
