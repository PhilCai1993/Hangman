//
//  HMMenuViewController.h
//  Hangman
//
//  Created by Phil Cai on 15/6/23.
//  Copyright © 2015年 Phil Cai. All rights reserved.
//

#import "VVBlurViewController.h"
@protocol HMMenuDelegate
@optional
- (void)hmMenuNextAction;
- (void)hmMenuSeeResultAction;
- (void)hmMenuSubmitAction;
- (void)hmMenuQuitGameAction;
@end
@interface HMMenuViewController : VVBlurViewController
@property (nonatomic, weak) id<HMMenuDelegate>delegate;
@end
