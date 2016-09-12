//
//  WordsMainView.h
//  KillBrain
//
//  Created by Li Kelin on 16/8/31.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WordsMainView;

@protocol WordsMainViewDelegate <NSObject>

- (void)wordView:(WordsMainView *)wordView didSelectItemAtIndex:(NSInteger)index;
- (void)wordView:(WordsMainView *)wordView didDeselectItemAtIndex:(NSInteger)index;
- (BOOL)wordView:(WordsMainView *)wordView isShowItemAtIndex:(NSInteger)index;
- (BOOL)wordView:(WordsMainView *)wordView isEnableForItemAtIndex:(NSInteger)index;
- (NSString *)wordView:(WordsMainView *)wordView titleForItemAtIndex:(NSInteger)index;
- (NSInteger)numbersOfItemsInWordView:(WordsMainView *)wordView;

@end

@interface WordsMainView : UIView

@property (nonatomic, strong) UILabel *timerLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *selectItemLabel;
@property (nonatomic, weak) id<WordsMainViewDelegate>delegate;

- (void)showContentLabel;
- (void)reloadData;
@end
