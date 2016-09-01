//
//  FastCountController.m
//  KillBrain
//
//  Created by Li Kelin on 16/8/20.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "FastCountController.h"
#import "FastCountProtocol.h"
#import "FastCountApi.h"
#import "TestViewController.h"
@interface FastCountController ()

@property (nonatomic, strong) FastCountProtocol *protocol;
@property (nonatomic, strong) FastCountApi      *api;

@property (nonatomic, strong) NSMutableArray    *datas;
@end

@implementation FastCountController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.view.backgroundColor = whiteColor();
  _countView = [[FastCountView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
  _countView.numView.tableView.dataSource = self.protocol;
  _countView.numView.tableView.delegate   = self.protocol;
  
  _countView.methodView.tableView.dataSource = self.protocol;
  _countView.methodView.tableView.delegate   = self.protocol;
  
  _countView.timerView.tableView.delegate = self.protocol;
  _countView.timerView.tableView.dataSource = self.protocol;
  
  [self.view addSubview:_countView];
  
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"GO"
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:self
                                                                           action:@selector(goTest)];
  self.navigationItem.rightBarButtonItem.enabled = NO;
  
  __weak typeof(self) wSelef = self;
  [self.protocol setSelectedBlock:^(BOOL selected, NSArray <NSString *> *datas) {
    __strong typeof(self) StrongSelf = wSelef;
    StrongSelf.navigationItem.rightBarButtonItem.enabled = selected;
    StrongSelf.datas = [NSMutableArray arrayWithArray:datas];
    if (datas.count != 3) return;
    StrongSelf.countView.showDataLabel.text = [NSString stringWithFormat:@"%@ %@ %@",datas[0],datas[1],datas[2]];
  }];

}

- (void)goTest
{
  TestViewController *test = [[TestViewController alloc] init];
  test.datas = [self.datas copy];
  [self.navigationController pushViewController:test animated:YES];
}



- (void)viewDidDisappear:(BOOL)animated
{
  [super viewDidDisappear:animated];
  self.navigationItem.rightBarButtonItem.enabled = NO;
  self.countView.showDataLabel.text = nil;
  [self.protocol resetEnable];
  [self reloadData];
}

- (FastCountProtocol *)protocol
{
  if (!_protocol) {
    _protocol = [[FastCountProtocol alloc] init];
    _protocol.viewController = self;
    _protocol.api = self.api;
  }
  return _protocol;
}

- (FastCountApi *)api
{
  if (!_api) {
    _api = [[FastCountApi alloc] init];
  }
  return _api;
}

- (void)reloadData
{
  [_countView.numView.tableView reloadData];
  [_countView.methodView.tableView reloadData];
  [_countView.timerView.tableView reloadData];
}
@end
