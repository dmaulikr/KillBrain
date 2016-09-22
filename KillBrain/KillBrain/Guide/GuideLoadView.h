//
//  GuideView.h
//  KillBrain
//
//  Created by Li Kelin on 16/9/21.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuideLoadView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@property (weak, nonatomic) IBOutlet UIButton *skipButton;

@property (nonatomic, copy) void (^clickSkipADButton)();

- (void)hiddenSkipButton;

@end
