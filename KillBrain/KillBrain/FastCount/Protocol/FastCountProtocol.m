//
//  FastCountProtocol.m
//  KillBrain
//
//  Created by Li Kelin on 16/8/20.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "FastCountProtocol.h"
#import "FastCountCell.h"

static NSString *numStr, *methodStr, *timeStr;
@implementation FastCountProtocol
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  if (tableView == self.viewController.countView.numView.tableView) {
    return [self.api.nums count];
  }
  
  if (tableView == self.viewController.countView.methodView.tableView) {
    return [self.api.methods count];
  }
  
  if (tableView == self.viewController.countView.timerView.tableView) {
    return [self.api.times count];
  }
  
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *identifier = @"cell";
  FastCountCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  
  if (cell == nil) {
    cell = [[FastCountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
  }
  
  if (tableView == self.viewController.countView.numView.tableView) {
    cell.textLabel.text = self.api.nums[indexPath.row];
  }
  
  if (tableView == self.viewController.countView.methodView.tableView) {
    cell.textLabel.text = self.api.methods[indexPath.row];
  }
  
  if (tableView == self.viewController.countView.timerView.tableView) {
    cell.textLabel.text = self.api.times[indexPath.row];
  }

  cell.textLabel.textColor = redColor();
  cell.textLabel.font = UIFontWithSize(14);
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
  if (tableView == self.viewController.countView.numView.tableView) {
    numStr = self.api.nums[indexPath.row];
  }
  
  if (tableView == self.viewController.countView.methodView.tableView) {
    methodStr = self.api.methods[indexPath.row];
  }
  
  if (tableView == self.viewController.countView.timerView.tableView) {
    timeStr = self.api.times[indexPath.row];
  }

  if (self.selectedBlock) {
    self.selectedBlock(numStr && methodStr && timeStr,@[numStr ? numStr : @"",
                                                        methodStr ? methodStr : @"",
                                                        timeStr ? timeStr : @""]);
  }

}

- (void)resetEnable
{
  numStr = nil;
  methodStr = nil;
  timeStr = nil;
}

@end
