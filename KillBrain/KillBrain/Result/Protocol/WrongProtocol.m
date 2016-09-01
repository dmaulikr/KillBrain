//
//  WrongProtocol.m
//  KillBrain
//
//  Created by Li Kelin on 16/8/23.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "WrongProtocol.h"

@implementation WrongProtocol
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *identifier = @"cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
  }
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  cell.textLabel.font = [UIFont systemFontOfSize:12];
  
  if (indexPath.row == 0) {
    cell.textLabel.text = [NSString stringWithFormat:@"正确的结果是：%ld",self.api.correctValue];
  }
  
  if (indexPath.row == 1) {
    cell.textLabel.text = [NSString stringWithFormat:@"您的结果是：%@",self.api.userValue];
  }
  
  if (indexPath.row == 2) {
    cell.textLabel.text = [NSString stringWithFormat:@"您所用的时间是：%ld秒",self.api.useTime];
  }
  
  return cell;
}
@end
