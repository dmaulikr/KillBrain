//
//  MemonryNumsView.m
//  KillBrain
//
//  Created by Li Kelin on 16/8/24.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//
#define kButtonH 34
#define kButtonMargin 10
#define kHeadMargin 20
#define kButtonW (_bottomView.width - 3 * kButtonMargin - 2 * kHeadMargin)/4

#import "MemonryNumsView.h"

@interface MemonryNumsView (){
  struct {
    unsigned int didSelectAtIndex : 1;
    unsigned int didDeselectAtIndex : 1;
    unsigned int isSelectedAtIndex : 1;
  } Flags;
  
  UIView *_bottomView;
  UIView *_topView;
  UIView *_coverView;

  UILabel *_tipLabel;
  UIButton *_replaceButton;
  UIButton *_lastButton;
}
@end
@implementation MemonryNumsView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  
  if (self) {
    
    
    _topView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, self.width - 10, 200)];
    [_topView addBorderWithColor:lightGrayColor() width:0.7];
    
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(_topView.frame) + 10, self.width - 10, 200)];
    
    _countTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, _topView.width - 10, 40)];
    _countTimeLabel.backgroundColor = cyanColor();
    _countTimeLabel.textAlignment = NSTextAlignmentCenter;
    _countTimeLabel.font = UIFontWithSize(13);
    _countTimeLabel.textColor = blackColor();
    
    _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(_countTimeLabel.frame) + 10, _topView.width - 10, _topView.height - CGRectGetMaxY(_countTimeLabel.frame) - 60)];
    _tipLabel.textAlignment = NSTextAlignmentLeft;
    _tipLabel.textColor = redColor();
    _tipLabel.backgroundColor = whiteColor();
    _tipLabel.font = UIFontWithSize(12);
    _tipLabel.text = memonryRuleTip;
    _tipLabel.numberOfLines = 3;
    
    _leaveCountLabel = [[UILabel alloc] init];
    _leaveCountLabel.textAlignment = NSTextAlignmentCenter;
    _leaveCountLabel.textColor = blackColor();
    _leaveCountLabel.font = UIFontWithSize(13);
    _leaveCountLabel.hidden = YES;
    _leaveCountLabel.backgroundColor = yellowColor();
    
    [self addSubview:_topView];
    [self addSubview:_bottomView];
    [self addSubview:_leaveCountLabel];
    [_topView addSubview:_countTimeLabel];
    [_topView addSubview:_tipLabel];
    
    
    
  }
  return self;
}

- (void)setDelegate:(id<MemonryNumsViewDelegate>)delegate
{
  _delegate = delegate;
  Flags.didSelectAtIndex = [delegate respondsToSelector:@selector(memonryView:didSelectAtIndex:)];
  Flags.didDeselectAtIndex = [delegate respondsToSelector:@selector(memonryView:didDeselectAtIndex:)];
  Flags.isSelectedAtIndex = [delegate respondsToSelector:@selector(memonryView:isSelectedAtIndex:)];
}

- (void)showNumButtonsViewWithArray:(NSArray *)datas enable:(BOOL)enable
{
  if (_bottomView.subviews.count > 0) {
    for (UIButton *subView in _bottomView.subviews) {
      [subView removeFromSuperview];
    }
  }
  
  for (int i = 0; i < datas.count; i++) {
    CGFloat x = kHeadMargin + (kButtonW + kButtonMargin) * (i%4);
    CGFloat y = kHeadMargin + (kButtonH + kButtonMargin) * (i/4);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = i;
    button.enabled = enable;
    button.frame = CGRectMake(x, y, kButtonW, kButtonH);
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button setTitleColor:whiteColor() forState:UIControlStateNormal];
    [button setBackgroundColor:darkTextColor()];
    [button setTitle:[NSString stringWithFormat:@"%@",datas[i]] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickCurrentButton:) forControlEvents:UIControlEventTouchUpInside];

    if (Flags.isSelectedAtIndex) {
      button.selected = [_delegate memonryView:self isSelectedAtIndex:i];
    }
    [_bottomView addSubview:button];
  }
  [self resetBottomViewFrameWithDatasCount:datas.count];
}

- (void)clickCurrentButton:(UIButton *)sender
{
  if (_lastButton != sender) {
      _lastButton.backgroundColor = darkTextColor();
      sender.backgroundColor = redColor();
      if (Flags.didSelectAtIndex) { [_delegate memonryView:self didSelectAtIndex:sender.tag];}
    }
    else {
      sender.backgroundColor = redColor();
      if (Flags.didDeselectAtIndex) { [_delegate memonryView:self didDeselectAtIndex:sender.tag];}
    }
  _lastButton = sender;
  
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

- (void)addCoverViewCompletion:(void (^)())completion
{
  _coverView = [[UIView alloc] initWithFrame:_bottomView.frame];
  _coverView.backgroundColor = whiteColor();
  _coverView.alpha = 0;
  [self addSubview:_coverView];
  
  [UIView animateWithDuration:1 animations:^{
    _coverView.alpha = 1;
  } completion:^(BOOL finished) {
    completion();
  }];
}

- (void)removeCoverView
{
  [UIView animateWithDuration:1 animations:^{
    _coverView.alpha = 0;
  } completion:^(BOOL finished) {
    if (_coverView) {
      [_coverView removeFromSuperview];
      _coverView = nil;
    }
  }];
}


- (void)showLeaveCountLabel
{
  _leaveCountLabel.hidden = NO;
}

- (void)hiddenLeaveCountLabel
{
  _leaveCountLabel.hidden = YES;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  _leaveCountLabel.frame = CGRectMake(5, CGRectGetMaxY(_bottomView.frame) + 10, self.width - 10, 40);
}

@end
