//
//  FastCountView.h
//  KillBrain
//
//  Created by Li Kelin on 16/8/20.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectNum.h"
#import "SelectMethod.h"
#import "SelectTimeView.h"

NS_ASSUME_NONNULL_BEGIN
@interface FastCountView : UIView
@property (nonatomic, readonly) SelectNum      *numView;
@property (nonatomic, readonly) SelectMethod   *methodView;
@property (nonatomic, readonly) SelectTimeView *timerView;
@property (nonatomic, readonly) UILabel        *showDataLabel;
@end
NS_ASSUME_NONNULL_END