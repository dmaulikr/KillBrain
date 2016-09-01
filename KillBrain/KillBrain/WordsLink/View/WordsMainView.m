
//
//  WordsMainView.m
//  KillBrain
//
//  Created by Li Kelin on 16/8/31.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#define kButtonH 34
#define kButtonMargin 10
#define kHeadMargin 20
#define kButtonW (_bottomView.width - 3 * kButtonMargin - 2 * kHeadMargin)/4

#import "WordsMainView.h"

@interface WordsMainView ()
{
  UIView *_bottomView;
  UIView *_topView;
  
  UILabel *_tipLabel;
  NSInteger nums;

}
@end


@implementation WordsMainView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    _topView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, self.width - 10, 100)];
    [_topView addBorderWithColor:lightGrayColor() width:0.7];
    
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(_topView.frame) + 10, self.width - 10, 200)];
    
    _timerLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, _topView.width - 10, 40)];
    _timerLabel.backgroundColor = cyanColor();
    _timerLabel.textAlignment = NSTextAlignmentCenter;
    _timerLabel.font = UIFontWithSize(13);
    _timerLabel.textColor = blackColor();
    
    _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(_timerLabel.frame) + 10, _topView.width - 10, _topView.height - CGRectGetMaxY(_timerLabel.frame) - 30)];
    _tipLabel.textAlignment = NSTextAlignmentLeft;
    _tipLabel.textColor = redColor();
    _tipLabel.backgroundColor = yellowColor();
    _tipLabel.font = UIFontWithSize(12);
    _tipLabel.text = @"tip:在规定观察时间内，找出5组对应的成语，即为通关";
    _tipLabel.numberOfLines = 3;
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.backgroundColor = lightGrayColor();
    _contentLabel.textColor = greenColor();
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    _contentLabel.font = UIFontWithSize(13);
    _contentLabel.hidden = YES;
    
    [self addSubview:_topView];
    [self addSubview:_bottomView];
    [self addSubview:_contentLabel];
    [_topView addSubview:_timerLabel];
    [_topView addSubview:_tipLabel];
    
  }
  return self;
  
}

- (void)reloadData;
{
  if (_bottomView.subviews.count > 0) {
    for (UIButton *subView in _bottomView.subviews) {
      [subView removeFromSuperview];
    }
  }
  
  nums = 0;
  NSInteger count = [self.delegate numbersOfItemsInWordView:self];
  
  for (int i = 0; i < count; i++) {
    CGFloat x = kHeadMargin + (kButtonW + kButtonMargin) * (i%4);
    CGFloat y = kHeadMargin + (kButtonH + kButtonMargin) * (i/4);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = i;
    button.enabled = [self.delegate wordView:self isEnableForItemAtIndex:i];
    button.hidden = ![self.delegate wordView:self isShowItemAtIndex:i];
    button.frame = CGRectMake(x, y, kButtonW, kButtonH);
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button setTitleColor:whiteColor() forState:UIControlStateNormal];
    [button setBackgroundColor:darkTextColor()];
    [button setTitle:[self.delegate wordView:self titleForItemAtIndex:i] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickCurrentButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [_bottomView addSubview:button];
  }
  [self resetBottomViewFrameWithDatasCount:count];

}

- (void)clickCurrentButton:(UIButton *)button
{
  if (!button.selected && nums < 4) {
    [button setBackgroundColor:redColor()];
    button.selected = YES;
    nums += 1;
    [self.delegate wordView:self didSelectItemAtIndex:button.tag];
  }
  else if(button.selected) {
    [button setBackgroundColor:blackColor()];
    button.selected = NO;
    nums -= 1;
    [self.delegate wordView:self didDeselectItemAtIndex:button.tag];
  }

}

- (void)resetBottomViewFrameWithDatasCount:(NSInteger)count
{
  NSInteger index = count / 4;
  if (count % 4 == 0) {
    _bottomView.frame = CGRectMake(5, CGRectGetMaxY(_topView.frame) + 10, self.width - 10, 20 * 2 + (kButtonH * index) + 10 * (index - 1));
  }
  else{
    index = count / 4 + 1;
    _bottomView.frame = CGRectMake(5, CGRectGetMaxY(_topView.frame) + 10, self.width - 10, 20 * 2 + (kButtonH * index) + 10 * (index - 1));
  }
  
}

- (void)didMoveToSuperview
{
  [super didMoveToSuperview];
  [self reloadData];
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  _contentLabel.frame = CGRectMake(5, CGRectGetMaxY(_bottomView.frame) + 10, self.width - 10, 40);
}

- (void)showContentLabel
{
  _contentLabel.hidden = NO;
}

@end
