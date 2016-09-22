//
//  LoginViewController.m
//  KillBrain
//
//  Created by Li Kelin on 16/9/19.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "LoginViewController.h"
#import "MyLoginView.h"
#import "RegisterViewController.h"
#import "ForgetViewController.h"
@interface LoginViewController ()
@property (nonatomic, strong) MyLoginView *loginView;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  self.view.backgroundColor = whiteColor();
  self.title = @"登陆";
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"退出" style:UIBarButtonItemStyleDone target:self action:@selector(dimissLoginVC)];
  
  [self addLoginView];
  
}

- (void)addLoginView
{
  MyLoginView *login = [[NSBundle mainBundle] loadNibNamed:@"MyLoginView" owner:nil options:nil].lastObject;
  login.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64);
  [self.view addSubview:login];
  _loginView = login;
  __weak typeof(self) wSelf = self;
  [login setClickSubmitButton:^(UIButton *sender) {
    __strong typeof(self) Sself = wSelf;
    [AVUser logInWithMobilePhoneNumberInBackground:Sself.loginView.userName.text password:Sself.loginView.password.text block:^(AVUser *user, NSError *error) {
      if (error) {
        NSLog(@"%@",error.localizedDescription);
      }
      else {
        [SVProgressHUD showSuccessWithStatus:@"登陆成功"];
      }
    }];
  }];
  
  [login setClickRegistButton:^(UIButton *sender) {
    __strong typeof(self) Sself = wSelf;
    RegisterViewController *regist = [[RegisterViewController alloc] init];
    [Sself.navigationController pushViewController:regist animated:YES];
  }];
  
  [login setClickForgetButton:^(UIButton *sender) {
    __strong typeof(self) Sself = wSelf;
    ForgetViewController *forget = [[ForgetViewController alloc] init];
    [Sself.navigationController pushViewController:forget animated:YES];
  }];


}

- (void)dimissLoginVC
{
  [self.navigationController popViewControllerAnimated:YES];
}
@end
