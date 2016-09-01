//
//  TestWrongView.m
//  KillBrain
//
//  Created by Li Kelin on 16/8/21.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "TestWrongView.h"
#define kButtonW (_numsView.width - 3 * kButtonMargin - 2 * kHeadMargin)/4
#define kButtonH 34
#define kButtonMargin 10
#define kHeadMargin 28
@interface TestWrongView ()
{
  UIView *_numsView;
  UIView *_infoView;
  UILabel *_watermarkView;
  UILabel *_tipSorry;
}
@end
@implementation TestWrongView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    
    self.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.4];
    _numsView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, self.width - 10, 100)];
    
    _watermarkView = [[UILabel alloc] init];
    _watermarkView.text = @"全部随机数";
    _watermarkView.font = UIFontWithSize(13);
    _watermarkView.textColor = whiteColor();
    _watermarkView.backgroundColor = redColor();
    _watermarkView.textAlignment = NSTextAlignmentCenter;
    
    _tipSorry = [[UILabel alloc] init];
    _tipSorry.text = @"很遗憾，您没能答对，fighting again !";
    _tipSorry.font = UIFontWithSize(15);
    _tipSorry.textColor = redColor();
    _tipSorry.backgroundColor = yellowColor();
    _tipSorry.textAlignment = NSTextAlignmentCenter;
    
    _infoView = [[UIView alloc] init];
    [_infoView addBorderWithColor:lightGrayColor() width:1];
    
    _tableView = [[UITableView alloc] init];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.scrollEnabled = NO;
    _tableView.rowHeight = 30;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_infoView addSubview:_tableView];
    [_numsView addSubview:_watermarkView];
    
    [self addSubview:_tipSorry];
    [self addSubview:_numsView];
    [self addSubview:_infoView];
  }
  return self;
}

- (void)showNumButtonsViewWithArray:(NSArray *)datas completion:(void (^)())completion
{
  static NSInteger i = 0;
  if (i < datas.count) {
    CGFloat x = kHeadMargin + (kButtonW + kButtonMargin) * (i%4);
    CGFloat y = kHeadMargin + (kButtonH + kButtonMargin) * (i/4);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(x, y, kButtonW, kButtonH);
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button setTitleColor:whiteColor() forState:UIControlStateNormal];
    [button setBackgroundColor:blackColor()];
    [button setTitle:[NSString stringWithFormat:@"%@",datas[i]] forState:UIControlStateNormal];
    [_numsView addSubview:button];
  }
  i++;
  if (i >= datas.count) {
    i = 0;
    completion();
    [self resetSubViewFrameWithCount:datas.count];
  }
}


- (void)resetSubViewFrameWithCount:(NSInteger)count
{

  NSInteger index = count / 4;
  if (count % 4 == 0) {
    _numsView.frame = CGRectMake(5, 5, self.width - 10, 20 * 2 + (kButtonH * index) + 10 * (index - 1));
  }
  else{
    index = count / 4 + 1;
    _numsView.frame = CGRectMake(5, 5, self.width - 10, 20 * 2 + (kButtonH * index) + 10 * (index - 1));
  }
  
  NSInteger totalCount = 0;
  for (NSInteger section = 0; section<_tableView.numberOfSections; section++) {
    totalCount += [_tableView numberOfRowsInSection:section];
  }
  
  _infoView.frame = CGRectMake(5, CGRectGetMaxY(_numsView.frame) + 10, self.width - 10, 30 * totalCount + 20);
  _tableView.frame = CGRectMake(10, 5, _infoView.width - 20, _infoView.height - 10);
  _watermarkView.frame = CGRectMake(self.width - 110, _numsView.height - 30, 80, 24);
  _tipSorry.frame = CGRectMake(10, CGRectGetMaxY(_infoView.frame) + 20, self.width - 20, 40);
  
  [_numsView addBorderWithColor:lightGrayColor() width:1];
  [_watermarkView addBorderWithColor:greenColor() width:1];


  
}

@end
