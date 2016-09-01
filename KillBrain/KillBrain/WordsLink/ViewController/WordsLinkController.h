//
//  WordsLinkController.h
//  KillBrain
//
//  Created by Li Kelin on 16/8/31.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WordsLinkController : UIViewController
@property (nonatomic, assign, readonly) BOOL gameOver;
@property (nonatomic, strong, readonly) NSMutableArray *datas;

- (void)handleDatasWhenDidDeselectItemAtIndex:(NSInteger)index;
- (void)handleDatasWhenDidSelectItem:(NSInteger)index;
- (BOOL)handleDatasWhenIsShowItemAtIndex:(NSInteger)index;

@end
