//
//  MemonryController.h
//  KillBrain
//
//  Created by Li Kelin on 16/8/24.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemonryController : UIViewController

- (void)didDeselectAtIndex:(NSInteger)index;
- (void)didSelectAtIndex:(NSInteger)index;
- (BOOL)isSelectedAtIndex:(NSInteger)index;

@end
