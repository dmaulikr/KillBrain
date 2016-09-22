//
//  MemonryNumsView.h
//  KillBrain
//
//  Created by Li Kelin on 16/8/24.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//


#import <UIKit/UIKit.h>

@class MemonryNumsView;
@protocol MemonryNumsViewDelegate <NSObject>
- (void)memonryView:(MemonryNumsView *)memonryView didSelectAtIndex:(NSInteger)index;
- (void)memonryView:(MemonryNumsView *)memonryView didDeselectAtIndex:(NSInteger)index;
- (BOOL)memonryView:(MemonryNumsView *)memonryView isSelectedAtIndex:(NSInteger)index;
@end


@interface MemonryNumsView : UIView

@property (nonatomic, strong) UILabel *countTimeLabel;
@property (nonatomic, strong) UILabel *leaveCountLabel;

@property (nonatomic, weak) id<MemonryNumsViewDelegate>delegate;

- (void)showNumButtonsViewWithArray:(NSArray *)datas enable:(BOOL)enable;
- (void)addCoverViewCompletion:(void (^)())completion;
- (void)removeCoverView;

- (void)showLeaveCountLabel;
- (void)hiddenLeaveCountLabel;

@end
