//
//  HomeViewController.m
//  Hangman
//
//  Created by Phil Cai on 15/6/22.
//  Copyright © 2015年 Phil Cai. All rights reserved.
//

#import "HomeViewController.h"
#import <UIColor+MLPFlatColors.h>
#import "HMGameInfo.h"
#import "HMGameViewController.h"
#import "HMRecordViewController.h"
@interface HomeViewController (){
    BOOL isLoading;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *startGameButtonCenterXConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *authorButtonCenterXConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *recordButtonCenterXConstraint;
@property (weak, nonatomic) IBOutlet UIButton *startGameButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *continueButtonCenterXConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *continueToStartVerticalConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *recordToContinueVerticalConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *recordToStartVerticalConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *continueToViewTopConstraint;

@end
NSString* const Segue_StartGame = @"Segue_StartGame";

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUI];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self executeAnimation];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.startGameButtonCenterXConstraint.constant = 300.f;
    self.authorButtonCenterXConstraint.constant = 300.f;
    self.recordButtonCenterXConstraint.constant = 300.f;
    self.continueButtonCenterXConstraint.constant = 300.f;
    [self.view layoutIfNeeded];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)startGameButtonDidPress:(UIButton *)button {
    [SVProgressHUD showWithStatus:@"Loading new game" maskType:SVProgressHUDMaskTypeBlack];
    [[HMRequestCenter requestCenter] requestJsonDataWithType:HMRequestTypeStartGame otherValue:nil completion:^(BOOL success, NSDictionary *dict) {
        if (success) {
            HMGameInfo *gameInfo = [HMGameInfo currentGameInfo];
            NSString *message = dict[@"message"];
            NSString *sessionId = dict[@"sessionId"];
            NSDictionary *data = dict[@"data"];
            NSNumber *numberOfWordsToGuess = data[@"numberOfWordsToGuess"];
            NSNumber *numberOfGuessAllowedForEachWord = data[@"numberOfGuessAllowedForEachWord"];
            gameInfo.sessionId = sessionId;
            gameInfo.numberOfWordsToGuess = numberOfWordsToGuess;
            gameInfo.numberOfGuessAllowedForEachWord = numberOfGuessAllowedForEachWord;
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            HMGameViewController *gameViewController = [sb instantiateViewControllerWithIdentifier:@"HMGameViewControllerIdentifier"];
            gameViewController.sessionId = sessionId;
            [self presentViewController:gameViewController animated:YES completion:^{
                
            }];
            [SVProgressHUD dismiss];
            
//            [self performSegueWithIdentifier:Segue_StartGame sender:nil];
        }else {
            [SVProgressHUD showInfoWithStatus:@"Please check your network connection"];
        }
    }];
}

- (IBAction)continueButtonDidPress:(id)sender {
    HMGameInfo *gameInfo = [HMGameInfo currentGameInfo];
    NSString *sessionId = gameInfo.sessionId;
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HMGameViewController *gameViewController = [sb instantiateViewControllerWithIdentifier:@"HMGameViewControllerIdentifier"];
    gameViewController.sessionId = sessionId;
    [self presentViewController:gameViewController animated:YES completion:^{
        
    }];
}
- (IBAction)recordButtonDidPress:(id)sender {
//    [self gameOver];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HMRecordViewController *gameViewController = [sb instantiateViewControllerWithIdentifier:@"HMRecordViewControllerIdentifier"];
    [self presentViewController:gameViewController animated:YES completion:^{
        
    }];

    
    
}
- (void)gameOver {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"HangMan" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *checkResult = [UIAlertAction actionWithTitle:@"Result" style:UIAlertActionStyleDefault handler:^(UIAlertAction * __nonnull action) {
        
    }];
    UIAlertAction *nextWord = [UIAlertAction actionWithTitle:@"Next" style:UIAlertActionStyleDefault handler:^(UIAlertAction * __nonnull action) {
        
    }];
    [alert addAction:checkResult];
    [alert addAction:nextWord];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
  
}

- (IBAction)authorButtonDidPress:(id)sender {
}

- (void)prepareForSegue:(nonnull UIStoryboardSegue *)segue sender:(nullable id)sender {
    PHLog(@"%@",segue.identifier);
    if ([segue.identifier isEqualToString:Segue_StartGame]) {
        //            ViewController *viewController = segue.destinationViewController;
    }
}




#pragma mark - UI
- (void)updateUI {
    HMGameInfo *gameInfo = [HMGameInfo currentGameInfo];
    NSString *sessionId = gameInfo.sessionId;
    if (sessionId) {
        //        已经有正在进行的游戏
        self.continueToStartVerticalConstraint.priority = 800;
        self.recordToContinueVerticalConstraint.priority = 800;
        self.recordToStartVerticalConstraint.priority = 500;
        self.continueToViewTopConstraint.priority = 500;

        
    }else {
        //        没有正在进行的游戏
        self.continueToStartVerticalConstraint.priority = 500;
        self.recordToContinueVerticalConstraint.priority = 500;
        self.recordToStartVerticalConstraint.priority = 800;
        self.continueToViewTopConstraint.priority = 800;
    }
}
- (void)executeAnimation {
    HMGameInfo *gameInfo = [HMGameInfo currentGameInfo];
    NSString *sessionId = gameInfo.sessionId;
    if (sessionId) {
        self.startGameButtonCenterXConstraint.constant = 0.f;
        [UIView animateWithDuration:0.3 delay:0.01 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            self.continueButtonCenterXConstraint.constant = 0.f;
            [UIView animateWithDuration:0.3 delay:0.01 usingSpringWithDamping:0.5 initialSpringVelocity:0.4 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                self.recordButtonCenterXConstraint.constant = 0.f;
                [UIView animateWithDuration:0.3 delay:0.01 usingSpringWithDamping:0.5 initialSpringVelocity:0.3 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                    [self.view layoutIfNeeded];
                } completion:^(BOOL finished) {
                    self.authorButtonCenterXConstraint.constant = 0.f;
                    [UIView animateWithDuration:0.3 delay:0.01 usingSpringWithDamping:0.5 initialSpringVelocity:0.3 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                        [self.view layoutIfNeeded];
                    } completion:^(BOOL finished) {
                    }];
                }];
            }];
        }];
    }else {
        self.startGameButtonCenterXConstraint.constant = 0.f;
        [UIView animateWithDuration:0.3 delay:0.01 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            self.recordToStartVerticalConstraint.constant = 0.f;
            [UIView animateWithDuration:0.3 delay:0.01 usingSpringWithDamping:0.5 initialSpringVelocity:0.4 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                self.authorButtonCenterXConstraint.constant = 0.f;
                [UIView animateWithDuration:0.3 delay:0.01 usingSpringWithDamping:0.5 initialSpringVelocity:0.3 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                    [self.view layoutIfNeeded];
                } completion:^(BOOL finished) {
                }];
            }];
        }];
    }
    
    
}
@end
