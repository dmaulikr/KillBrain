//
//  MyView.h
//  KillBrain
//
//  Created by Li Kelin on 16/9/19.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyLoginView : UIView
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;

@property (nonatomic, copy) void (^clickSubmitButton)(UIButton *sender);
@property (nonatomic, copy) void (^clickRegistButton)(UIButton *sender);
@property (nonatomic, copy) void (^clickForgetButton)(UIButton *sender);

@end
