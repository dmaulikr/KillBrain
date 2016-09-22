//
//  MainViewController.m
//  KillBrain
//
//  Created by Li Kelin on 16/8/20.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "GamesViewController.h"
#import "MainShowView.h"
#import "MainViewProtocol.h"
#import "MainTableViewCell.h"
#import "FastCountController.h"
#import "MemonryController.h"
#import "WordsLinkController.h"
#import "CustomController.h"
#import "LoginViewController.h"
@interface GamesViewController ()
@property (nonatomic, strong) MainShowView *showView;
@property (nonatomic, strong) MainViewProtocol *protocol;

@end

@implementation GamesViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self initView];
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登陆" style:UIBarButtonItemStyleDone target:self action:@selector(login)];
}

- (void)login
{
  LoginViewController *login = [[LoginViewController alloc] init];
  [self.navigationController pushViewController:login animated:YES];
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
      CustomController *custom = [[CustomController alloc] init];
      [self.navigationController pushViewController:custom animated:YES];
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
