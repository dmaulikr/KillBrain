//
//  ForgetViewController.m
//  KillBrain
//
//  Created by Li Kelin on 16/9/20.
//  Copyright © 2016年 Li Kelin. All rights reserved.


//  重置密码

#import "ForgetViewController.h"
#import "ForgetPasswordView.h"
@interface ForgetViewController ()
@property (nonatomic, strong) ForgetPasswordView *forgetView;
@end

@implementation ForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  self.view.backgroundColor = whiteColor();
  _forgetView = [[NSBundle mainBundle] loadNibNamed:@"ForgetPasswordView" owner:nil options:nil].lastObject;
  _forgetView.frame = CGRectMake(0, headerHeight(), kScreenWidth, kScreenHeight - headerHeight());
  [self.view addSubview:_forgetView];
  
  __weak typeof(self) wSelf = self;
  [_forgetView setRetPasswordButton:^(UIButton *sender) {
    __strong typeof(self) sSelf = wSelf;
    [AVUser resetPasswordWithSmsCode:sSelf.forgetView.checkNum.text newPassword:sSelf.forgetView.passwordNew.text block:^(BOOL succeeded, NSError *error) {
      if (error) {
        NSLog(@"%@",error.localizedDescription);
      }
      else {
        NSLog(@"success");
      }
    }];
  }];
  

  [_forgetView setCheckPhoneNumButton:^(UIButton *sender) {
    __strong typeof(self) sSelf = wSelf;
    [AVUser requestPasswordResetWithPhoneNumber:sSelf.forgetView.userName.text
                                          block:^(BOOL succeeded, NSError *error) {
                                            if (succeeded) {
                                              NSLog(@"密码重置成功了");
                                            }
                                            else {
                                              NSLog(@" %ld-%@",error.code, error.localizedDescription);
                                            }
                                          }];
  }];
}


@end
