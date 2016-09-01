//
//  TestWrongView.h
//  KillBrain
//
//  Created by Li Kelin on 16/8/21.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestWrongView : UIView

@property (nonatomic, strong) UITableView *tableView;
- (void)showNumButtonsViewWithArray:(NSArray *)datas completion:(void (^)())completion;
@end
