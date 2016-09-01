//
//  ResultController.m
//  KillBrain
//
//  Created by Li Kelin on 16/8/22.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//


#import "ResultController.h"
#import "TestWrongView.h"
#import "TestCorrectView.h"
#import "WrongProtocol.h"
#import "WrongApi.h"
@interface ResultController ()
@property (nonatomic, strong) TestWrongView *wrongView;
@property (nonatomic, strong) TestCorrectView *correctView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) WrongProtocol *protcol;

@property (nonatomic, strong) WrongApi  *wrongApi;
@end

@implementation ResultController

- (void)viewDidLoad {
    [super viewDidLoad];

  self.view.backgroundColor = whiteColor();
  self.navigationController.navigationBar.tintColor = blackColor();
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"<- 返回" style:UIBarButtonItemStyleDone target:self action:@selector(backToHome)];
  [self loadSubView];
  
}


- (void)backToHome
{
  [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)loadSubView
{
  if (!self.corrected) {
    [self loadWrongView];
  }
  else {
    [self loadCorrectView];
  }
}

- (void)wrongViewShowTimer
{
  _timer = [NSTimer timerWithTimeInterval:0.2 target:self selector:@selector(showNumButtons) userInfo:nil repeats:YES];
  [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)loadWrongView
{
  _wrongView = [[TestWrongView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
  _wrongView.tableView.delegate = self.protcol;
  _wrongView.tableView.dataSource = self.protcol;
  self.title = @"挑战失败";
  [self.view addSubview:_wrongView];
  [self wrongViewShowTimer];
}

- (void)loadCorrectView
{
  _correctView = [[TestCorrectView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
  self.title = @"挑战成功";
  [self.view addSubview:_correctView];
}

#pragma mark
#pragma mark - 显示随机数字
- (void)showNumButtons
{
  [self.wrongView showNumButtonsViewWithArray:self.wrongApi.datas completion:^{
    [self removeTimerIfExits];
  }];
}

- (void)removeTimerIfExits
{
  if (_timer) {
    [_timer invalidate];
    _timer = nil;
  }
}

- (WrongProtocol *)protcol
{
  if (!_protcol) {
    _protcol = [[WrongProtocol alloc] init];
    _protcol.api = self.wrongApi;
  }
  return _protcol;
}

- (WrongApi *)wrongApi
{
  return [WrongApi shareApi];
}
@end
