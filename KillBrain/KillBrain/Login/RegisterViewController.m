//
//  RegisterViewController.m
//  KillBrain
//
//  Created by Li Kelin on 16/9/20.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import "RegisterViewController.h"
#import "MyRegisterView.h"
@interface RegisterViewController ()
@property (nonatomic, strong) MyRegisterView *registerView;
@property (nonatomic, strong) NSTimer        *timer;
@property (nonatomic, strong) UIButton       *tempButton;
@property (nonatomic, assign) NSInteger      countTime;
@end

@implementation RegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
  
  self.view.backgroundColor = whiteColor();
  MyRegisterView *registerView = [[NSBundle mainBundle] loadNibNamed:@"MyRegisterView" owner:nil options:nil].lastObject;
  registerView.frame =  CGRectMake(0, headerHeight(), kScreenWidth, kScreenHeight - headerHeight());
  [self.view addSubview:registerView];
  _registerView = registerView;

  __weak typeof(self) wSelf = self;
  // 点击完成按钮
  [_registerView setClickCompleteButton:^(UIButton *sender) {
    __strong typeof(self) Sself = wSelf;
    if (![Sself isValidWithPhoneNumber:Sself.registerView.userName.text]) {
      [SVProgressHUD showWithStatus:@"手机号码不正确"];
    }
    else {
      AVUser *user = [AVUser user];
      user.username = Sself.registerView.userName.text;
      user.mobilePhoneNumber = user.username;
      user.password = Sself.registerView.password.text;
      NSError *error = nil;
      [user signUp:&error];
    
      [AVOSCloud verifySmsCode:Sself.registerView.checkPhone.text mobilePhoneNumber:Sself.registerView.userName.text callback:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
          [SVProgressHUD showSuccessWithStatus:@"注册成功"];
          dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [Sself.navigationController popViewControllerAnimated:YES];
          });
        }
        else {
          [SVProgressHUD showErrorWithStatus:@"注册失败"];
        }
      }];
    }
  }];
  
  // 点击发送验证码按钮
  [_registerView setClickSendNumsButton:^(UIButton *sender) {
    __strong typeof(self) Sself = wSelf;
    if (![Sself isValidWithPhoneNumber:Sself.registerView.userName.text]) {
      [SVProgressHUD showErrorWithStatus:@"手机号码不正确"];
    }
    else {
      [AVOSCloud requestSmsCodeWithPhoneNumber:Sself.registerView.userName.text appName:nil operation:nil timeToLive:10 callback:^(BOOL succeeded, NSError *error) {
        if (error) {
          NSLog(@"%@",error.localizedDescription);
        }
        else {
          [Sself showTimerWithButton:sender];
        }
      }];
    }
  }];
  
}

// 验证手机号是否有效
- (BOOL)isValidWithPhoneNumber:(NSString *)phoneNum
{
  phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@" " withString:@""];
  
  if (phoneNum.length != 11) {
    return NO;
  }
  // 移动
  NSString *CM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
  // 联通
  NSString *CU = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
  // 电信
  NSString *CT = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
  
  NSPredicate *preCM = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CM];
  NSPredicate *preCU = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CU];
  NSPredicate *preCT = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CT];
  
  BOOL validCM = [preCM evaluateWithObject:phoneNum];
  BOOL validCU = [preCU evaluateWithObject:phoneNum];
  BOOL validCT = [preCT evaluateWithObject:phoneNum];
  
  if (validCM || validCT || validCU) {
    return YES;
  }
  return NO;
}

- (void)showTimer
{
  _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(countTimer) userInfo:nil repeats:YES];
  [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)hiddenTimer
{
  if (_timer) {
    [_timer invalidate];
    _timer = nil;
  }
}

- (void)countTimer
{
  _countTime--;
  [_tempButton setTitle:[NSString stringWithFormat:@"%lds后重新发送",_countTime] forState:UIControlStateNormal];
  if (_countTime <= 0) {
    [self hiddenTimer];
    [_tempButton setTitle:@"验证码"forState:UIControlStateNormal];
    _tempButton.enabled = YES;
  }
}

- (void)showTimerWithButton:(UIButton *)sender
{
  _countTime = 60;
  sender.enabled = NO;
  _tempButton = sender;
  [self showTimer];
  
}
@end
