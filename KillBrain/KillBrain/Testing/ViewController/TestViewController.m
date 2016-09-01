//
//  TestViewController.m
//  KillBrain
//
//  Created by Li Kelin on 16/8/20.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "TestViewController.h"
#import "TestShowView.h"
#import "TestAnswerView.h"
#import "ResultController.h"
#import "TestApi.h"
#include "WrongApi.h"
@interface TestViewController ()
@property (nonatomic, strong) TestShowView *testView;
@property (nonatomic, strong) NSTimer  *timer;
@property (nonatomic, strong) NSTimer  *answerTimer;
@property (nonatomic, assign) CGFloat   tempTime;
@property (nonatomic, assign) NSInteger tempNums;
@property (nonatomic, assign) NSInteger value;
@property (nonatomic, assign) NSInteger deadTime;
@property (nonatomic, assign) NSString *tempMethod;
@property (nonatomic, strong) NSMutableArray *nums;
@property (nonatomic, strong) NSMutableArray *images;

@property (nonatomic, strong) TestAnswerView *answerView;
@property (nonatomic, strong) UIView   *line1;
@property (nonatomic, strong) UIView   *line2;

@property (nonatomic, strong) TestApi  *api;
@property (nonatomic, strong) WrongApi *wrongApi;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  self.view.backgroundColor = whiteColor();
  self.title = @"迎接挑战吧";
  _testView = [[TestShowView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];

  [self.view addSubview:_testView];
  
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:self action:@selector(doNothing)];
  self.navigationItem.leftBarButtonItem.enabled = NO;
  
  _deadTime = 60;
  
  [self loadData];
  [self productImagae];
  [self loadSubView];

  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(backToRootView)
                                               name:UIApplicationDidEnterBackgroundNotification
                                             object:nil];
}


- (void)backToRootView
{
  [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:UIApplicationDidEnterBackgroundNotification
                                                object:nil];

}

- (void)doNothing
{
  
}

- (void)loadSubView
{
  [_testView addSnowAnimation];
  [_testView showTimeTipView];
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [_testView hiddenTimeTipView];
    [_testView removeSnowAnimation];
    // 倒计时开始，显示随机数
    [self showTimer];
    [self startShowTextAnimation];
  });
}

- (void)startShowTextAnimation
{
  [self.testView showNumChangeViewWithImages:self.images duration:[self.datas[2] integerValue]];
}

- (void)productImagae
{
  [self.nums enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    UIImage *ori = [UIImage imageWithColor:lightGrayColor() size:CGSizeMake(200, 200)];
    UIImage *image = [UIImage addText:ori text:[NSString stringWithFormat:@"%@",obj]];
    [self.images addObject:image];
  }];
}

#pragma mark
#pragma mark - 加载数据 （选择位数、计算方式、答题时间）
- (void)loadData
{
  _tempNums = [self.api numsWithStr:self.datas[0]];
  _tempMethod = self.datas[1];
  _tempTime = [self.datas[2] floatValue];
  [self.api productRandomNum:_tempNums];
  [self.api valueWithMethod:_tempMethod completion:^(NSArray *datas, NSInteger value) {
    _value = value;
    self.nums = [NSMutableArray arrayWithArray:datas];
  }];
  

}

#pragma mark
#pragma mark - 显示倒计时器
- (void)showTimer
{
  _testView.timerLabel.hidden = NO;
  _timer = [NSTimer timerWithTimeInterval:0.01 target:self selector:@selector(countNum) userInfo:nil repeats:YES];
  [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
  
}

#pragma mark
#pragma mark - 隐藏倒计时器
- (void)hiddenTimer
{
  _testView.timerLabel.hidden = YES;
  if (_timer) {
    [_timer invalidate];
    _timer = nil;
  }
}

- (void)countNum
{
  _tempTime -= 0.01;
  _testView.timerLabel.text = [NSString stringWithFormat:@"%.2f",_tempTime];
  
  if (_tempTime <= 0) {
    [self hiddenTimer];
    _testView.timerLabel.text = [NSString stringWithFormat:@"0.00"];
    [self.testView hiddenNumChangeView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      [self showAnswerView];
    });
  }
}

- (NSMutableArray *)images
{
  if (!_images) {
    _images = [NSMutableArray array];
  }
  return _images;
}

#pragma mark
#pragma mark - 显示提交答案提示框
- (void)showAnswerView
{
  [UIView animateWithDuration:.4 delay:.1 usingSpringWithDamping:.4 initialSpringVelocity:.7 options:UIViewAnimationOptionAllowUserInteraction animations:^{
    self.answerView.y = 200;
    self.line1.height = 200;
    self.line2.height = 200;
  } completion:^(BOOL finished) {
    [self showAnswerTimer];
  }];
}

- (void)showAnswerTimer
{
  _answerTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerReduce) userInfo:nil repeats:YES];
  [[NSRunLoop currentRunLoop] addTimer:_answerTimer forMode:NSRunLoopCommonModes];
}

- (void)removeAnswerTimerIfExits
{
  [_answerTimer invalidate];
  _answerTimer = nil;
}

- (void)timerReduce
{
  _deadTime --;
  _answerView.timerLabel.text = [NSString stringWithFormat:@"您的作答时间还有%ld秒",_deadTime];
  if (_deadTime < 0) {
  _answerView.timerLabel.text = [NSString stringWithFormat:@"您的作答时间已结束"];
    [self removeAnswerTimerIfExits];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      [self removeAnswerViews];
      [self.navigationController popViewControllerAnimated:YES];
    });
  }
}

#pragma mark
#pragma mark - 隐藏提交答案提示框
- (void)hiddenAnswerView
{
  [UIView animateWithDuration:.4 delay:.1 usingSpringWithDamping:.4 initialSpringVelocity:.7 options:UIViewAnimationOptionAllowUserInteraction animations:^{
    self.answerView.y = -104;
    self.line1.height = 1;
    self.line2.height = 1;
  } completion:^(BOOL finished) {
    [self removeAnswerViews];
  }];

}


- (void)removeAnswerViews
{
  [_answerView removeFromSuperview];
  [_line1 removeFromSuperview];
  [_line2 removeFromSuperview];
  
  _answerView = nil;
  _line1 = nil;
  _line2 = nil;
}


- (TestAnswerView *)answerView
{
  if (!_answerView) {
    _answerView = [TestAnswerView anserView];
    _answerView.frame = CGRectMake((kScreenWidth - 328)/2, -104, 328, 104);
    _answerView.answerTextFiled.text = [NSString stringWithFormat:@"%ld",_value];
    [_answerView addBorderWithColor:lightGrayColor() width:.8];
    [self.view addSubview:_answerView];
    [self didClickSubmitButton];
  }
  return _answerView;
}

#pragma mark 
#pragma mark - 点击提交答案按钮
- (void)didClickSubmitButton
{
  __weak typeof(self) wSelf = self;
  [_answerView setClickSubmitButton:^{
    __strong typeof(self) strongSelf = wSelf;
    NSString *userValue = strongSelf.answerView.answerTextFiled.text;
    NSString *realValue = [NSString stringWithFormat:@"%ld",strongSelf.value];
    BOOL correct = [userValue isEqualToString:realValue];
    [strongSelf saveData];
    [strongSelf removeAnswerTimerIfExits];
    [strongSelf hiddenAnswerView];
    [SVProgressHUD showImage:[UIImage imageNamed:@"log"] status:@"正在核对答案。。。"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      [SVProgressHUD dismiss];
      ResultController *result = [[ResultController alloc] init];
      result.corrected = correct;
      [strongSelf.navigationController pushViewController:result animated:YES];
    });
    
  }];

}

- (void)saveData
{
  self.wrongApi.datas = [self.nums copy];
  self.wrongApi.useTime = 60 - self.deadTime;
  self.wrongApi.userValue = self.answerView.answerTextFiled.text;
  self.wrongApi.correctValue = self.value;
  
}

#pragma mark
#pragma mark - 键盘回收
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  [self.view endEditing:YES];
}

- (UIView *)line1
{
  if (!_line1) {
    _line1 = [[UIView alloc] init];
    _line1.frame = CGRectMake(kScreenWidth/3 * 2, 0, 2, 1);
    _line1.backgroundColor = redColor();
    [self.view addSubview:_line1];
  }
  return _line1;
}

- (UIView *)line2
{
  if (!_line2) {
    _line2 = [[UIView alloc] init];
    _line2.frame = CGRectMake(kScreenWidth/3, 0, 2, 1);
    _line2.backgroundColor = redColor();
    [self.view addSubview:_line2];
  }
  return _line2;
}

- (TestApi *)api
{
  if (!_api) {
    _api = [[TestApi alloc] init];
  }
  return _api;
}

- (WrongApi *)wrongApi
{
  return [WrongApi shareApi];
}

@end
