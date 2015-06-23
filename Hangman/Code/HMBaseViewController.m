//
//  HMBaseViewController.m
//  Hangman
//
//  Created by Phil Cai on 15/6/22.
//  Copyright © 2015年 Phil Cai. All rights reserved.
//

#import "HMBaseViewController.h"
#import "HMKeyboardView.h"
#import <UIColor+MLPFlatColors.h>
#import <Masonry.h>
@interface HMBaseViewController ()
@property (nonatomic, strong) HMKeyboardView *keyboardView;
@property (nonatomic, weak) MASConstraint *keyboardConstraint;

@end

@implementation HMBaseViewController
#pragma mark - init
- (HMKeyboardView *)keyboardView{
    if (!_keyboardView) {
        _keyboardView = [HMKeyboardView new];
        _keyboardView.delegate = self;
        [self.view addSubview:_keyboardView];
    }
    return _keyboardView;
}

#pragma mark - viewlife
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBasicUI];
    [self setupKeyboard];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
//    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - UI Setups
- (void)setupBasicUI {
//    backgroundColor
    self.view.backgroundColor = [UIColor flatBlackColor];
//    bottom label
    UILabel *infoLabel = [[UILabel alloc] init];
    infoLabel.translatesAutoresizingMaskIntoConstraints = NO;
    infoLabel.textColor = [UIColor flatDarkWhiteColor];
    infoLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
    infoLabel.backgroundColor = [UIColor clearColor];
    infoLabel.text = @"HangMan by Phil";
    [self.view addSubview:infoLabel];
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).offset(-2);
        make.height.equalTo(@(20.));
    }];
}
- (void)setupKeyboard {
    [self.keyboardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        self.keyboardConstraint = make.bottom.equalTo(self.view.mas_bottom).offset(300);
    }];
}
#pragma mark - setter
- (void)setIsKeyboardShown:(BOOL)isKeyboardShown {
    _isKeyboardShown = isKeyboardShown;
    CGFloat newBottomMargin = 0;//出现
    if (!_isKeyboardShown) {
        newBottomMargin = 300;//隐藏
    }
    self.keyboardConstraint.offset(newBottomMargin);
    UIViewAnimationOptions options = UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction;
    [UIView animateWithDuration:0.8 delay:0.2 usingSpringWithDamping:0.5 initialSpringVelocity:0.8 options:options animations:^{
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
    
}


#pragma mark - public method
- (void)showKeyboard{
    self.isKeyboardShown = YES;
}
- (void)hideKeyboard{
    self.isKeyboardShown = NO;
}
- (void)resetKeyBoard {
    [self.keyboardView resetKeyBoard];
}
@end
