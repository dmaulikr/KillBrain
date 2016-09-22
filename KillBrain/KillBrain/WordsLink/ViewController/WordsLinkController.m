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
@property (nonatomic, strong) NSMutableArray *words;
@property (nonatomic, assign) NSInteger anwerTimer;
@property (nonatomic, assign) BOOL  corrected;

@property (nonatomic, strong) WordsMainView *wordView;
@property (nonatomic, strong) WordsApi *api;
@property (nonatomic, strong) WordsLinkProtocol *protocol;
@property (nonatomic, strong, readwrite) NSMutableArray *datas;
@property (nonatomic, assign, readwrite) BOOL gameOver;    // 游戏结束
@property (nonatomic, copy)  NSString *allWordsString;
@end

@implementation WordsLinkController

- (void)viewDidLoad
{
  [super viewDidLoad];

  self.view.backgroundColor = whiteColor();
  _anwerTimer = wordsLinkNeedTime;
  _corrected = YES;
  
  [self.api loadData:^void (NSArray *datas) {
    self.datas = [NSMutableArray arrayWithArray:datas];
    [self setUpView];
    [self showTimer];
    [self showResultAnswer];
  }];
  
}

- (void)showResultAnswer
{
  NSMutableArray *results = [NSMutableArray array];
  [self.api.resultApi enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    NSArray *words = [obj componentsSeparatedByString:@","];
    if (words.count != 0) {
        NSString *result = [words componentsJoinedByString:@""];
        [results addObject:result];
    }
  }];
  _allWordsString = [results componentsJoinedByString:@"、"];
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
    _wordView.contentLabel.text = _allWordsString;
    [_wordView reloadData];
  }
}

- (void)handleDatasWhenDidDeselectItemAtIndex:(NSInteger)index
{
  NSString *item = self.datas[index];
  [self.selectDatas removeObject:item];
  [self.words removeObject:item];
  _wordView.selectItemLabel.text = [self.words componentsJoinedByString:@""];
}


- (void)handleDatasWhenDidSelectItem:(NSInteger)index
{
  NSString *item = self.datas[index];
  [self.selectDatas addObject:item];
  [self.words addObject:item];
  _wordView.selectItemLabel.text = [self.words componentsJoinedByString:@""];

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
      _wordView.selectItemLabel.textColor = greenColor();
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _wordView.selectItemLabel.text = @"";
        _wordView.selectItemLabel.textColor = whiteColor();
        [self.words removeAllObjects];
      });
      [_wordView reloadData];
    }
    else {
      self.corrected = NO;
    }
  }
  
  if (self.selectDatas.count == self.datas.count) {
    _gameOver = YES;
    [_timer invalidate];
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

- (NSMutableArray *)words
{
  if (!_words) {
    _words = [NSMutableArray array];
  }
  return _words;
}
@end
