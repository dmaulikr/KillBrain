//
//  ForgetView.h
//  KillBrain
//
//  Created by Li Kelin on 16/9/20.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgetPasswordView : UIView
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passwordNew;
@property (weak, nonatomic) IBOutlet UITextField *checkNum;

@property (nonatomic, copy) void (^retPasswordButton)(UIButton *sender);
@property (nonatomic, copy) void (^checkPhoneNumButton)(UIButton *sender);

@end
