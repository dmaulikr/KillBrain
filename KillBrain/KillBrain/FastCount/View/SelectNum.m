//
//  SelectNum.m
//  KillBrain
//
//  Created by Li Kelin on 16/8/20.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "SelectNum.h"

@interface SelectNum ()
{
  UIView *_line;
}
@end
@implementation SelectNum


- (instancetype)initWithFrame:(CGRect)frame
{
  if (self = [super initWithFrame:frame]) {
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = clearColor();
    
    
    _tableView = [[UITableView alloc] init];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self addSubview:_line];
    [self addSubview:_tableView];
  }
  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  
  _line.frame = CGRectMake(0, 2, self.width, 1);
  _tableView.frame = CGRectMake(5, CGRectGetMaxY(_line.frame)+4, self.width - 10, self.height - 10);
}

@end
