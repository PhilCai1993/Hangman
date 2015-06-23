//
//  HMKeyboardView.m
//  Hangman
//
//  Created by Phil Cai on 15/6/21.
//  Copyright © 2015年 Phil Cai. All rights reserved.
//

#import "HMKeyboardView.h"
#import <UIColor+MLPFlatColors.h>
@interface HMKeyboardView()
@property (nonatomic, strong) NSMutableArray<UIButton *> *buttons;
@end
@implementation HMKeyboardView
#pragma mark - public method
- (void)resetKeyBoard {
    [self.buttons enumerateObjectsUsingBlock:^(UIButton * __nonnull obj, NSUInteger idx, BOOL * __nonnull stop) {
        obj.hidden = NO;
        obj.backgroundColor = [UIColor randomFlatDarkColor];
    }];
    self.backgroundColor = [UIColor randomFlatLightColor];
}

#pragma mark - init
- (instancetype)init{
    self = [super init];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        [self setupUI];
    }
    return self;
}
- (NSMutableArray<UIButton *> *)buttons{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}
#pragma mark - setupUI
- (void)setupUI {
//    背景
    self.backgroundColor = [UIColor randomFlatLightColor];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_height).multipliedBy(7./4.);
    }];
//    字母
    NSArray *alphas = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    for (int i = 0; i < alphas.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.translatesAutoresizingMaskIntoConstraints = NO;
        [btn setTitle:alphas[i] forState:UIControlStateNormal];
        btn.titleLabel.textColor = [UIColor flatWhiteColor];
        btn.backgroundColor = [UIColor randomFlatDarkColor];
        [self addSubview:btn];
        btn.tag = i;
        [btn addTarget:self action:@selector(alphaButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttons addObject:btn];
    }
    for (int i = 0; i < alphas.count; i++) {
        UIButton *btn = self.buttons[i];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.mas_width).multipliedBy(1./7.);
            make.height.equalTo(btn.mas_width);
        }];
        if (i%7 == 0) {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left);
                if (i!=21) {
                    make.bottom.equalTo(self.buttons[i+7].mas_top);
                }else {
                    make.bottom.equalTo(self.mas_bottom);
                }
            }];
        }else {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.buttons[i-1].mas_right);
                make.top.equalTo(self.buttons[i-1].mas_top);
            }];
        }
    }
//     OK按钮
    UIButton *okButton = [[UIButton alloc] init];
    okButton.translatesAutoresizingMaskIntoConstraints = NO;
    okButton.backgroundColor = [UIColor flatDarkBlueColor];
    [okButton setTitle:@"Menu" forState:UIControlStateNormal];
    [okButton addTarget:self action:@selector(okButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:okButton];
    [okButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([self.buttons lastObject].mas_right);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.buttons[14].mas_bottom);
        make.bottom.equalTo(self.mas_bottom);
    }];
}
#pragma mark - button events
- (void)alphaButtonAction:(UIButton *)button {
    if (_delegate) {
        [_delegate keyButtonDidPress:button];
    }
}
- (void)okButtonAction:(UIButton *)button {
    if (_delegate) {
        [_delegate okButtonDidPress:button];
    }
}


@end
