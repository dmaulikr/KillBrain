//
//  SelectTimeView.m
//  KillBrain
//
//  Created by Li Kelin on 16/8/20.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "SelectTimeView.h"

@implementation SelectTimeView

- (instancetype)initWithFrame:(CGRect)frame
{
  if (self = [super initWithFrame:frame]) {
    _tableView = [[UITableView alloc] init];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self addSubview:_tableView];
  }
  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  _tableView.frame = CGRectMake(5, 5, self.width - 10, self.height - 10);
}

@end
