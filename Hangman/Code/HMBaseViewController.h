//
//  HMBaseViewController.h
//  Hangman
//
//  Created by Phil Cai on 15/6/22.
//  Copyright © 2015年 Phil Cai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMRequestCenter.h"
#import "HMKeyboardView.h"
#import "HMStringChecker.h"
#import <SVProgressHUD.h>
@class HMKeyboardView;
@interface HMBaseViewController : UIViewController<HMKeyboardDelegate>
@property (nonatomic, assign, readonly) BOOL isKeyboardShown;
- (void)showKeyboard;
- (void)hideKeyboard;
- (void)resetKeyBoard;
@end
