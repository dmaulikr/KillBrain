//
//  WordsLinkProtocol.h
//  KillBrain
//
//  Created by Li Kelin on 16/9/1.
//  Copyright © 2016年 Li Kelin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WordsLinkController.h"
#import "WordsMainView.h"

@interface WordsLinkProtocol : NSObject<WordsMainViewDelegate>
@property (nonatomic, strong) WordsLinkController *controller;
@end
