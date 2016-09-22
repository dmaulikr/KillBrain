//
//  RegisterView.h
//  KillBrain
//
//  Created by Li Kelin on 16/9/20.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyRegisterView : UIView

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *checkPhone;

@property (nonatomic, copy) void (^clickCompleteButton)(UIButton *sender);
@property (nonatomic, copy) void (^clickSendNumsButton)(UIButton *sender);
@end
