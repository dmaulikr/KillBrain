//
//  MainTableViewCell.m
//  KillBrain
//
//  Created by Li Kelin on 16/8/20.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "MainTableViewCell.h"

@implementation MainTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}


- (void)layoutSubviews
{
  [super layoutSubviews];
  
  CGSize size = _bgIconView.bounds.size;
  CGFloat curlFactor = 15.f;
  CGFloat shadowDepth = 8.0f;
  
  UIBezierPath *path = [UIBezierPath bezierPath];
  [path moveToPoint:CGPointMake(0, 0)];
  [path addLineToPoint:CGPointMake(size.width, 0)];
  [path addLineToPoint:CGPointMake(size.width, size.height+shadowDepth)];
  [path addCurveToPoint:CGPointMake(0, size.height+shadowDepth) controlPoint1:CGPointMake(size.width-curlFactor, size.height + shadowDepth-curlFactor) controlPoint2:CGPointMake(curlFactor, size.height+shadowDepth-curlFactor)];
  
  _bgIconView.layer.shadowPath = path.CGPath;
  _bgIconView.layer.shadowColor = [UIColor blackColor].CGColor;
  _bgIconView.layer.shadowOffset = CGSizeMake(10, 10);
  _bgIconView.layer.shadowOpacity = 0.7;
  _bgIconView.layer.cornerRadius = 10;

}


@end
