//
//  WordsLinkController.m
//  KillBrain
//
//  Created by Li Kelin on 16/8/31.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "WordsLinkController.h"
#import "WordsMainView.h"
#import "WordsLinkProtocol.h"
#import "WordsApi.h"
@interface WordsLinkController ()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSMutableArray *selectDatas;
@property (nonatomic, assign) NSInteger anwerTimer;
@property (nonatomic, assign) BOOL  corrected;

@property (nonatomic, strong) WordsMainView *wordView;
@property (nonatomic, strong) WordsApi *api;
@property (nonatomic, strong) WordsLinkProtocol *protocol;
@property (nonatomic, strong, readwrite) NSMutableArray *datas;
@property (nonatomic, assign, readwrite) BOOL gameOver;    // 游戏结束
@end

@implementation WordsLinkController

- (void)viewDidLoad
{
  [super viewDidLoad];

  self.view.backgroundColor = whiteColor();
  _anwerTimer = 30;
  _corrected = YES;
  
  [self.api loadData:^void (NSArray *datas) {
    self.datas = [NSMutableArray arrayWithArray:datas];
    [self setUpView];
    [self showTimer];
  }];
}

- (void)setUpView
{
  _wordView = [[WordsMainView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
  _wordView.timerLabel.text = [NSString stringWithFormat:@"当前剩余时间还有%ld秒",_anwerTimer];
  _wordView.delegate = self.protocol;
  [self.view addSubview:_wordView];
}

- (void)showTimer
{
  _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(countTime) userInfo:nil repeats:YES];
  [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)hiddenTimer
{
  if (_timer) {
    [_timer invalidate];
    _timer = nil;
  }
}

- (void)countTime
{
  _anwerTimer--;
  _wordView.timerLabel.text = [NSString stringWithFormat:@"当前剩余时间还有%ld秒",_anwerTimer];

  if (_anwerTimer <= 0) {
    [self hiddenTimer];
    _gameOver = YES;
    
    [_wordView showContentLabel];
    _wordView.timerLabel.text = [NSString stringWithFormat:@"答题时间已经结束"];
    _wordView.contentLabel.text = [NSString stringWithFormat:@"八仙过海、金玉良缘、两小无猜、皆大欢喜、国色天香"];
    [_wordView reloadData];
  }
}

- (void)handleDatasWhenDidDeselectItemAtIndex:(NSInteger)index
{
  NSString *item = self.datas[index];
  [self.selectDatas removeObject:item];
}


- (void)handleDatasWhenDidSelectItem:(NSInteger)index
{
  NSString *item = self.datas[index];
  [self.selectDatas addObject:item];
  
  if (self.selectDatas.count % 4 == 0) {
    NSMutableArray *arr = [NSMutableArray array];
    NSInteger count = self.selectDatas.count;
    for (unsigned int i = 0; i < 4; i++) {
      NSString *obj = self.selectDatas[count - 4 + i];
      [arr addObject:obj];
    }
    NSString *numStr = [arr componentsJoinedByString:@","];
    if ([[self.api resultApi] containsObject:numStr]) {
      self.corrected = YES;
      [_wordView reloadData];
    }
    else {
      self.corrected = NO;
    }
  }
}

- (BOOL)handleDatasWhenIsShowItemAtIndex:(NSInteger)index
{

  if (self.selectDatas.count % 4 != 0) {
    NSInteger count = self.selectDatas.count % 4;
    for (unsigned int i = 0; i < count; i++) {
      [self.selectDatas removeObjectAtIndex:self.selectDatas.count - count + i];
    }
    _corrected = YES;
  }
  else {
    if (_corrected == NO) {
      for (unsigned int i = 0; i < 4; i++) {
        [self.selectDatas removeObjectAtIndex:self.selectDatas.count - 4 + i];
        _corrected = YES;
      }
    }
  }

  NSString *item = self.datas[index];
  if ([self.selectDatas containsObject:item]) {
    return NO;
  }
  return YES;
}


- (NSMutableArray *)selectDatas
{
  if (!_selectDatas) {
    _selectDatas = [NSMutableArray array];
  }
  return _selectDatas;
}

- (WordsLinkProtocol *)protocol
{
  if (!_protocol) {
    _protocol = [[WordsLinkProtocol alloc] init];
    _protocol.controller = self;
  }
  return _protocol;
}

- (WordsApi *)api
{
  if (!_api) {
    _api = [[WordsApi alloc] init];
  }
  return _api;
}

@end
