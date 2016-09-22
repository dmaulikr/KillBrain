//
//  MainViewProtocol.m
//  KillBrain
//
//  Created by Li Kelin on 16/8/20.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "MainViewProtocol.h"
#import "MainTableViewCell.h"
@implementation MainViewProtocol

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [self datas].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell"];
  cell.bgIconView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",@(indexPath.row + 1)]];
  cell.titleLabel.text = [self datas][indexPath.row];
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [self.viewController selectAtIndex:indexPath.row];
}

- (NSArray *)datas
{
  return @[@"闪 电 心 算",@"最 强 记 忆",@"成 语 拼 接",@"极 限 手 速"];
}
@end
