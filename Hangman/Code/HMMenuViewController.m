//
//  HMMenuViewController.m
//  Hangman
//
//  Created by Phil Cai on 15/6/23.
//  Copyright © 2015年 Phil Cai. All rights reserved.
//

#import "HMMenuViewController.h"
#import "HMRequestCenter.h"
@interface HMMenuViewController()
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *resultButton;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@end
@implementation HMMenuViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

//- (void)viewDidLayoutSubviews{
//    PHLog(@"%@",NSStringFromCGRect(self.nextButton.frame));
//}
- (IBAction)backButtonAction:(id)sender {
    PHLog(@"  ");
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)nextButtonAction:(id)sender {
        PHLog(@"  ");
    if (_delegate) {
        [_delegate hmMenuNextAction];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)seeResultButtonAction:(id)sender {
    if (_delegate) {
        [_delegate hmMenuSeeResultAction];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)submitButtonAction:(id)sender {

    [self dismissViewControllerAnimated:YES completion:nil];
    if (_delegate) {
        [_delegate hmMenuSubmitAction];
    }
}
- (IBAction)quitButtonAction:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
    if (_delegate) {
        [_delegate hmMenuQuitGameAction];
    }

}

@end
