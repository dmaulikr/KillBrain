//
//  MainViewController.m
//  KillBrain
//
//  Created by Li Kelin on 16/8/20.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "MainViewController.h"
#import "MainShowView.h"
#import "MainViewProtocol.h"
#import "MainTableViewCell.h"
#import "FastCountController.h"
#import "MemonryController.h"
#import "WordsLinkController.h"
@interface MainViewController ()
@property (nonatomic, strong) MainShowView *showView;
@property (nonatomic, strong) MainViewProtocol *protocol;

@end

@implementation MainViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self initView];
}

- (void)initView
{
  self.title = @"首页";
  self.view.backgroundColor = [UIColor cyanColor];
  _showView = [[MainShowView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
  [_showView.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MainTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"MainCell"];
  _showView.tableView.delegate = self.protocol;
  _showView.tableView.dataSource = self.protocol;
  [self.view addSubview:_showView];
}

- (void)selectAtIndex:(NSInteger)index
{
  
  switch (index) {
    case 0:
    {
      FastCountController *fastVC = [[FastCountController alloc] init];
      [self.navigationController pushViewController:fastVC animated:YES];
    }
      break;
    case 1:
    {
      MemonryController *memonry = [[MemonryController alloc] init];
      [self.navigationController pushViewController:memonry animated:YES];
    }
      break;
    case 2:
    {
      WordsLinkController *words = [[WordsLinkController alloc] init];
      [self.navigationController pushViewController:words animated:YES];
    }
      break;
    case 3:
    {
      return;
    }
      break;
    default:
      break;
  }

}

- (MainViewProtocol *)protocol
{
  if (!_protocol) {
    _protocol = [[MainViewProtocol alloc] init];
    _protocol.viewController = self;
  }
  return _protocol;
}
@end
