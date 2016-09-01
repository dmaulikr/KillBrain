//
//  TestAnswerView.h
//  KillBrain
//
//  Created by Li Kelin on 16/8/21.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestAnswerView : UIView
@property (weak, nonatomic) IBOutlet UITextField *answerTextFiled;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@property (nonatomic, copy) void (^clickSubmitButton)();
+ (instancetype)anserView;
@end
