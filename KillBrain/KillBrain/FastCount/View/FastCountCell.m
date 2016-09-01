//
//  SelectNumCell.m
//  KillBrain
//
//  Created by Li Kelin on 16/8/20.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "FastCountCell.h"


@interface FastCountCell ()

@end
@implementation FastCountCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  
  if (self) {
    
  }

  return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

  if (selected) {
    self.accessoryType = UITableViewCellAccessoryCheckmark;
  }else{
    self.accessoryType = UITableViewCellAccessoryNone;
  }
}

@end
