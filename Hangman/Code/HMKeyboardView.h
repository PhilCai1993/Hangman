//
//  HMKeyboardView.h
//  Hangman
//
//  Created by Phil Cai on 15/6/21.
//  Copyright © 2015年 Phil Cai. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HMKeyboardDelegate
@optional
- (void)keyButtonDidPress:(UIButton *)button;
- (void)okButtonDidPress:(UIButton *)button;
@end

@interface HMKeyboardView : UIView
@property (nonatomic, weak) id <HMKeyboardDelegate> delegate;
- (void) resetKeyBoard;
@end
